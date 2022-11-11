! Simple OpenMP hello world program
program hello_world

use omp_lib
implicit none

	integer :: id, num_thread = 1
	character(100) :: numchar
	character(100) :: nameq
	
	if(COMMAND_ARGUMENT_COUNT() .ne. 1) then
		write(*, *) "Command line argument of number of threads is required."
		STOP
	end if
	
	call GET_COMMAND_ARGUMENT(0, nameq)
	write(*, *) nameq
	
	call GET_COMMAND_ARGUMENT(1, numchar)
	read(numchar, *) num_thread
	
	!$omp parallel private(id) num_threads(num_thread)
		id = omp_get_thread_num()
		write(*, *) "Hello World from thread id =", id
	!$omp end parallel 

end program hello_world
