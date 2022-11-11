! OpenMP program to demonstrate the nested parallelism
program nested_parallel

use omp_lib
implicit none

	integer:: id
	call omp_set_nested(.true.)
	call omp_set_num_threads(2)
	
	! Outer parallel loop with 2 threads
	!$omp parallel private(id)
		id = omp_get_thread_num()
		write(*, *) "Hello from thread=", id
	! Inner parallel loop will launch again 2 threads for each thread of the outer loop, i.e., here 4 threads will race to write on the standard output
	!$omp parallel private(id)
		id = omp_get_thread_num()
		write(*, *) "Another HI from thread=", id
	!$omp end parallel
	!$omp end parallel

end program nested_parallel
