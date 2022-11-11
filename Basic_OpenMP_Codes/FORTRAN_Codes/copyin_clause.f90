! OpenMP program to demonstrate the copyin clause
program copyin_clause

use omp_lib
implicit none

	integer:: id, x
	static:: x
	 
	!$omp threadprivate(x)
	!$omp parallel private(id)
		id = omp_get_thread_num()
		x = x + id
		write(*, *) "private x = ", x, "from thread ", id
	!$omp end parallel
	
	!$omp parallel copyin(x)
	!$omp end parallel
	
	!$omp parallel private(id)
		id = omp_get_thread_num()
		x = x + 10
		write(*, *) "2nd parallel private x = ", x, "from thread ", id
	!$omp end parallel

end program copyin_clause
