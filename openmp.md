# Needs-to-know

> Orden de preferencia para fijar el número de threads (¿Cuántos threads se usan?)
1- El fijado por defecto por la implementación (número de cores de un nodo normalmente)
2- El contenido de la variable de entorno `OMP_NUM_THREADS`
3- Número que fija la función `omp_set_num_threads()`
4- Número que fija la cláusula `num_threads`
5- Número que resulte de evaluar la cláusula if

+ Cláusula if: no hay ejecución paralela si no se cumple la condición. Solo en construcciones parallel.

+ `schedule(dynamic)` distribución en tiempo de ejecución. Apropiado si se desconoce el tiempo de ejecución de las iteraciones. Los threads más rápidos ejecutan más iteraciones. Añade sobrecarga adicional.

+ `schedule(guided)` distribución en tiempo de ejecución. Apropiado si se desconoce el tiempo de ejecución de las iteraciones o su número. Comienza con tamaño de bloque grande y va menguando a un tamaño no más pequeño que chunk(excepto última iteración). Sobrecarga extra, pero menos que `dynamic` para el mismo chunk.

+ `schedule(runtime)`: el tiempo de distribución se fija en tiempo de ejecución, depende de la variable de control `run-sched-var`


+ parallel, sections, worksharing, single y do/for tienen barrera implícita al final. Además, todas menos parallel son directivas de trabajo compartido.

+ Para distribuir las iteraciones de un bucle entre las threads -- for, para distribuir trozos de código independientes entre las threads -- sections, y para que uno de los threads ejecute un trozo de código secuencial-- single.

+ critical evita que varios threads accedan a variables compartidas a la vez, evita race conditions.

+ Las variables declaradas fuera de una región y las dinámicas son compartidas por los threads de la región, mientras que las variables declaradas dentro son privadas. El índice de los bucles for tiene un ámbito predeterminado de privado.

+ lastprivate copia en la variable el valor de la última ejecución del bucle, si se usa for o de la última sección si se usa sections.

+ firstprivate inicializa la variable al entrar en la región paralela con el valor especificado fuera.

+ copyprivate solo se puede usar con single. Permite que una variable privada de un thread se copie a las variables privadas del mismo nombre del resto de threads (difusión).

+ Each thread has a unique integer “id”; master thread has “id” 0, and other threads have “id” 1, 2, ...

+ OpenMP runtime function  `omp_get_thread_num()` returns a thread’s unique “id”.

+ The function `omp_get_num_threads()` returns the total number of executing threads

+ The function `omp_set_num_threads(x)`asks for “x” threads to execute in the next parallel region (must be set outside region)

+ Global variables (declared outside the scope of a parallel region) are shared among threads unless explicitly made private

+ Automatic variables declared within parallel region scope are private

+ Stack variables declared in functions called from within a parallel region are private

+ Regla general para regiones paralelas (para variables que no se usan en cláusulas o directivas de ámbito): Las variables declaradas fuera de una región y las dinámicas son compartidas por los threads de la región. Las variables declaradas dentro son privadas.
Excepciones: índice de bucles for (ámbito predeterminado privado) y variables declaradas static.

+ critical protects code, atomic protects memory locations.
+ The master construct does not imply a barrier. This construct is very similar to the single construct: the code inside the master construct is executed by only one (master) thread. But the difference is that the master construct does not imply a barrier while the single construct does.

+ Some constructs support the removal of a barrier, for instance the loop construct. A programmer can then omit the barrier by adding nowait clause to the loop construct.

+ The default(none) clause forces a programmer to explicitly specify the data-sharing attributes of all variables in a parallel region. Using this clause then forces the programmer to think about data-sharing attributes:

~~~c
const int n = 10;
const int a = 7;

#pragma omp parallel for default(none) shared(a, n)
for (int i = 0; i < n; i++){
    int b = a + i;
    ...
}
~~~
Da error porque por defecto las variables son compartidas, y estas al ser constantes no se puede cambiar este comportamiento. Consecuentemente, aunque pongamos `default none`, no tenemos que especificar `shared(a, n)`,  ésto lo hace por sí mismo el compilador, solo es necesario las variables no constantes.

