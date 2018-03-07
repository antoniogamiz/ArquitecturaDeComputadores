#!/usr/bin/bash

for ((N=65536;N<67108865;N=N*2))
do
    ~/ArquitecturaDeComputadores/bin/SumaVectoresC $N >> ~/ArquitecturaDeComputadores/output/SumaVectores_output_local.txt
done

