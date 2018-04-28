#!/usr/bin/bash

#PBS -N atcgrid_pmtv_omp
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

function ejecutar()
{
    if [ "$1" == "static" ]; then
        echo "'static' schedule elegido"
        export OMP_SCHEDULE="static"
    fi

    if [ "$1" == "dynamic" ]; then
        echo "'dynamic' schedule elegido"
        export OMP_SCHEDULE="dynamic"
    fi

    if [ "$1" == "guided" ]; then
        echo "'guided' schedule elegido"
        export OMP_SCHEDULE="guided"
    fi

    $PBS_O_WORKDIR/pmtv-OpenMP 16128 $2
}

export OMP_NUM_THREADS=12

#Por defecto
ejecutar static -1
ejecutar dynamic -1
ejecutar guided -1

#chunk=1
ejecutar static 1
ejecutar dynamic 1
ejecutar guided 1

#chunk=64
ejecutar static 64
ejecutar dynamic 64
ejecutar guided 64
