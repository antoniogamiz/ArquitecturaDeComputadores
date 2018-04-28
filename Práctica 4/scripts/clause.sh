#!/usr/bin/bash

#echo "Script para elegir entre 'static', 'dynamic' o 'guided'"

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
else
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

    ./bin/pmtv-OpenMP 16128 $2
fi
