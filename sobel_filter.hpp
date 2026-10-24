#ifndef SOBEL_FILTER_H_
#define SOBEL_FILTER_H_

#include <opencv2/opencv.hpp>
#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <chrono>
#include <time.h>

constexpr uint8_t blue_amount = 0.0722f*256;
constexpr uint8_t green_amount = 0.7152f*256;
constexpr uint8_t red_amount = 0.2126f*256;

constexpr uint8_t small_set = 100;
constexpr uint16_t med_set = 5000;
constexpr uint32_t large_set = 100000;

uchar getGray(const cv::Mat& frame, int y, int x);


#endif