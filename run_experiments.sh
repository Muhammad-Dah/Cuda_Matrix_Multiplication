#!/bin/bash

if [[ -f a.out ]]; then
  rm a.out
fi  
nvcc matrix_multiplication.cu
echo "***  STARTING EXPERIMENTS ***"

for N in 16 128 512 1024
do
 ./a.out -N ${N}  -dim 32 32
done

echo "*** DONE ***"












