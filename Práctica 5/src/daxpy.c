
// gcc -O0 ./src/daxpy.c -o ./bin/daxpy-O0; ./bin/daxpy-O0

#include <stdlib.h>
#include <stdio.h>
#include <time.h>

#define MAX 300000000
float x[MAX], y[MAX];

#define ALPHA 1.5

int main(int argc, char **argv) {
    if( argc != 2 ) {
        printf("Formato: %s <N> \n", argv[0]);
        exit(-1);
    }

    int N = atoi(argv[1]); if( N > MAX ) N=MAX;

    for(int i=0; i<N; i++) x[i]=i+0.1;

    struct timespec cgt1, cgt2;
    double ncgt;

    clock_gettime(CLOCK_REALTIME, &cgt1);

    for(int i=0; i<N; i++) y[i] = ALPHA * x[i] + y[i];

    clock_gettime(CLOCK_REALTIME, &cgt2);

    ncgt= (double)(cgt2.tv_sec - cgt1.tv_sec) + (double) ((cgt2.tv_nsec - cgt1.tv_nsec) / (1.e+9));

    printf("T(s) %11.9f \t / y[0]=%5.3f / y[%d]=%5.3f\n", ncgt, y[0], N, y[N-1]);

}
