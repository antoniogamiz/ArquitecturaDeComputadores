/* listado1.c
Suma de dos vectores: v3= v1 + v2
Para compilar usar (-lrt: real time library):
gcc -O2 listado1.c -o listado1 -lrt
gcc -O2 -S listado1.c -lrt    (para generar el código ensamblador)
Para ejecutar:
listado1 longitud
*/

#include <stdlib.h>
#include <stdio.h>    
#include <time.h>
#include <omp.h>

//#define PRINTF_ALL
//#define VECTOR_LOCAL  
#define VECTOR_GLOBAL   
//#define VECTOR_DYNAMIC    

#ifdef VECTOR_GLOBAL
#define MAX 67108865
double v1[MAX], v2[MAX], v3[MAX];
#endif

int main(int argc, char **argv){
  int i;
  
  if (argc<2)
  {
    printf("Faltan nºcomponentes del vector\n");
    exit(-1);
  }

  unsigned int N= atoi(argv[1]);
  
  #ifdef VECTOR_LOCAL
  double v1[N], v2[N], v3[N];   
  #endif

  #ifdef VECTOR_GLOBAL
  if (N>MAX) N= MAX;
  #endif

  #ifdef VECTOR_DYNAMIC
  double *v1, *v2, *v3;
  v1= (double*) malloc(N*sizeof(double));
  v2= (double*) malloc(N*sizeof(double)); 
  v3= (double*) malloc(N*sizeof(double));

  if ((v1 == NULL) || (v2 == NULL) || (v3 == NULL))
  {
    printf("Error en la reserva de espacio para los vectores \n");
    exit(-2);
  }
  #endif

  #pragma omp parallel
  {
    #pragma omp sections
    {
      #pragma omp section
      for(int i=0; i<N/4; i++)
      {
        v1[i]= N*0.1 + i*0.1;
        v2[i]= N*0.1 - i*0.1;      
      }
      #pragma omp section
      for(int i=N/4; i<N/2; i++)
      {
        v1[i]= N*0.1 + i*0.1;
        v2[i]= N*0.1 - i*0.1;      
      }
      #pragma omp section
      for(int i=N/2; i<3*N/4; i++)
      {
        v1[i]= N*0.1 + i*0.1;
        v2[i]= N*0.1 - i*0.1;      
      }
      #pragma omp section
      for(int i=3*N/4; i<N; i++)
      {
        v1[i]= N*0.1 + i*0.1;
        v2[i]= N*0.1 - i*0.1;      
      }    
    }
  }

  #pragma omp barrier

  
  double start = omp_get_wtime();

  #pragma omp parallel
  {
    #pragma omp sections
    {
      #pragma omp section
      for(int i=0; i<N/4; i++) v3[i] = v1[i] + v2[i];
      #pragma omp section
      for(int i=N/4; i<N/2; i++) v3[i] = v1[i] + v2[i];
      #pragma omp section
      for(int i=N/2; i<3*N/4; i++) v3[i] = v1[i] + v2[i];
      #pragma omp section
      for(int i=3*N/4; i<N; i++) v3[i] = v1[i] + v2[i];
    }
  }

  #pragma omp barrier

  double end = omp_get_wtime();

  printf("Tiempo(seg): %11.9f\t / tamaño vectores: %u\t/ v1[0]+v2[0]=v3[0](%8.6f+%8.6f=%8.6f) / / v1[%d]+v2[%d]=v3[%d](%8.6f+%8.6f=%8.6f) /\n", (float)(end-start), N, v1[0], v2[0], v3[0], N-1, N-1, N-1, v1[N-1], v2[N-1], v3[N-1]);


  // for(i= 0; i<N; i++)
  //   printf("/V1[%d] + V2[%d] = V3[%d] (%8.6f + %8.6f = %8.6f) /\n", i, i, i, v1[i], v2[i], v3[i]);


  #ifdef VECTOR_DYNAMIC
  free(v1);
  free(v2);
  free(v3);
  #endif
  return 0;
}
