
// g++ -fopenmp -O2 ./source/pmm-secuencial.c -o ./bin/pmm-secuencial

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define MOSTRAR_MATRICES 0
#define MOSTRAR_PRIMERO_ULTIMO 1


int main(int argc, char ** argv)
{
    if( argc<2 ) 
    {
        fprintf(stderr, "Formato: %s <N>\n", argv[0]);
        exit(-1);
    }

    int N=atoi(argv[1]);

    int **m1, **m2, **m3;
    m1= (int**) malloc(N*sizeof(int*));
    m2= (int**) malloc(N*sizeof(int*));
    m3= (int**) malloc(N*sizeof(int*));
    
    for(int i=0; i<N; i++)
    {
        m1[i]= (int*) malloc(N*sizeof(int));
        m2[i]= (int*) malloc(N*sizeof(int));
        m3[i]= (int*) malloc(N*sizeof(int));
    }
    if ((m1 == NULL) || (m2 == NULL) || (m3 == NULL))
    {
        printf("Error en la reserva de espacio para los vectores \n");
        exit(-2);
    }

    //Inicializamos la matriz m1 y m2
    for(int i=0; i<N; i++) for(int j=0; j<N; j++) { m1[i][j]=1; m2[i][j]=1; m3[i][j]=0;}

    //Calculamos la multiplicacion m1*m2 en m3
    double start = omp_get_wtime();
    for(int i=0; i<N; i++) 
        for(int j=0; j<N; j++) 
            for(int k=0; k<N; k++)
                m3[i][j]+=m1[i][k] * m2[k][j];
    double end = omp_get_wtime();

    //Mostramos matriz/vectores.
    #if MOSTRAR_MATRICES
        printf("Matrix m1: \n");
        for(int i=0; i<N; i++) {for(int j=0; j<N; j++) printf("%d\t", m1[i][j]); printf("\n"); }     
        printf("Matrix m2: \n");
        for(int i=0; i<N; i++) {for(int j=0; j<N; j++) printf("%d\t", m2[i][j]); printf("\n"); }     
        printf("Matrix m3: \n");
        for(int i=0; i<N; i++) {for(int j=0; j<N; j++) printf("%d\t", m3[i][j]); printf("\n"); }     
         
    #endif

    #if MOSTRAR_PRIMERO_ULTIMO
        printf("Tiempo(seg): %11.9f \t N=%d \t (m3[0][0]=%d m3[%d][%d]=%d)\n", (float)(end-start), N, m3[0][0], N-1, N-1, m3[N-1][N-1]);
    #else
        printf("Tiempo(seg): %11.9f \t N=%d\n", (float)(end-start), N);
    #endif

    for(int i=0; i<N; i++) { free(m1[i]); free(m2[i]); free(m3[i]); }
    free(m1); free(m2); free(m3);

}