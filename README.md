# Cuda_Matrix_Multiplication

Algorithm Description
Algorithm handles all matrices as square matrix. During research I have found that square matrices are multiplied in shorter times. For example multiplying 1024x1024 by 1024x1024 matrix takes 4 times less duration than 1024x1024 by 1024x1023 matrix, so I have transformed the matrices to square matrices by equalizing their dimension and filling empty places with zeros according to block size.

In the kernel because of the shared memory usage and its size limitations I have found solution from web [1] named “tiling”. By dividing the matrices to square tiles algorithm founds the one part of the resulting element and then considering other tiles and their result it finds one element of the resulting matrix. While using tiling solution and shared memory, there are two important things: Coalesced memory access and bank conflict. In order to prevent from uncoalesced access tiles are taken from global memory to shared memory row by row by as big as block size. When reaching to shared memory matrices elements corresponds to different banks which can be seen from code, so bank conflict is prevented in this way.

Another important point using shared memory is synchronization of threads. __syncthreads() is used in order to fill shared memory before calculation start. If calculation phase starts before filling the shared memory threads will reach to empty places.

