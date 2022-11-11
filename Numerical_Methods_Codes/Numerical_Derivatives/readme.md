Problem Description:  

-> Consider an equation $u(x) = 7 - tan(x)$ that governs the transient heat conduction in a plane wall for $x = [-1,1]$.  
-> The analytical expression for the first derivative of the given equation is  
$$\frac{du}{dx} = -tan(x) - x sec^2x$$  
-> This is an OpenMP program to compute the first derivative using second and fourth-order accurate central-difference formulae.  
-> The grid size is varied as $\Delta x = 0.01, 0.001$  
-> The following are the central-difference formulae to compute the first derivative, along with their corresponding truncation errors:

- $2^{nd}$ order accurate:  
$$\left. \frac{du}{dx} \right|_{0} = 1$$
