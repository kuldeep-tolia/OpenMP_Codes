! OpenMP program to demonstrate the private scope of a variable
program private_shared_variables

use omp_lib
implicit none

	integer:: id, x = 5
	
	!$omp parallel private(x, id)
		id = omp_get_thread_num()
		x = 3
		x = x + id
		write(*, *) "private x = ", x, "from thread ", id
	!$omp end parallel
	
	write(*, *) "Value of x after parallel region: ", x

end program private_shared_variables
