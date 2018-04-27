#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int main(int argc, char **argv)
{
    int i, n=16, chunk, a[n], suma=0;

    if(argc != 2)
    {
        fprintf(stderr, "\nFalta chunk \n");
        exit(-1);
    }
    
    chunk=atoi(argv[1]);

    for(i=0; i<n; i++) a[i]=i;

    #pragma omp parallel for firstprivate(suma) \
            lastprivate(suma) schedule(static, chunk)
    for(i=0; i<n; i++)
    {
        suma+=a[i];
        printf("thread %d suma a[%d] suma=%d \n", omp_get_thread_num(), i, suma);
    }

    printf("Fuera de 'parallel for' suma=%d\n", suma);

}