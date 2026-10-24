#include <chrono>
#include <cstdio>
#include <vector>

void testTraversal(int rows, int columns) {
    // A vector is stored contiguously, like a row-major 2-D array.
    std::vector<int> array(rows * columns);

    // Initialize every element before timing.
    for (int index = 0; index < rows * columns; index++) {
        array[index] = 1;
    }

    long long rowMajorChecksum = 0;
    auto start = std::chrono::high_resolution_clock::now();

    // Row-major: finish one row before moving to the next row.
    for (int row = 0; row < rows; row++) {
        for (int column = 0; column < columns; column++) {
            rowMajorChecksum += array[row * columns + column];
        }
    }

    auto end = std::chrono::high_resolution_clock::now();
    double rowMajorMs = std::chrono::duration<double, std::milli>(end - start).count();

    long long columnMajorChecksum = 0;
    start = std::chrono::high_resolution_clock::now();

    // Column-major: finish one column before moving to the next column.
    for (int column = 0; column < columns; column++) {
        for (int row = 0; row < rows; row++) {
            columnMajorChecksum += array[row * columns + column];
        }
    }

    end = std::chrono::high_resolution_clock::now();
    double columnMajorMs = std::chrono::duration<double, std::milli>(end - start).count();

    int elements = rows * columns;
    double bytes = elements * sizeof(int);

    std::printf("\nArray: %d x %d\n", rows, columns);
    std::printf("Array size: %.2f KiB\n", bytes / 1024.0);
    std::printf("Row-major time: %.3f ms\n", rowMajorMs);
    std::printf("Column-major time: %.3f ms\n", columnMajorMs);
    std::printf("Row-major time per element: %.3f ns\n", rowMajorMs * 1000000.0 / elements);
    std::printf("Column-major time per element: %.3f ns\n", columnMajorMs * 1000000.0 / elements);
    std::printf("Row-major speedup: %.2fx\n", columnMajorMs s/ rowMajorMs);
    std::printf("Row-major checksum: %lld\n", rowMajorChecksum);
    std::printf("Column-major checksum: %lld\n", columnMajorChecksum);
    std::printf("Checksums identical: %s\n",
                rowMajorChecksum == columnMajorChecksum ? "yes" : "no");
}

int main() {
    testTraversal(64, 64);       // small: 16 KiB
    testTraversal(1024, 1024);   // medium: 4 MiB
    testTraversal(4096, 4096);   // large: 64 MiB
    return 0;
}
