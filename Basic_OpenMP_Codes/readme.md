-> This section discusses about basic OpenMP functions, clauses, constructs like first/last/thread-private variables, parallel-do/for, nested parallelism, scheduling, etc.  
-> The computer programs only demonstrates the behaviour of a particular OpenMP function/clause/construct. To check the syntax of a particular clause/construct, you may refer to the following websites:
- https://www.openmp.org/
- https://rookiehpc.github.io/openmp/docs/index.html  

-> To compile and run the codes, I have used gcc and gfortran compilers for C and FORTRAN-90 programs, respectively.  
  
-> Compiling and running a C program:
- $ gcc -fopenmp file_name.c -lm -o ./output_name.out
