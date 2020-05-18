# Preface

## Introduction to the MOOSE Framework id=moose-intro

<!--WIP-->

## What is the Finite Element Method? id=fem?

There seems to be some mixed definitions in the industry, but the Finite Element Method (FEM) is mainly one for solving ordinary or, more often, partial differential equations (PDE(s)), which are continuous over a given domain. These equations are often difficult and, sometimes, even impossible to evaluate, and the geometry of their domains may be of any arbitrary, complex shape. Nevertheless, the FEM is designed to closely approximate their solutions. In certain cases, it may even produce an exact solution.

In the FEM, solutions to PDEs are assumed to take on a certain, simple (usually polynomial) form and are interpolated as such. Problem domains are discretized into an irregular (or regular) grid, known as a mesh, and the assumed solution functions (interpolations) are evaluated at special points on that grid space. As with any approximation to some real function, the more discrete points at which evaluations are made, the more precise the approximate solution becomes. And depending on the order of the assumed function with respect to the analytical form of the equations which govern the physics of the problem, the FEM could, potentially, produce an exact solution.

There are many approaches to the FEM. One of the most common is the [Direct Stiffness Method](https://en.wikipedia.org/wiki/Direct_stiffness_method), which is probably what you were first taught when you took your Introduction to Finite Element Analysis course. This method usually involves constructing a system of linear equations in the following form,

\begin{equation}
\label{stiffness}
\bold{A} x = b
\end{equation}

Here, the term $\bold{A}$, is often referred to as the *stiffness matrix*. In the direct stiffness method, $\bold{A}$ is developed by adding the known coefficients corresponding to an action, $b$, generated along the component of a DOF, $x$, when $x$ takes on a unit value - one DOF at a time. As mentioned, these coefficients are usually well-known, and would normally be obtained from some table available in the literature. For example, the stiffness corresponding to all six DOFs (three displacements plus three rotations) of an Euler-Bernoulli beam could easily be found in any textbook on Mechanics of Materials.

Methods such as the Direct Stiffness one, however, are misleading about the basic theory behind the FEM. They are merely convenient solutions to certain differential equations. To demonstrate this, consider the Euler-Bernoulli beam equation:

\begin{equation}
\label{beam}
\dfrac{d^{2}}{dx^{2}} \left(E I \dfrac{d^{2} u}{dx^{2}} \right) = w
\end{equation}

[beam] is often overlooked in structural analysis, since nearly every possible solution to it has been found and documented. This makes it possible to use a direct stiffness approach, which downplays the true purpose of finite element analysis. The beauty of the FEM is that it is possible to solve [beam], as well as many other differential equations, with no preexisting knowledge of any sort of solution. The FEM is also a general purpose one, i.e., the same procedure is applied to any given PDE, and the end result is usually a system of equations like [stiffness], which are readily solved by a computer.

The intent of the foregoing discussion is to clear up any confusion the reader may have about what exactly the FEM is. Again, *+the Finite Element Method is a method for solving differential equations+*. This is a simple, yet important, definition for MOOSE users to keep in mind. In an open-sourced setting, like the MOOSE Framework, that is designed to couple any arbitrary number of PDEs, which are developed by a multi-disciplinary team of scientist and engineers, we need to fall back to the fundamentals of finite element analysis, as methods like direct stiffness will do us no good for this cause. Later in this workshop we will discuss the approach MOOSE employs: [Galerkin's method](https://en.wikipedia.org/wiki/Galerkin_method). For now, all you need to know is that this method is, at least, as effective as any other, e.g., direct stiffness, the principle of minimum potential energy, the Rayleigh-Ritz method, or virtual work. In all of these methods, the final result is almost always the exact same system of equations in the form of [stiffness].

### Where is the Stiffness Matrix?

MOOSE places no special emphasis on the concept of the stiffness matrix, i.e., the term, $\bold{A}$, in [stiffness], or any other matrices which emerge from the finite element analysis procedure. In fact, we tend to ignore matrices altogether. You, as the developer, need not worry about the exact details of the algebra. All you need to worry about is your governing equations and the means by which you wish to evaluate their integrals and approximate their solutions. Some people seem to believe that matrices are the defining characteristic of the FEM, when, really, they are simply a consequence of the formulation. By the end of the
[Tutorial](tutorial.md), this fact should become clear. Don't worry, the so-called stiffness matrix exists during a MOOSE execution, in some form or another, but matrix operations are handled externally from MOOSE, which we will discuss later<!--(in another section? is this statement accurate? PETSC?)-->.
