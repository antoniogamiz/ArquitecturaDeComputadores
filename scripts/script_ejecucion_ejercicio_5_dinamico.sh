#!/usr/bin/bash

for ((N=65536;N<67108865;N=N*2))
do
    ~/ArquitecturaDeComputadores/bin/SumaVectoresC_dinamico $N >> ~/ArquitecturaDeComputadores/output/SumaVectores_output_dinamico.txt
done

