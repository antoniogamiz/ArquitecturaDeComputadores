#!/usr/bin/bash

#PBS -N atcgrid_secuencial
#PBS -q ac

echo "Id. usuario del trabajo: $PBS_O_LOGNAME"
echo "Id. del trabajo: $PBS_JOBID"
echo "Nombre del trabajo especificando usuario: $PBS_JOBNAME"
echo "Nodo que ejecuta qsub: $PBS_O_HOST"
echo "Directorio en el que se ha ejecutado qsub: $PBS_O_WORKDIR"
echo "Cola: $PBS_QUEUE"
echo "Nodos asignados al trabajo:"

cat $PBS_NODEFILE

clear

for ((N=1;N<13;N=N+1))
do
    $PBS_O_WORKDIR/pmv-secuencial 15000
    $PBS_O_WORKDIR/pmv-secuencial 30000
done
