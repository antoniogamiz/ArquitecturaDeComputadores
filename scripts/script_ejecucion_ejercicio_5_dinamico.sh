#!/usr/bin/bash

for ((N=65536;N<67108865;N=N*2))
do
    ./bin/SumaVectoresC_global $N
done
