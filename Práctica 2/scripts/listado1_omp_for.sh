#!/usr/bin/bash

export OMP_DYNAMIC=FALSE
export OMP_NUM_THREADS=8

for ((N=16384;N<67108865;N=N*2))
do
    ./bin/listado1_omp_for $N
done
