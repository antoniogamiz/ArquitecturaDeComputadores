#!/usr/bin/bash

#Se asigna al trabajo el nombre listado1_omp_for
#PBS -N listado1_omp_for
#Se asigna al trabajo la cola ac
#PBS -q ac
#Se imprime información del trabajo usando variables de entorno de PBS.

export OMP_DYNAMIC=FALSE
export OMP_NUM_THREADS=24

echo "Id. usuario del trabajo: $PBS_O_LOGNAME"
echo "Id. del trabajo: $PBS_JOBID"
echo "Nombre del trabajo especificando usuario: $PBS_JOBNAME"
echo "Nodo que ejecuta qsub: $PBS_O_HOST"
echo "Directorio en el que se ha ejecutado qsub: $PBS_O_WORKDIR"
echo "Cola: $PBS_QUEUE"
echo "Nodos asignados al trabajo:"

cat $PBS_NODEFILE

for ((N=16384;N<67108865; N=N*2))
do
    time $PBS_O_WORKDIR/listado1_omp_for $N
done


