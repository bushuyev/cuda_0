#include "util.h"
#include <assert.h>
#include <cuda_runtime.h>
#include <stdio.h>

__global__ void testKernel(int val) {

  val *= 20;
  printf("vall=%d\n", val);
  test_u();
}

int main(int argc, char **argv) {
  cudaSetDevice(0); // Ensure device is set

  printf("printf() is called. Output:\n\n");

  dim3 dimGrid(1, 1);
  dim3 dimBlock(1, 1, 1);
  testKernel<<<dimGrid, dimBlock>>>(10);
  cudaError_t err = cudaDeviceSynchronize();
  if (err != cudaSuccess) {
    fprintf(stderr, "CUDA error: %s\n", cudaGetErrorString(err));
    return EXIT_FAILURE;
  }

  return EXIT_SUCCESS;
}
