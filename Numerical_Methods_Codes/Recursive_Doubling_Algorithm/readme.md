Problem Description:  

-> Consider the calculation of the derivative of the following function,  
$$f(x) = sin(5x), \hspace{4mm} 0 \leq x \leq 5$$  
using $4^{th}$ order accurate Pade scheme for the interior and $3^{rd}$ order accurate one-sided Pade scheme near the boundaries.  
-> Pade's scheme is given as:  
$$g_0 + 2g_1 = \frac{1}{h} \left( -\frac{5}{2}f_0 + 2f_1 + \frac{1}{2}f_2 \right)$$  

$$g_{j+1} + 4g_j + g_{j-1} = \frac{3}{h} \left( f_{j+1} - f_{j-1} \right)$$
