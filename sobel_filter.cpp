// #include <opencv2/opencv.hpp>
// #include <cstdio>
// #include <cstdlib>
// #include <cmath>
// #include <chrono>
// #include <algorithm>
// #include <cerrno>
// #include <climits>
// #include <time.h>
// #include <thread>
// #include <vector>
// #include "sobel_filter.hpp"

// uchar getGray(const cv::Mat& frame, int y, int x) {
//     cv::Vec3b pixel = frame.at<cv::Vec3b>(y, x);

//     uint16_t new_pixel_blue =
//         ((uint16_t)pixel[0] * (uint16_t)blue_amount) >> 8;
//     uint16_t new_pixel_green =
//         ((uint16_t)pixel[1] * (uint16_t)green_amount) >> 8;
//     uint16_t new_pixel_red =
//         ((uint16_t)pixel[2] * (uint16_t)red_amount) >> 8;

//     return cv::saturate_cast<uchar>(
//         new_pixel_blue + new_pixel_green + new_pixel_red
//     );
// }

// struct PipelineTiming {
//     double grayscaleMs = 0.0;
//     double sobelMs = 0.0;
// };

// struct WorkerContext {
//     int outputStart = 0;
//     int outputEnd = 0;
//     int grayStart = 0;
//     std::vector<uchar> grayRows;
//     PipelineTiming timing;
// };

// void processBand(const cv::Mat& frame, cv::Mat& output, WorkerContext& worker) {
//     // Include one grayscale halo row above and below this output band so the
//     // Sobel calculation has all three rows it needs without synchronization.
//     const int grayEnd = std::min(frame.rows, worker.outputEnd + 1);
//     const int grayRowCount = grayEnd - worker.grayStart;
//     const size_t graySize = static_cast<size_t>(grayRowCount) * frame.cols;
//     if (worker.grayRows.size() != graySize) {
//         worker.grayRows.resize(graySize);
//     }

//     auto grayscaleStart = std::chrono::high_resolution_clock::now();
//     for (int y = worker.grayStart; y < grayEnd; y++) {
//         uchar* grayRow = worker.grayRows.data() +
//                          static_cast<size_t>(y - worker.grayStart) * frame.cols;

//         for (int x = 0; x < frame.cols; x++) {
//             grayRow[x] = getGray(frame, y, x);
//         }
//     }
//     worker.timing.grayscaleMs = std::chrono::duration<double, std::milli>(
//         std::chrono::high_resolution_clock::now() - grayscaleStart
//     ).count();

//     auto sobelStart = std::chrono::high_resolution_clock::now();
//     for (int y = worker.outputStart; y < worker.outputEnd; y++) {
//         const uchar* previousRow = worker.grayRows.data() +
//             static_cast<size_t>(y - 1 - worker.grayStart) * frame.cols;
//         const uchar* currentRow = worker.grayRows.data() +
//             static_cast<size_t>(y - worker.grayStart) * frame.cols;
//         const uchar* nextRow = worker.grayRows.data() +
//             static_cast<size_t>(y + 1 - worker.grayStart) * frame.cols;
//         cv::Vec3b* outputRow = output.ptr<cv::Vec3b>(y);

//         for (int x = 1; x < frame.cols - 1; x++) {
//             int gx =
//                 -1 * previousRow[x - 1] + 1 * previousRow[x + 1] +
//                 -2 * currentRow[x - 1] + 2 * currentRow[x + 1] +
//                 -1 * nextRow[x - 1] + 1 * nextRow[x + 1];

//             int gy =
//                 -1 * previousRow[x - 1] - 2 * previousRow[x] - 1 * previousRow[x + 1] +
//                  1 * nextRow[x - 1] + 2 * nextRow[x] + 1 * nextRow[x + 1];

//             uchar edge = cv::saturate_cast<uchar>(
//                 std::abs(gx) + std::abs(gy)
//             );

