// OpenMP program to demonstrate the omp_for construct
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[])
{
	int i, id;
	int a[10];
	omp_set_num_threads(3);
	#pragma omp parallel shared(i, id) private(a)
	{
		#pragma omp for
		for(i = 0; i < 10; i++)
		{
			id = omp_get_thread_num();
			a[i] = i+1;
			printf("a[%d] = %d from thread id %d \n", i, a[i], id);
		}
	}
}
