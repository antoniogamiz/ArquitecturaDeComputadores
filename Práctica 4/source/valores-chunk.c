#include <stdio.h>
#include <stdlib.h>
#include <omp.h>


int main()
{
    omp_sched_t kind;
    int current_chunk;

    omp_get_schedule(&kind, &current_chunk);
    
    omp_set_schedule(omp_sched_static, current_chunk);
    omp_get_schedule(&kind, &current_chunk);
    printf("Valor de chunk para 'static': %d\n", current_chunk);

    omp_set_schedule(omp_sched_dynamic, current_chunk);
    omp_get_schedule(&kind, &current_chunk);
    printf("Valor de chunk para 'dynamic': %d\n", current_chunk);

    omp_set_schedule(omp_sched_guided, current_chunk);
    omp_get_schedule(&kind, &current_chunk);
    printf("Valor de chunk para 'guided': %d\n", current_chunk);

}