~~~c
#pragma omp parallel
{
    #pragma omp for nowait
    for (...)
    {
        // for loop body
    }

    // next instructions
}
~~~

>`#pragma  omp  parallel  private(x)`
+ Each thread receives its own uninitialized variable x
+ The variable x falls out-of-scope after the parallel region
+ A global variable with the same name is unaffected  (3.0 and later)

> `#pragma  omp  parallel  firstprivate(x)`
+ x must be a global-scope variable
+ Each thread receives a by-value copy of x
+ The local x’s fall out-of-scope after the parallel region
+ The base global variable with the same name is unaffected

+ Para distribuir las iteraciones de un bucle entre las threads (paralelismo de datos): `#pragma omp for`

+ Para distribuir trozos de código independientes entre las threads (paralelismo de tareas): `#pragma omp sections`

+ Para que uno de los threads ejecute un trozo de código secuencial: `#pragma omp single`

# Hello-worlds in OpenMp

~~~c
#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define PARENT_TID 0

int main() {
  int tid;
  #pragma omp parallel
  {
    tid = omp_get_thread_num();
    if(tid == PARENT_TID)
      printf("Parent: %d threads running\n", omp_get_num_threads());
    else
      printf("Thread# %d: Hello world\n", tid);
  }
}
~~~

~~~c
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

