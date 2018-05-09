#!/usr/bin/bash

export OMP_DYNAMIC=FALSE

for ((N=1;N<5;N=N+1))
do
    export OMP_NUM_THREADS=$N
    # ./bin/pmm-OpenMP 700
    ./bin/pmm-OpenMP 1000
done
