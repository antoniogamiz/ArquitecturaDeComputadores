#!/usr/bin/bash

export OMP_DYNAMIC=FALSE

clear

echo "pmv-OpenMP-reduction"

for ((N=1;N<5;N=N+1))
do
    export OMP_NUM_THREADS=$N
    echo "Numero de threads $N"
    ./bin/pmv-OpenMP-reduction 15000
    ./bin/pmv-OpenMP-reduction 30000
done
