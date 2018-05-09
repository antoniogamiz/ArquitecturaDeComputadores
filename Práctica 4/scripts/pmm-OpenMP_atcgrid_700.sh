#!/usr/bin/bash

#PBS -N atcgrid_pmm-OpenMP_700
#PBS -q ac

export OMP_DYNAMIC=FALSE

echo "Id. usuario del trabajo: $PBS_O_LOGNAME"
echo "Id. del trabajo: $PBS_JOBID"
echo "Nombre del trabajo especificando usuario: $PBS_JOBNAME"
echo "Nodo que ejecuta qsub: $PBS_O_HOST"
echo "Directorio en el que se ha ejecutado qsub: $PBS_O_WORKDIR"
echo "Cola: $PBS_QUEUE"
echo "Nodos asignados al trabajo:"

cat $PBS_NODEFILE

for ((N=1;N<13;N=N+1))
do
    export OMP_NUM_THREADS=$N
    $PBS_O_WORKDIR/pmm-OpenMP 700
done
