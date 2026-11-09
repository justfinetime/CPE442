#include <opencv2/opencv.hpp>

#include <algorithm>
#include <cerrno>
#include <climits>
#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <thread>
#include <vector>

struct WorkerContext {
    int outputStart = 0;
    int outputEnd = 0;
    int grayStart = 0;
    std::vector<uchar> grayRows;
};

uchar getGray(const cv::Vec3b& pixel) {
    return cv::saturate_cast<uchar>(
        pixel[0] * 0.0722f + pixel[1] * 0.7152f + pixel[2] * 0.2126f);
}

void processBand(const cv::Mat& frame, cv::Mat& output, WorkerContext& worker) {
    const int grayEnd = std::min(frame.rows, worker.outputEnd + 1);
    for (int y = worker.grayStart; y < grayEnd; ++y) {
        uchar* grayRow = worker.grayRows.data() +
            static_cast<size_t>(y - worker.grayStart) * frame.cols;
        const cv::Vec3b* frameRow = frame.ptr<cv::Vec3b>(y);
        for (int x = 0; x < frame.cols; ++x) {
            grayRow[x] = getGray(frameRow[x]);
        }
    }

    for (int y = worker.outputStart; y < worker.outputEnd; ++y) {
        const uchar* previous = worker.grayRows.data() +
            static_cast<size_t>(y - 1 - worker.grayStart) * frame.cols;
        const uchar* current = worker.grayRows.data() +
            static_cast<size_t>(y - worker.grayStart) * frame.cols;
        const uchar* next = worker.grayRows.data() +
            static_cast<size_t>(y + 1 - worker.grayStart) * frame.cols;
        cv::Vec3b* outputRow = output.ptr<cv::Vec3b>(y);
        for (int x = 1; x < frame.cols - 1; ++x) {
            const int gx = -previous[x - 1] + previous[x + 1] -
                           2 * current[x - 1] + 2 * current[x + 1] -
                           next[x - 1] + next[x + 1];
            const int gy = -previous[x - 1] - 2 * previous[x] - previous[x + 1] +
                           next[x - 1] + 2 * next[x] + next[x + 1];
            const uchar edge = cv::saturate_cast<uchar>(std::sqrt(gx * gx + gy * gy));
            outputRow[x] = cv::Vec3b(edge, edge, edge);
        }
    }
}

void parallelPipeline(const cv::Mat& frame, cv::Mat& output,
                      std::vector<WorkerContext>& workers) {
    std::vector<std::thread> threads;
    threads.reserve(workers.size());
    for (WorkerContext& worker : workers) {
        threads.emplace_back(processBand, std::cref(frame), std::ref(output),
                             std::ref(worker));
    }
    for (std::thread& thread : threads) {
        thread.join();
    }
}

std::uint64_t checksum(const cv::Mat& image) {
    std::uint64_t value = 1469598103934665603ULL;
    const size_t byteCount = image.total() * image.elemSize();
    for (size_t i = 0; i < byteCount; ++i) {
        value = (value ^ image.data[i]) * 1099511628211ULL;
    }
    return value;
}

int main(int argc, char* argv[]) {
    const char* inputPath = nullptr;
    const char* outputPath = nullptr;
    long iterations = 0;
    long requestedThreads = 0;
    for (int i = 1; i < argc; ++i) {
        if (std::strcmp(argv[i], "--input") == 0 && i + 1 < argc) {
            inputPath = argv[++i];
        } else if (std::strcmp(argv[i], "--output") == 0 && i + 1 < argc) {
            outputPath = argv[++i];
        } else if ((std::strcmp(argv[i], "--iterations") == 0 ||
                    std::strcmp(argv[i], "--threads") == 0) && i + 1 < argc) {
            const bool isIterations = std::strcmp(argv[i], "--iterations") == 0;
            char* end = nullptr;
            errno = 0;
            const long value = std::strtol(argv[++i], &end, 10);
            if (errno != 0 || *end != '\0' || value < 1 || value > INT_MAX) {
                std::fprintf(stderr, "Numeric options must be positive integers\n");
                return 1;
            }
            if (isIterations) {
                iterations = value;
            } else {
                requestedThreads = value;
            }
        } else {
            std::fprintf(stderr, "Usage: %s --input video.mp4 --threads N --iterations N [--output image.png]\n", argv[0]);
            return 1;
        }
    }
    if (inputPath == nullptr || iterations == 0 || requestedThreads == 0) {
        std::fprintf(stderr, "Usage: %s --input video.mp4 --threads N --iterations N [--output image.png]\n", argv[0]);
        return 1;
    }

    cv::VideoCapture video(inputPath);
    cv::Mat frame;
    if (!video.isOpened() || !video.read(frame) || frame.empty()) {
        std::fprintf(stderr, "Could not load the first frame from %s\n", inputPath);
        return 1;
    }
    if (frame.rows < 3 || frame.cols < 3 || frame.type() != CV_8UC3) {
        std::fprintf(stderr, "Input must contain a BGR frame at least 3 by 3 pixels\n");
        return 1;
    }

    cv::Mat output = cv::Mat::zeros(frame.size(), frame.type());
    const int outputRows = frame.rows - 2;
    const int workerCount = std::min(static_cast<int>(requestedThreads), outputRows);
    std::vector<WorkerContext> workers(workerCount);
    for (int index = 0; index < workerCount; ++index) {
        WorkerContext& worker = workers[index];
        worker.outputStart = 1 + (index * outputRows) / workerCount;
        worker.outputEnd = 1 + ((index + 1) * outputRows) / workerCount;
        worker.grayStart = worker.outputStart - 1;
        const int grayEnd = std::min(frame.rows, worker.outputEnd + 1);
        worker.grayRows.resize(static_cast<size_t>(grayEnd - worker.grayStart) * frame.cols);
    }

    for (long iteration = 0; iteration < iterations; ++iteration) {
        parallelPipeline(frame, output, workers);
    }
    if (outputPath != nullptr && !cv::imwrite(outputPath, output)) {
        std::fprintf(stderr, "Could not write %s\n", outputPath);
        return 1;
    }

    std::printf("configuration=optimized threads=%d iterations=%ld checksum=%llu\n",
                workerCount, iterations, static_cast<unsigned long long>(checksum(output)));
    return 0;
}
