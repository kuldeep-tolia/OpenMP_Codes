! OpenMP program to demonstrate the omp_do construct
program parallel_loop

use omp_lib
implicit none

	integer :: i, id
	integer, dimension(:) :: a(10)
	
	call omp_set_num_threads(3)
	!$omp parallel shared(i, id) private(a)
		!$omp do
		do i = 1, 10
			id = omp_get_thread_num()
			a(i) = i+1
			write(*, *) "a[", i, " ] = ", a(i), " from thread id = ", id
		end do	
	!$omp end parallel		

end program parallel_loop