int main (int argc, char *argv[]){
int nthreads, tid;

/* Fork a team of threads giving them their own copies of variables* /
#pragma omp parallel private(nthreads, tid)
  {

  /* Obtain thread number * /
  tid = omp_get_thread_num();
  printf("Hello World from thread = %d\n", tid);

  /* Only master thread does this * /
  if (tid == 0){
    nthreads = omp_get_num_threads();
    printf("Number of threads = %d\n", nthreads);
  }

  }  /* All threads join master thread and disband * /

}
~~~

#pragma omp parallel clauses:

+ if (exp)

    When the if argument is specified, the program code executes in parallel only if the scalar expression represented by exp evaluates to a nonzero value at run time. Only one if clause can be specified.
    No hay ejecución
    paralela si no se
    cumple la condición

    Precaución:
    Sólo en construcciones
    con parallel
+ private (list)

    Declares the scope of the data variables in list to be private to each thread. Data variables in list are separated by commas.
+ firstprivate (list)

    Declares the scope of the data variables in list to be private to each thread. Each new private object is initialized with the value of the original variable as if there was an implied declaration within the statement block. Data variables in list are separated by commas.
+ num_threads (int_exp)

    The value of int_exp is an integer expression that specifies the number of threads to use for the parallel region. If dynamic adjustment of the number of threads is also enabled, then int_exp specifies the maximum number of threads to be used.
+ shared (list)

    Declares the scope of the comma-separated data variables in list to be shared across all threads.
+ default (shared | none)

    Defines the default data scope of variables in each thread. Only one default clause can be specified on an omp parallel directive.

    Specifying default(shared) is equivalent to stating each variable in a shared(list) clause.

    Specifying default(none) requires that each data variable visible to the parallelized statement block must be explcitly listed in a data scope clause, with the exception of those variables that are:

        const-qualified,
        specified in an enclosed data scope attribute clause, or,
        used as a loop control variable referenced only by a corresponding omp for or omp parallel for directive.

+ copyin (list)

    For each data variable specified in list, the value of the data variable in the master thread is copied to the thread-private copies at the beginning of the parallel region. Data variables in list are separated by commas.

    Each data variable specified in the copyin clause must be a threadprivate variable.
+ reduction (operator: list)

    Performs a reduction on all scalar variables in list using the specified operator. Reduction variables in list are separated by commas.
    A private copy of each variable in list is created for each thread. At the end of the statement block, the final values of all private copies of the reduction variable are combined in a manner appropriate to the operator, and the result is placed back in the original value of the shared reduction variable. For example, when the max operator is specified, the original reduction variable value combines with the final values of the private copies by using the following expression:

    original_reduction_variable = original_reduction_variable < private_copy ?
    private_copy : original_reduction_variable;
    copy to clipboard

    For variables specified in the reduction clause, they must satisfy the following conditions:

        Must be of a type appropriate to the operator. If the max or min operator is specified, the variables must be one of the following types with or without long, short, signed, or unsigned:
            _ Bool
            char
            int
            float
            double
        Must be shared in the enclosing context.
        Must not be const-qualified.
        Must not have pointer type.

Usage

When a parallel region is encountered, a logical team of threads is formed. Each thread in the team executes all statements within a parallel region except for work-sharing constructs. Work within work-sharing constructs is distributed among the threads in a team.

Loop iterations must be independent before the loop can be parallelized. An implied barrier exists at the end of a parallelized statement block.

By default, nested parallel regions are serialized.

# schedule clause
The default schedule for loops with no schedule
clause is implementation defined. It doesn’t have to be STATIC. In practice, it is.  

Nevertheless you should not rely on this!  

Also note that SCHEDULE(STATIC) does not completely
specify the distribution of loop iterations.

Don’t write code that relies on a particular mapping of iterations to threads  

Tuning the chunksize for static or dynamic schedules can be
tricky because the optimal chunksize can depend quite
strongly on the number of threads.

It’s often more robust to tune the
number of chunks per thread
and derive the chunksize from that.

Chunksize expression does not have to be a compile-time constant

## Scheduling

We describe how a programmer can determine a scheduling type of a loop.

> Explicit

If the loop construct has explicit schedule clause

~~~c
#pragma omp parallel for schedule(scheduling-type)
for (...)
{ ... }
~~~

then OpenMP uses scheduling-type for scheduling the iterations of the for loop.
Runtime

If the scheduling-type is equal to runtime then OpenMP determines the scheduling by the internal control variable `run-sched-var`. We can set this variable by setting the environment variable `OMP_SCHEDULE` to the desired scheduling type. For example, in bash-like terminals, we can do

`$ export OMP_SCHEDULE=sheduling-type`

Another way to specify `run-sched-var` is to set it with `omp_set_schedule` function.

> Default

If the loop construct does not have an explicit schedule clause then OpenMP uses the default scheduling type. It is defined by the internal control variable def-sched-var and it is implementation dependent.

>Scheduling types

We can choose between five different scheduling types:

    static,
    dynamic,
    guided,
    auto and
    runtime.

### Static

The schedule(static, chunk-size) clause of the loop construct specifies that the for loop has the static scheduling type. OpenMP divides the iterations into chunks of size chunk-size and it distributes the chunks to threads in a circular order.

When no chunk-size is specified, OpenMP divides iterations into chunks that are approximately equal in size and it distributes at most one chunk to each thread.

Here are three examples of static scheduling.

~~~c
schedule(static):      
****************                                                
                ****************                                
                                ****************                
                                                ****************

schedule(static, 4):   
****            ****            ****            ****            
    ****            ****            ****            ****        
        ****            ****            ****            ****    
            ****            ****            ****            ****

schedule(static, 8):   
********                        ********                        
        ********                        ********                
                ********                        ********        
                        ********                        ********
~~~

Let me explain the examples. We parallelized a for loop with 64 iterations and we used four threads to parallelize the for loop. Each row of stars in the examples represents a thread. Each column represents an iteration.

The first example (schedule(static)) has 16 stars in the first row. This means that the first tread executes iterations 1, 2, 3, …, 15 and 16. The second row has 16 blanks and then 16 stars. This means that the second thread executes iterations 17, 18, 19, …, 31, 32. Similar applies to the threads three and four.

We see that for schedule(static) OpenMP divides iterations into four chunks of size 16 and it distributes them to four threads. For schedule(static, 4) and schedule(static, 8) OpenMP divides iterations into chunks of size 4 and 8, respectively.

**The static scheduling type is appropriate when all iterations have the same computational cost.**

### Dynamic

The `schedule(dynamic, chunk-size)` clause of the loop construct specifies that the for loop has the dynamic scheduling type. OpenMP divides the iterations into chunks of size chunk-size. Each thread executes a chunk of iterations and then requests another chunk until there are no more chunks available.

There is no particular order in which the chunks are distributed to the threads. The order changes each time when we execute the for loop.

If we do not specify chunk-size, it defaults to one.

Here are four examples of dynamic scheduling.

~~~c
schedule(dynamic):     
*   ** **  * * *  *      *  *    **   *  *  * *       *  *   *  
  *       *     *    * *     * *   *    *        * *   *    *   
 *       *    *     * *   *   *     *  *       *  *  *  *  *   *
   *  *     *    * *    *  *    *    *    ** *  *   *     *   *

schedule(dynamic, 1):  
    *    *     *        *   *    * *  *  *         *  * *  * *  
*  *  *   * *     *  * * *    * *      *   ***  *   *         *
 *   *  *  *  *    ** *    *      *  *  * *   *  *   *   *      
  *    *     *  **        *  * *    *          *  *    *  * *  *

schedule(dynamic, 4):  
            ****                    ****                    ****
****            ****    ****            ****        ****        
    ****            ****    ****            ****        ****    
        ****                    ****            ****            

schedule(dynamic, 8):  
                ********                                ********
                        ********        ********                
********                        ********        ********        
        ********                                                
~~~

We can see that for `schedule(dynamic)` and `schedule(dynamic, 1)` OpenMP determines similar scheduling. The size of chunks is equal to one in both instances. The distribution of chunks between the threads is arbitrary.

For `schedule(dynamic, 4)` and `schedule(dynamic, 8)` OpenMP divides iterations into chunks of size four and eight, respectively. The distribution of chunks to the threads has no pattern.

**The dynamic scheduling type is appropriate when the iterations require different computational costs.** This means that the iterations are poorly balanced between each other. The dynamic scheduling type has higher overhead then the static scheduling type because it dynamically distributes the iterations during the runtime.


### Guided

iThe guided scheduling type is similar to the dynamic scheduling type. OpenMP again divides the iterations into chunks. Each thread executes a chunk of iterations and then requests another chunk until there are no more chunks available.

The difference with the dynamic scheduling type is in the size of chunks. The size of a chunk is proportional to the number of unassigned iterations divided by the number of the threads. Therefore the size of the chunks decreases.

The minimum size of a chunk is set by chunk-size. We determine it in the scheduling clause: `schedule(guided, chunk-size)`. However, the chunk which contains the last iterations may have smaller size than chunk-size.

If we do not specify chunk-size, it defaults to one.

Here are four examples of the guided scheduling.

~~~c
schedule(guided):      
                            *********                        *  
                ************                     *******  ***   
                                     *******                   *
****************                            *****       **    *

schedule(guided, 2):   
                ************                     ****     **    
                                     *******         ***    **  
                            *********                           
****************                            *****       **    **

schedule(guided, 4):   
                                     *******                    
                ************                     ****    ****   
                            *********                           
****************                            *****    ****    ***

schedule(guided, 8):   
                ************                 ********        ***
****************                                                
                                     ********                   
                            *********                ********
~~~

We can see that the size of the chunks is decreasing. First chunk has always 16 iterations. This is because the for loop has 64 iterations and we use 4 threads to parallelize the for loop. If we divide 64 / 4, we get 16.

We can also see that the minimum chunk size is determined in the schedule clause. The only exception is the last chunk. Its size might be lower then the prescribed minimum size.

**The guided scheduling type is appropriate when the iterations are poorly balanced between each other**. The initial chunks are larger, because they reduce overhead. The smaller chunks fills the schedule towards the end of the computation and improve load balancing. This scheduling type is especially appropriate when poor load balancing occurs toward the end of the computation.

### Auto

The auto scheduling type delegates the decision of the scheduling to the compiler and/or runtime system.

In the following example, the compiler/system determined the static scheduling.

~~~c
schedule(auto):        
****************                                                
                ****************                                
                                ****************                
                                                ****************
~~~

### Runtime

The runtime scheduling type defers the decision about the scheduling until the runtime. We already described different ways of specifying the scheduling type in this case. One option is with the environment variable `OMP_SCHEDULE`and the other option is with the function `omp_set_schedule`.

### Default

If we do not specify the scheduling type in a for loop

~~~c
#pragma omp parallel for
for (...)
{ ... }
~~~

OpenMP uses the default scheduling type (defined by the internal control variable `def-sched-var`).

If I do not specify the scheduling type in my machine, I get the following result.

~~~c
default:               
****************                                                
                ****************                                
                                ****************                
                                                ****************
~~~

We recognize that the default scheduling type in my machine is the static scheduling type.

# SINGLE or MASTER?

Both constructs cause a code block to be executed by one
thread only, while the others skip it: which should you use?  

MASTER has lower overhead (it’s just a test, whereas
SINGLE requires some synchronisation).

But beware that MASTER has no implicit barrier!  

If you expect some threads to arrive before others, use
SINGLE, otherwise use MASTER  

# Implementation of the reduction clause

How does OpenMP parallelize a for loop declared with a reduction clause? OpenMP creates a team of threads and then shares the iterations of the for loop between the threads. Each thread has its own local copy of the reduction variable. The thread modifies only the local copy of this variable. Therefore, there is no data race. When the threads join together, all the local copies of the reduction variable are combined to the global shared variable.

For example, let us parallelize the following for loop

~~~c
sum = 0;
#pragma omp parallel for shared(sum, a) reduction(+: sum)
for (auto i = 0; i < 9; i++)
{
    sum += a[i]
}
~~~

and let there be three threads in the team of threads. Each thread has sumloc, which is a local copy of the reduction variable. The threads then perform the following computations

~~~c
    Thread 1

sumloc_1 = a[0] + a[1] + a[2]

    Thread 2

sumloc_2 = a[3] + a[4] + a[5]

    Thread 3

sumloc_3 = a[6] + a[7] + a[8]
~~~

In the end, when the treads join together, OpenMP reduces local copies to the shared reduction variable

sum = sumloc_1 + sumloc_2 + sumloc_3


# How to dynamically choose scheduling type?
[From StackOverflow](https://stackoverflow.com/questions/37288493/how-to-dynamically-choose-scheduling-type)

I need to compare execution time of a loop with different scheduling type and threads number with openMP.

I can set threads number dynamically by passing an int variable directly in the pragma macro:

int threads_number = 4;
#pragma omp parallel for num_threads(threads_number)

But I'm trying to do the same for schedule, I need to compare static, dynamic and guided types. But it appears I cannot use an int as enum nor a char* as name for this one.

Is there any way to choose it dynamically, or do I have to write the loop 3 times and choose which one to call with an if, which seems kind of dirty ?

**Answer**:
You can set the scheduling kind when the applied schedule is runtime.

>When schedule(runtime) is specified, the decision regarding scheduling is deferred until runtime. The schedule kind and size of the chunks can be chosen at run time by setting the environment variable OMP_SCHEDULE. If this environment variable is not set, the resulting schedule is implementation-defined. When schedule(runtime) is specified, chunk_size must not be specified. - OpenMP-4.5 Specification

This is done with the function void omp_set_schedule(omp_sched_t kind, int chunk_size);

The scheduling kinds that are available are defined in omp.h as this enum below

~~~c
typedef enum omp_sched_t {
    omp_sched_static = 1,
    omp_sched_dynamic = 2,
    omp_sched_guided = 3,
    omp_sched_auto = 4
} omp_sched_t;
~~~






#
