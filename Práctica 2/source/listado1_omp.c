/* listado1.c
Suma de dos vectores: v3= v1 + v2
Para compilar usar (-lrt: real time library):
gcc -O2 listado1.c -o listado1 -lrt
gcc -O2 -S listado1.c -lrt    (para generar el código ensamblador)
Para ejecutar:
listado1 longitud
*/

#include <stdlib.h>   //biblioteca para funciones atoi(), malloc() y free()
#include <stdio.h>    //biblioteca donde se encuentra la función printf()
#include <time.h>     //biblioteca donde se encuentra la función clock_gettime()
#include <omp.h>

// #define PRINTF_ALL   //comentar para quitar el printf, que imprime todas las componentes
/* Solo puede estar definida una de las tres constantes VECTOR_ , luego solo uno
de los tres defines siguientes puede estar descomentado:*/
//#define VECTOR_LOCAL  //descomentar para que los vectores sean variables locales (si se supera el tamaño de pila se generará segmentation fault)
#define VECTOR_GLOBAL   //descomentar para que los vectores sean variables globales (su longitud no estará limitada por el tamaño de la pila del programa)
 // #define VECTOR_DYNAMIC    //para que los vectores sean variables dinámicas (memoria reutilizable durante la ejecución)

#ifdef VECTOR_GLOBAL
#define MAX 67108865
double v1[MAX], v2[MAX], v3[MAX];
#endif

int main(int argc, char **argv){
  int i;

  //Leer argumento de entrada (nº de componentes del vector)
  if (argc<2){
    printf("Faltan nºcomponentes del vector\n");
    exit(-1);
  }

  unsigned int N= atoi(argv[1]);    //Máximo N= 2^32-1= 4294967295 (sizeof(unsigned int)= 4B)
  #ifdef VECTOR_LOCAL
  double v1[N], v2[N], v3[N];   //Tamaño variable local en tiempo de ejecución disponible en C a partir de actualización c99
  #endif

  #ifdef VECTOR_GLOBAL
  if (N>MAX) N= MAX;
  #endif

  #ifdef VECTOR_DYNAMIC
  double *v1, *v2, *v3;

  v1= (double*) malloc(N*sizeof(double));   //malloc necesita el tamño en bytes
  v2= (double*) malloc(N*sizeof(double));   //si no hay espacio suficiente malloc devuelve NULL
  v3= (double*) malloc(N*sizeof(double));

  if ((v1 == NULL) || (v2 == NULL) || (v3 == NULL)){
    printf("Error en la reserva de espacio para los vectores \n");
    exit(-2);
  }
  #endif

  //Inicializar vectores
  #pragma omp parallel for
  for(i= 0; i< N; i++){
    v1[i]= N*0.1 + i*0.1;
    v2[i]= N*0.1 - i*0.1;   //los valores dependen de N
  }

  #pragma omp barrier

  double start = omp_get_wtime();

  //Calcular suma de vectores
  #pragma omp parallel for
  for(i= 0; i< N; i++)
    v3[i]= v1[i] + v2[i];
  #pragma omp barrier

  double end = omp_get_wtime();

  //Imprimir resultado de la suma y el tiempo de ejecución
  printf("Tiempo(seg): %11.9f\t / tamaño vectores: %u\t/ v1[0]+v2[0]=v3[0](%8.6f+%8.6f=%8.6f) / / v1[%d]+v2[%d]=v3[%d](%8.6f+%8.6f=%8.6f) /\n", (float)(end-start), N, v1[0], v2[0], v3[0], N-1, N-1, N-1, v1[N-1], v2[N-1], v3[N-1]);

  // for(i= 0; i<N; i++)
  //   printf("/V1[%d] + V2[%d] = V3[%d] (%8.6f + %8.6f = %8.6f) /\n", i, i, i, v1[i], v2[i], v3[i]);


  #ifdef VECTOR_DYNAMIC
  //Liberamos el espacio reservado para los vectores
  free(v1);
  free(v2);
  free(v3);
  #endif
  return 0;
}
