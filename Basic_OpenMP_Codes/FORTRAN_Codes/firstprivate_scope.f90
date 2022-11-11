! OpenMP program to demonstrate the firstprivate scope of a variable
program firstprivate_variables

use omp_lib
implicit none

	integer:: id, x = 5
	
	!$omp parallel private(id) firstprivate(x)
		id = omp_get_thread_num()
		x = x + id
		write(*, *) "private x = ", x, "from thread ", id
	!$omp end parallel
	
	write(*, *) "Value of x after parallel region: ", x

end program firstprivate_variables
