
//gcc -fopenmp -O2 ./source/pmtv-secuencial.c -o ./bin/pmvt-secuencial

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define MOSTRAR_MATRIZ 1
#define MOSTRAR_V 1
#define MOSTRAR_V2 1
#define MOSTRAR_PRIMERO_ULTIMO 1

int main(int argc, char ** argv)
{
    if( argc<2 ) {
        fprintf(stderr, "Formato: %s <N>\n", argv[0]);
        exit(-1);
    }

    int N=atoi(argv[1]);

    int **m, *v, *v2;
    m= (int**) malloc(N*sizeof(int*));
    for(int i=0; i<N; i++) m[i]= (int*) malloc(N*sizeof(int));
    v= (int*) malloc(N*sizeof(int)); 
    v2= (int*) malloc(N*sizeof(int));

    if ((m == NULL) || (v == NULL) || (v2 == NULL))
    {
    printf("Error en la reserva de espacio para los vectores \n");
    exit(-2);
    }

    //Inicializamos la matriz m.
    for(int i=0; i<N; i++) for(int j=0; j<N; j++) m[i][j]=( i>j ) ? 0: i+j+1;

    //Inicializamos el vector v.
    for(int i=0; i<N; i++) v[i]=1;

    //Inicializamos el vector v2.
    for(int i=0; i<N; i++) v2[i]=0;

    //Calculamos la multiplicacion m*v en v2.
    double start = omp_get_wtime();
    for(int i=0; i<N; i++) for(int j=i; j<N; j++) v2[i]+=m[i][j]*v[j];
    double end = omp_get_wtime();

    //Mostramos matriz/vectores.
    #if MOSTRAR_MATRIZ
        printf("Matrix m: \n");
        for(int i=0; i<N; i++) {for(int j=0; j<N; j++) printf("%d\t", m[i][j]); printf("\n"); }      
    #endif
    #if MOSTRAR_V
        printf("Vector v: \n");
        for(int i=0; i<N; i++) printf("%d ", v[i]); printf("\n");
    #endif
    #if MOSTRAR_V2
        printf("Vector v2: \n");
        for(int i=0; i<N; i++) printf("%d ", v2[i]); printf("\n");
    #endif

    #if MOSTRAR_PRIMERO_ULTIMO
        printf("Numero de threads: %d\n", omp_get_num_threads());
        printf("Tiempo(seg): %11.9f \t N=%d \t (v2[0]=%d v2[%d]=%d)\n", (float)(end-start), N, v2[0], N-1, v2[N-1]);
    #else
        printf("Tiempo(seg): %11.9f \t N=%d\n", (float)(end-start), N);
    #endif


    for(int i=0; i<N; i++) free(m[i]);
    free(m); free(v); free(v2);

}