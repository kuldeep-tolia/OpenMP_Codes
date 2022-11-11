// OpenMP program to demonstrate the schedule clause
#include <omp.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[])
{
	int i, id, a[10];
	omp_set_num_threads(3);
	// Arguments for schedule clause can be static, dynamic, guided, auto, runtime
	#pragma omp parallel for private(i, id) shared(a) schedule(static, 2)
	for(i = 0; i < 12; i++)
	{
		id = omp_get_thread_num();
		a[i] = id;
		printf("a[%d] is %d from thread %d \n", i, a[i], id);
	}
}
