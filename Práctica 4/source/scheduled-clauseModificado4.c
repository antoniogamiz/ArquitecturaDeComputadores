#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

int main(int argc, char **argv)
{
    int i, n=200, chunk, a[n], suma=0;

    if(argc != 3)
    {
        fprintf(stderr, "\nFalta chunk \n");
        exit(-1);
    }
    

    n=atoi(argv[1]); if( n>200 ) n=200;
    chunk=atoi(argv[2]);

    for(i=0; i<n; i++) a[i]=i;

    #pragma omp parallel
    {
        #pragma omp for firstprivate(suma) \
                lastprivate(suma) schedule(dynamic, chunk)
        for(i=0; i<n; i++)
        {
            suma+=a[i];
            printf("thread %d suma a[%d] suma=%d\n", omp_get_thread_num(), i, suma);
        }

        #pragma omp single
        {
            printf("Fuera de 'parallel for' suma=%d\n", suma);
            omp_sched_t kind;int chunk_size;
            omp_get_schedule(&kind, &chunk_size);

            printf("\nDENTRO DE LA REGION PARALELA\n");
            printf("dyn-var: %d\n", omp_get_dynamic());
            printf("nthreads-var: %d\n", omp_get_max_threads());
            printf("thread-limit-var: %d\n", omp_get_thread_limit());
            printf("run-sched-var: %d\n", kind);
            
            printf("Numero de threads: %d\n", omp_get_num_threads());
            printf("Numero de procesadores disponibles: %d\n", omp_get_num_procs());
            printf("En region paralela: %d\n", omp_in_parallel());
        }
    }

    omp_sched_t kind;int chunk_size;
    omp_get_schedule(&kind, &chunk_size);

    printf("\nFUERA DE LA REGION PARALELA\n");
    printf("dyn-var: %d\n", omp_get_dynamic());
    printf("nthreads-var: %d\n", omp_get_max_threads());
    printf("thread-limit-var: %d\n", omp_get_thread_limit());
    printf("run-sched-var: %d\n", kind);

    printf("Numero de threads: %d\n", omp_get_num_threads());
    printf("Numero de procesadores disponibles: %d\n", omp_get_num_procs());
    printf("En region paralela: %d\n", omp_in_parallel());
    


}