//             outputRow[x] = cv::Vec3b(edge, edge, edge);
//         }
//     }
//     worker.timing.sobelMs = std::chrono::duration<double, std::milli>(
//         std::chrono::high_resolution_clock::now() - sobelStart
//     ).count();
// }

// void parallelPipeline(const cv::Mat& frame,
//                       cv::Mat& output,
//                       std::vector<WorkerContext>& workers,
//                       PipelineTiming& timing) {
//     std::vector<std::thread> threads;
//     threads.reserve(workers.size());

//     for (WorkerContext& worker : workers) {
//         worker.timing = {};
//         threads.emplace_back(processBand, std::cref(frame), std::ref(output),
//                              std::ref(worker));
//     }
//     for (std::thread& thread : threads) {
//         thread.join();
//     }

//     // Workers run concurrently, so the slowest worker approximates the
//     // elapsed contribution of each operation to the parallel pipeline.
//     for (const WorkerContext& worker : workers) {
//         timing.grayscaleMs = std::max(timing.grayscaleMs,
//                                       worker.timing.grayscaleMs);
//         timing.sobelMs = std::max(timing.sobelMs, worker.timing.sobelMs);
//     }
// }

// int main(int argc, char* argv[]) {
//     if (argc != 3) {
//         printf("Usage: ./sobel_filter <video-file> <thread-count>\n");
//         return 1;
//     }

//     char* end = nullptr;
//     errno = 0;
//     const long requestedThreads = std::strtol(argv[2], &end, 10);
//     if (errno != 0 || *argv[2] == '\0' || *end != '\0' ||
//         requestedThreads < 1 || requestedThreads > INT_MAX) {
//         printf("Thread count must be a positive integer\n");
//         return 1;
//     }

//     cv::VideoCapture video(argv[1]);

//     if (!video.isOpened()) {
//         printf("Could not open video\n");
//         return 1;
//     }

//     constexpr int framesToBenchmark = 30;
//     double totalProcessingMs = 0.0;
//     double totalGrayscaleMs = 0.0;
//     double totalSobelMs = 0.0;
//     int framesProcessed = 0;
//     cv::Mat frame;
//     cv::Mat output;
//     std::vector<WorkerContext> workers;

//     while (framesProcessed < framesToBenchmark && video.read(frame)) {
//         // Keep allocation and video decoding out of the timed filter work.
//         if (output.size() != frame.size() || output.type() != frame.type()) {
//             output = cv::Mat::zeros(frame.size(), frame.type());
//             const int outputRows = frame.rows - 2;
//             const int workerCount = std::min(static_cast<int>(requestedThreads),
//                                              outputRows);
//             workers.resize(workerCount);
//             for (int workerIndex = 0; workerIndex < workerCount; workerIndex++) {
//                 WorkerContext& worker = workers[workerIndex];
//                 // Integer division gives contiguous, nearly equal bands and
//                 // assigns any remainder rows exactly once.
//                 worker.outputStart = 1 + (workerIndex * outputRows) / workerCount;
//                 worker.outputEnd = 1 + ((workerIndex + 1) * outputRows) / workerCount;
//                 worker.grayStart = worker.outputStart - 1;
//             }
//         }

//         PipelineTiming frameTiming;
//         auto start = std::chrono::high_resolution_clock::now();
//         parallelPipeline(frame, output, workers, frameTiming);

//         if (framesProcessed == framesToBenchmark - 1) {
//             cv::imwrite("sobel_multithreaded_frame30.png", output);
//         }

//         auto end = std::chrono::high_resolution_clock::now();

//         totalProcessingMs +=
//             std::chrono::duration<double, std::milli>(end - start).count();
//         totalGrayscaleMs += frameTiming.grayscaleMs;
//         totalSobelMs += frameTiming.sobelMs;
//         framesProcessed++;
//     }

//     if (framesProcessed == 0) {
//         printf("Could not read a frame from the video\n");
//         return 1;
//     }

