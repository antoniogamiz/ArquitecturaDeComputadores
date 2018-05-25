#include <stdlib.h>
#include <stdio.h>
#include <time.h>


struct
{
    int a;
    int b;
} s[5000];

int R[40000];

int main()
{

    time_t t;
    //srand( (unsigned) time(&t));


    for(int i=0; i<5000; i++)
    {
        s[i].a = rand() % 5000;
        s[i].b = rand() % 5000;
    }

    int x1, x2;

    struct timespec cgt1, cgt2;
    double ncgt;
    clock_gettime(CLOCK_REALTIME, &cgt1);

    x1=0; x2=0;
    for(int i=0; i<5000; i++) 
    {
        x1+=s[i].a;
        x2+=s[i].b;
    }

    x1*=2;
    x2*=3;

    int x1_aux, x2_aux;
    for(int ii=0; ii<40000; ii++)
    {
        x1_aux=x1; x2_aux=x2;
        x1_aux+=5000*ii;
        x2_aux-=5000*ii;


        if( x1_aux<x2_aux ) R[ii]=x1_aux; else R[ii]=x2_aux;

    }

    clock_gettime(CLOCK_REALTIME, &cgt2);
    ncgt= (double)(cgt2.tv_sec - cgt1.tv_sec) + (double) ((cgt2.tv_nsec - cgt1.tv_nsec) / (1.e+9));

    printf("Tiempo de ejecución: %11.9f\t / R[0]= %d\t / R[39999]= %d\n", ncgt, R[0], R[39999]);

}