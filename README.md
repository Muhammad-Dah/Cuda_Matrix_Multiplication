# Cuda_Matrix_Multiplication

# Algorithm Description

Algorithm handles all matrices as square matrix. During research I have found that square matrices are multiplied in shorter times. For example multiplying 1024x1024 by 1024x1024 matrix takes 4 times less duration than 1024x1024 by 1024x1023 matrix, so I have transformed the matrices to square matrices by equalizing their dimension and filling empty places with zeros according to block size.

In the kernel because of the shared memory usage and its size limitations I have found solution from web [1] named “tiling”. By dividing the matrices to square tiles algorithm founds the one part of the resulting element and then considering other tiles and their result it finds one element of the resulting matrix. While using tiling solution and shared memory, there are two important things: Coalesced memory access and bank conflict. In order to prevent from uncoalesced access tiles are taken from global memory to shared memory row by row by as big as block size. When reaching to shared memory matrices elements corresponds to different banks which can be seen from code, so bank conflict is prevented in this way.

Another important point using shared memory is synchronization of threads. `__syncthreads()`  is used in order to fill shared memory before calculation start. If calculation phase starts before filling the shared memory threads will reach to empty places.

## Compilation & Execution

```bash

./run_experiments
./run_experiments_blocking
```

## Block Size

While considering block size checking GPU board’s specs is important. It supports 32 banks while reaching to shared memory so I have used 16 and 32 as block sizes. Different sizes are also tried in order to compare performances. Grid dimension is directly computed according to matrix dimensions.

## Test Results


### Regular matrix multiplication results
![image](https://user-images.githubusercontent.com/37774604/116828747-46c3ec80-aba9-11eb-8ecb-0b300d91a441.png)

### Blocking matrix multiplication results
![image](https://user-images.githubusercontent.com/37774604/116828790-a4583900-aba9-11eb-93c7-b5565ec3301a.png)


## Discussion
Memory is not a problem when global memory is considered because 1024x1024 matrix needs 4MB of space. However, shared memory size is limited and in order to provide concurrent execution of blocks in one SM shared memory must be divided wisely.

## Environment
        Nvidia GeForce GTX850M
        Intel® Core™ i7-4700HQ CPU
        Cuda 10.0, V10.0.130