//     const double averageMsPerFrame = totalProcessingMs / framesProcessed;
//     const double averageGrayscaleMs = totalGrayscaleMs / framesProcessed;
//     const double averageSobelMs = totalSobelMs / framesProcessed;
//     const double msPerOutputPixel =
//         averageMsPerFrame / (frame.rows * frame.cols);

//     printf("\nPerformance Results\n");
//     printf("-------------------------------\n");
//     printf("Resolution:        %d x %d\n", frame.cols, frame.rows);
//     printf("Frames processed:  %d\n", framesProcessed);
//     printf("Worker threads:    %zu\n", workers.size());
//     printf("Grayscale time:    %.2f ms total (%.2f ms/frame)\n",
//            totalGrayscaleMs, averageGrayscaleMs);
//     printf("Sobel time:        %.2f ms total (%.2f ms/frame)\n",
//            totalSobelMs, averageSobelMs);
//     printf("Overall time:      %.2f ms total (%.2f ms/frame)\n",
//            totalProcessingMs, averageMsPerFrame);
//     printf("Time per output pixel: %.9f ms\n", msPerOutputPixel);
//     printf("Processing FPS:    %.2f\n", 1000.0 / averageMsPerFrame);

//     return 0;
// }

#include <opencv2/opencv.hpp>
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <chrono>
#include <time.h>
#include "sobel_filter.hpp"

uchar getGray(const cv::Mat& frame, int y, int x) {
    cv::Vec3b pixel = frame.at<cv::Vec3b>(y, x);

    uint16_t new_pixel_blue =
        ((uint16_t)pixel[0] * (uint16_t)blue_amount) >> 8;
    uint16_t new_pixel_green =
        ((uint16_t)pixel[1] * (uint16_t)green_amount) >> 8;
    uint16_t new_pixel_red =
        ((uint16_t)pixel[2] * (uint16_t)red_amount) >> 8;

    return cv::saturate_cast<uchar>(
        new_pixel_blue + new_pixel_green + new_pixel_red
    );
}

struct PipelineTiming {
    double grayscaleMs = 0.0;
    double sobelMs = 0.0;
};

