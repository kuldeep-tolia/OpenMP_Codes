! OpenMP program to calculate first derivative using recursive doubling method
program openmp_recursive_doubling

use omp_lib
implicit none
	
	integer :: num_thread = 1
	character(100) :: numchar
	character(100) :: nameq
	
	integer, parameter :: N = 1000		! Number of divisions
	double precision, parameter :: Lx = 3.0d0	! Length of domain 
	integer :: i, k, k_steps
	double precision :: h, t1, t2
	double precision, dimension(:), allocatable :: xgrid, f, x, df_exact
	double precision, dimension(:), allocatable :: a, b, c, d, alpha, beta
	
	h = Lx / N			! grid spacing
	k_steps = ceiling(log(N+1.0d0) / log(2.0d0))
	
	if(COMMAND_ARGUMENT_COUNT() .ne. 1) then
		write(*, *) "Command line argument of number of threads is required."
		STOP
	end if
	
	call GET_COMMAND_ARGUMENT(0, nameq)	
	call GET_COMMAND_ARGUMENT(1, numchar)
	read(numchar, *) num_thread
	
	! Allocate vectors
	allocate(xgrid(1:N+1), f(1:N+1), x(1:N+1), df_exact(1:N+1))
	allocate(a(1:N+1), b(1:N+1), c(1:N+1), d(1:N+1), alpha(1:N+1), beta(1:N+1))
	
	! Initialize vectors
	do i = 1, N+1
		xgrid(i) = (i-1) * h
		f(i) = func(xgrid(i))
		df_exact(i) = dfunc(xgrid(i))
		x(i) = 0.0d0
	end do
	
	! Fill sub, diagonal, super and RHS vectors
	a(1) = 0.0d0
	b(1) = 1.0d0
	c(1) = 2.0d0
	d(1) = (1.0d0 / h) * (-2.50d0 * f(1) + 2.0d0 * f(2) + 0.50d0 * f(3))
	do i = 2, N
		a(i) = 1.0d0
		b(i) = 4.0d0
		c(i) = 1.0d0
		d(i) = (3.0d0 / h) * (f(i+1) - f(i-1))
	end do
	a(N+1) = 2.0d0
	b(N+1) = 1.0d0
	c(N+1) = 0.0d0
	d(N+1) = (1.0d0 / h) * (2.50d0 * f(N+1) - 2.0d0 * f(N) - 0.50d0 * f(N-1))
	
	t1 = omp_get_wtime()
	!$omp parallel num_threads(num_thread) default(shared) private(i)
	! Elimination phase
	do k = 1, k_steps
		!$omp do
		do i = 1, N+1
			if (i .ge. (2**(k-1) + 1)) then
				alpha(i) = -a(i) / b(i-2**(k-1))		! Compute alpha(i)
			else
				alpha(i) = 0.0d0
			end if
			
			if (i .le. (N+1-2**(k-1))) then
				beta(i) = -c(i) / b(i+2**(k-1))		! Compute beta(i)
			else
				beta(i) = 0.0d0
			end if
			
			if (i .ge. (2**k + 1)) then	
				a(i) = alpha(i) * a(i-2**(k-1))		! Compute a(i)
			else
				a(i) = 0.0d0
			end if
			
			if (i .le. (N+1-2**k)) then
				c(i) = beta(i) * c(i+2**(k-1))		! Compute c(i)
			else
				c(i) = 0.0d0
			end if
			
			b(i) = alpha(i) * c(i-2**(k-1)) + b(i) + beta(i) * a(i+2**(k-1))	! Compute b(i)
			
			d(i) = alpha(i) * d(i-2**(k-1)) + d(i) + beta(i) * d(i+2**(k-1))	! Compute d(i)
		end do
		!$omp end do
	end do
	!$omp end parallel
	
	!$omp parallel do num_threads(num_thread) default(shared) private(i)
	! Solution phase
	do i = 1, N+1
		x(i) = d(i) / b(i)
	end do
	!$omp end parallel do
	t2 = omp_get_wtime()	
	
	! Post-processing
	open(11, file = "openmp_recursive_doubling_first_derivative.txt")
	do i = 1, N+1
		write(11, *) xgrid(i), df_exact(i), x(i)
	end do
	
	write(*, *) "---------- Program ran successfully. Exiting!!! ----------"
	write(*, *) "Number of divisions, N =", N
	write(*, *) "Number of threads used =", num_thread
	write(*, 11) "Total time taken for convergence =", t2-t1
	11 format (A, F15.7)
	
	deallocate(xgrid, f, x, df_exact)
	deallocate(a, b, c, d, alpha, beta)
	
contains

	function func(x) result(y)
	implicit none
		
		double precision :: x, y
		y = sin(5.0d0 * x)
		
	end function func
	
	function dfunc(x) result(y)
	implicit none
		
		double precision :: x, y
		y = 5.0d0 * cos(5.0d0 * x)
		
	end function dfunc

end program openmp_recursive_doubling
