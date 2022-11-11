! OpenMP program to demonstrate the schedule clause
program schedule_clause

use omp_lib
implicit none

	integer :: i, id
	integer, dimension(:) :: a(10)
	call omp_set_num_threads(3)
	
	! Arguments for schedule clause can be static, dynamic, guided, auto, runtime
	!$omp parallel do private(i, id) shared(a) schedule(static, 2)		
		do i = 1, 10
			id = omp_get_thread_num()
			a(i) = i + 2
			write(*, *) i, a(i), id
		end do
	!$omp end parallel do

end program schedule_clause
