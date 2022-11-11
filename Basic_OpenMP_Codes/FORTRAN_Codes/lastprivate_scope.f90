! OpenMP program to demonstrate the lastprivate scope of a variable
program lastprivate_variables

use omp_lib
implicit none

	integer:: id, i, a
	
	!$omp parallel do private(i, id) lastprivate(a)
		do i = 1, 4		! 4 indicates the number of threads to launch
			id = omp_get_thread_num()
			a = i + 1
			write(*, *) "a = ", a, " for i = ", i, " from thread = ", id
		end do
	!$omp end parallel do
	
	write(*, *) "after parallel region a = ", a

end program lastprivate_variables
