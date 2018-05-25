
// g++ -fopenmp -O2 ./source/pmm-secuencial.c -o ./bin/pmm-secuencial

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MOSTRAR_PRIMERO_ULTIMO 1

#define MAX 10000
int m1[MAX][MAX], m2[MAX][MAX], m3[MAX][MAX];

int main(int argc, char ** argv)
{
    if( argc<2 ) 
    {
        fprintf(stderr, "Formato: %s <N>\n", argv[0]);
        exit(-1);
    }

    int N=atoi(argv[1]);
    if( N > MAX ) N=MAX;

    //Inicializamos la matriz m1 y m2
    for(int i=0; i<N; i++) for(int j=0; j<N; j++) { m1[i][j]=1; m2[i][j]=1; m3[i][j]=0;}

    struct timespec cgt1, cgt2;
    double ncgt;
    clock_gettime(CLOCK_REALTIME, &cgt1);

    int aux;
    for(int i=0; i<N; i++){
        for(int j=0; j<N; j++){
            aux=m2[i][j];
            m2[i][j]=m2[j][i];
            m2[j][i]=aux;
        }
    }

    int aux1, aux2, aux3, aux4;
    for(int i=0; i<N; i++) 
        for(int j=0; j<N; j++) 
            for(int k=0; k<N; k+=1){
                m3[i][j]+=m1[i][k]*m2[i][k];
            }
 
    clock_gettime(CLOCK_REALTIME, &cgt2);
    ncgt= (double)(cgt2.tv_sec - cgt1.tv_sec) + (double) ((cgt2.tv_nsec - cgt1.tv_nsec) / (1.e+9));


    #if MOSTRAR_PRIMERO_ULTIMO
        printf("Tiempo(seg): %11.9f \t N=%d \t (m3[0][0]=%d m3[%d][%d]=%d)\n", ncgt, N, m3[0][0], N-1, N-1, m3[N-1][N-1]);
    #else
        printf("Tiempo(seg): %11.9f \t N=%d\n", ncgt, N);
    #endif

}