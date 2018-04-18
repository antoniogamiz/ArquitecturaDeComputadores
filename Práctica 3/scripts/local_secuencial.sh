#!/usr/bin/bash

clear

echo "pmv-secuencial"

for ((N=1;N<5;N=N+1))
do
    ./bin/pmv-OpenMP-a 15000
    ./bin/pmv-OpenMP-a 30000
done