void streamingPipeline(const cv::Mat& frame,
                       cv::Mat grayRows[3],
                       cv::Mat& output,
                       PipelineTiming& timing) {
    // Convert the first three color rows to grayscale.
    auto grayscaleStart = std::chrono::high_resolution_clock::now();
    for (int y = 0; y < 3; y++) {
        uchar* grayRow = grayRows[y].ptr<uchar>(0);

        for (int x = 0; x < frame.cols; x++) {
            grayRow[x] = getGray(frame, y, x);
        }
    }
    timing.grayscaleMs += std::chrono::duration<double, std::milli>(
        std::chrono::high_resolution_clock::now() - grayscaleStart
    ).count();

    int previousIndex = 0;
    int currentIndex = 1;
    int nextIndex = 2;

    // Compute output rows 1 through rows - 2.
    for (int y = 1; y < frame.rows - 1; y++) {
        auto sobelStart = std::chrono::high_resolution_clock::now();
        const uchar* previousRow = grayRows[previousIndex].ptr<uchar>(0);
        const uchar* currentRow = grayRows[currentIndex].ptr<uchar>(0);
        const uchar* nextRow = grayRows[nextIndex].ptr<uchar>(0);
        cv::Vec3b* outputRow = output.ptr<cv::Vec3b>(y);

        for (int x = 1; x < frame.cols - 1; x++) {
            int gx =
                -1 * previousRow[x - 1] + 1 * previousRow[x + 1] +
                -2 * currentRow[x - 1] + 2 * currentRow[x + 1] +
                -1 * nextRow[x - 1] + 1 * nextRow[x + 1];

            int gy =
                -1 * previousRow[x - 1] - 2 * previousRow[x] - 1 * previousRow[x + 1] +
                 1 * nextRow[x - 1] + 2 * nextRow[x] + 1 * nextRow[x + 1];

            uchar edge = cv::saturate_cast<uchar>(
                std::abs(gx) + std::abs(gy)
            );

            outputRow[x] = cv::Vec3b(edge, edge, edge);
        }
        timing.sobelMs += std::chrono::duration<double, std::milli>(
            std::chrono::high_resolution_clock::now() - sobelStart
        ).count();

        // Reuse the oldest buffer for the next grayscale row.
        if (y < frame.rows - 2) {
            grayscaleStart = std::chrono::high_resolution_clock::now();
            uchar* reusedRow = grayRows[previousIndex].ptr<uchar>(0);

            for (int x = 0; x < frame.cols; x++) {
                reusedRow[x] = getGray(frame, y + 2, x);
            }
            timing.grayscaleMs += std::chrono::duration<double, std::milli>(
                std::chrono::high_resolution_clock::now() - grayscaleStart
            ).count();

            int oldPreviousIndex = previousIndex;
            previousIndex = currentIndex;
            currentIndex = nextIndex;
            nextIndex = oldPreviousIndex;
        }
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Usage: ./sobel_filter <video-file>\n");
        return 1;
    }

    cv::VideoCapture video(argv[1]);

    if (!video.isOpened()) {
        printf("Could not open video\n");
        return 1;
    }

    constexpr int framesToBenchmark = 30;
    double totalProcessingMs = 0.0;
    double totalGrayscaleMs = 0.0;
    double totalSobelMs = 0.0;
    int framesProcessed = 0;
    cv::Mat frame;
    cv::Mat output;
    cv::Mat grayRows[3];

    while (framesProcessed < framesToBenchmark && video.read(frame)) {
        // Keep allocation and video decoding out of the timed filter work.
        if (output.size() != frame.size() || output.type() != frame.type()) {
            output = cv::Mat::zeros(frame.size(), frame.type());
            for (int row = 0; row < 3; row++) {
                grayRows[row] = cv::Mat(1, frame.cols, CV_8UC1);
            }
        }

        PipelineTiming frameTiming;
        auto start = std::chrono::high_resolution_clock::now();
        streamingPipeline(frame, grayRows, output, frameTiming);

        if (framesProcessed == framesToBenchmark - 1) {
            cv::imwrite("sobel_single_frame30_old.png", output);
        }

        auto end = std::chrono::high_resolution_clock::now();

        totalProcessingMs +=
            std::chrono::duration<double, std::milli>(end - start).count();
        totalGrayscaleMs += frameTiming.grayscaleMs;
        totalSobelMs += frameTiming.sobelMs;
        framesProcessed++;
    }

    if (framesProcessed == 0) {
        printf("Could not read a frame from the video\n");
        return 1;
    }

    const double averageMsPerFrame = totalProcessingMs / framesProcessed;
    const double averageGrayscaleMs = totalGrayscaleMs / framesProcessed;
    const double averageSobelMs = totalSobelMs / framesProcessed;
    const double msPerOutputPixel =
        averageMsPerFrame / (frame.rows * frame.cols);

    printf("\nPerformance Results\n");
    printf("-------------------------------\n");
    printf("Resolution:        %d x %d\n", frame.cols, frame.rows);
    printf("Frames processed:  %d\n", framesProcessed);
    printf("Grayscale time:    %.2f ms total (%.2f ms/frame)\n",
           totalGrayscaleMs, averageGrayscaleMs);
    printf("Sobel time:        %.2f ms total (%.2f ms/frame)\n",
           totalSobelMs, averageSobelMs);
    printf("Overall time:      %.2f ms total (%.2f ms/frame)\n",
           totalProcessingMs, averageMsPerFrame);
    printf("Time per output pixel: %.9f ms\n", msPerOutputPixel);
    printf("Processing FPS:    %.2f\n", 1000.0 / averageMsPerFrame);

    return 0;
}
