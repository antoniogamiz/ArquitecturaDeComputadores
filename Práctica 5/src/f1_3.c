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
    int aux1, aux2, aux3, aux4;
    for(int ii=0; ii<40000; ii+=4)
    {
        
        aux1=ii*5000;
        aux2=(ii+1)*5000;
        aux3=(ii+2)*5000;
        aux4=(ii+3)*5000;

        if( x1<x2-2*aux1 ) R[ii]=x1+aux1; else R[ii]=x2-aux1;
        if( x1<x2-2*aux2 ) R[ii+1]=x1+aux2; else R[ii+1]=x2-aux2;
        if( x1<x2-2*aux3 ) R[ii+2]=x1+aux3; else R[ii+2]=x2-aux3;
        if( x1<x2-2*aux4 ) R[ii+3]=x1+aux4; else R[ii+3]=x2-aux4;
    }

    clock_gettime(CLOCK_REALTIME, &cgt2);
    ncgt= (double)(cgt2.tv_sec - cgt1.tv_sec) + (double) ((cgt2.tv_nsec - cgt1.tv_nsec) / (1.e+9));

    printf("Tiempo de ejecución: %11.9f\t / R[0]= %d\t / R[39999]= %d\n", ncgt, R[0], R[39999]);

}