
//Compilacion: gcc -fopenmp -O2 ./source/reduction-clauseModificado7.c -o ./bin/reduction-clauseModificado7

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int main(int argc, char **argv){
    int i, n=20, a[n], suma=0, suma_local;

    if( argc<2 ) {
        fprintf(stderr, "Faltan Iteraciones\n");
        exit(-1);
    }

    n=atoi(argv[1]); 
    
    if( n>20 ) {n=20; printf("n=%d", n);}

    for(i=0; i<n; i++) a[i]=i;

    for(i=0; i<n; i++) printf("a[%d]=%d ", i, a[i]); printf("\n");

    #pragma omp parallel private(suma_local)
    {
        suma_local=0;
        #pragma omp for 
        for(i=0; i<n; i++) suma_local+=a[i];

        #pragma omp atomic
        suma+=suma_local;
    }

    printf("Tras 'parallel' suma=%d\n", suma);

}