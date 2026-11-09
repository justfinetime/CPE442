CXX := g++
WARNINGS := -Wall -Wextra
OPENCV_CFLAGS := $(shell pkg-config --cflags opencv4)
OPENCV_LIBS := $(shell pkg-config --libs opencv4)

all: sobel_original sobel_optimized

sobel_original: sobel_filter_old.cpp
	$(CXX) $(WARNINGS) -O3 $(OPENCV_CFLAGS) $< -o $@ $(OPENCV_LIBS)

sobel_optimized: sobel_filter_multithread.cpp
	$(CXX) $(WARNINGS) -O3 -ftree-vectorize -pthread $(OPENCV_CFLAGS) $< -o $@ $(OPENCV_LIBS)

clean:
	rm -f sobel_original sobel_optimized

.PHONY: all clean
