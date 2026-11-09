#include <opencv2/opencv.hpp>

#include <cerrno>
#include <climits>
#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>

uchar getGray(const cv::Mat& frame, int y, int x) {
    const cv::Vec3b pixel = frame.at<cv::Vec3b>(y, x);
    return cv::saturate_cast<uchar>(
        pixel[0] * 0.0722f + pixel[1] * 0.7152f + pixel[2] * 0.2126f);
}

void sobelReference(const cv::Mat& frame, cv::Mat& output) {
    for (int y = 1; y < frame.rows - 1; ++y) {
        for (int x = 1; x < frame.cols - 1; ++x) {
            const int gx =
                -getGray(frame, y - 1, x - 1) + getGray(frame, y - 1, x + 1) -
                2 * getGray(frame, y,     x - 1) + 2 * getGray(frame, y,     x + 1) -
                getGray(frame, y + 1, x - 1) + getGray(frame, y + 1, x + 1);
            const int gy =
                -getGray(frame, y - 1, x - 1) - 2 * getGray(frame, y - 1, x) -
                getGray(frame, y - 1, x + 1) + getGray(frame, y + 1, x - 1) +
                2 * getGray(frame, y + 1, x) + getGray(frame, y + 1, x + 1);
            const uchar edge = cv::saturate_cast<uchar>(std::sqrt(gx * gx + gy * gy));
            output.at<cv::Vec3b>(y, x) = cv::Vec3b(edge, edge, edge);
        }
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
    for (int i = 1; i < argc; ++i) {
        if (std::strcmp(argv[i], "--input") == 0 && i + 1 < argc) {
            inputPath = argv[++i];
        } else if (std::strcmp(argv[i], "--output") == 0 && i + 1 < argc) {
            outputPath = argv[++i];
        } else if (std::strcmp(argv[i], "--iterations") == 0 && i + 1 < argc) {
            char* end = nullptr;
            errno = 0;
            iterations = std::strtol(argv[++i], &end, 10);
            if (errno != 0 || *end != '\0' || iterations < 1 || iterations > INT_MAX) {
                std::fprintf(stderr, "--iterations must be a positive integer\n");
                return 1;
            }
        } else {
            std::fprintf(stderr, "Usage: %s --input video.mp4 --iterations N [--output image.png]\n", argv[0]);
            return 1;
        }
    }
    if (inputPath == nullptr || iterations == 0) {
        std::fprintf(stderr, "Usage: %s --input video.mp4 --iterations N [--output image.png]\n", argv[0]);
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
    for (long iteration = 0; iteration < iterations; ++iteration) {
        sobelReference(frame, output);
    }
    if (outputPath != nullptr && !cv::imwrite(outputPath, output)) {
        std::fprintf(stderr, "Could not write %s\n", outputPath);
        return 1;
    }

    std::printf("configuration=original threads=1 iterations=%ld checksum=%llu\n",
                iterations, static_cast<unsigned long long>(checksum(output)));
    return 0;
}
