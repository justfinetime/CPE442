CXX = g++
CXXFLAGS = -Wall -Wextra -O3 -ftree-vectorize -pthread $(shell pkg-config --cflags opencv4)
LDLIBS = $(shell pkg-config --libs opencv4)

all: sobel_filter

sobel_filter: sobel_filter.cpp
	$(CXX) $(CXXFLAGS) $< -o $@ $(LDLIBS) -pthread

sobel_filter.s: sobel_filter.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

memory_traversal: memory_traversal.cpp
	$(CXX) $(CXXFLAGS) $< -o $@

clean:
	-rm -rf sobel_filter memory_traversal
