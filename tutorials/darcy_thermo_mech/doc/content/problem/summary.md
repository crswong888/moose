# Tutorial Steps

!style halign=center
[#step01]\\
[#step02]\\
[#step03]\\
[#step04]\\
[#step05]\\
[#step06]\\
[#step07]\\
[#step08]\\
[#step09]\\
!![#step10]\\
!![#step11]

!---

## [#step01]

The first step is to solve a simple "Diffusion" problem, which requires no code. This step
will introduce the basic system of MOOSE.

!equation
-\nabla\cdot\nabla p = 0

!---

## [#step02]

In order to implement the Darcy pressure equation, a `Kernel` object is needed to represent:

!equation
-\nabla\cdot\frac{\mathbf{K}}{\mu}\nabla p = 0

!---

## [#step03]

Convert the object created in [#step02] to use automatic differentiation, by inheriting from
`ADKernel`.


!---

## [#step04]

Convert the object created in [#step03] to use ADDiffusion to avoid duplicate code and to take
advantage of pre-computing the residual term.

!---

## [#step05]

Instead of passing input parameters to the pressure diffusion `Kernel` object, the Material
system can be used to supply the values. This allows for properties that vary in space and time
as well as be coupled to variables in the simulation.

!---

## [#step06]

The sphere radius is allowed to vary by converting the constant value of the radius into a
function of space and time.

!---

## [#step07]

Convert material object to use automatic differntiation to guarantee the correct Jabobian terms.

!---

## [#step08]

The velocity is computed from the pressure based on Darcy's law as:

!equation
\vec{u} = -\frac{\mathbf{K}}{\mu} \nabla p

This velocity can be computed using the Auxiliary system.

!---

## [#step09]

Solve the transient heat equation using the "heat conduction" module.

!equation
C \frac{\partial T}{\partial t} - \nabla \cdot k \nabla T = 0

!---

## [#step10]

Create a non-uniform initial condition.

!---

## [#step11]

The boundary term, $-\left < k \nabla T \cdot \mathbf{n}, \psi_i \right >$, is computed implicitly
rather than being replaced with a known flux, as is done in a `NeumannBC`.

!---

## [#step12]

Solve the pressure and temperature in a coupled system of equations by adding the advection term
to the heat equation.

!equation
-\nabla \cdot \frac{\mathbf{K}}{\mu} \nabla p  = 0
\\
C\left( \frac{\partial T}{\partial t} + \epsilon \vec{u}\cdot\nabla T \right) - \nabla \cdot k \nabla T = 0

!---

!!## [#step13]

!!Add temperature dependence to material properties.


!!!

!---

## [#step07]

In the transient simulation, a "traveling wave" profile moves through the porous medium. Instead of
using a uniform mesh to resolve the wave profile, we can dynamically adapt the mesh to the solution.

!---

## [#step08]

`Postprocessor` and `VectorPostprocessor` objects can be used to compute aggregate value(s) for a
simulation, such as the average temperature on the boundary or the temperatures along a line
within the solution domain.

!---

## [#step09]

Thermal expansion of the porous media can be added to the coupled set of equations
using the "tensor mechanics" module, without adding additional code.

!---

## [#step10]

MOOSE is capable of running multiple applications together and transfer data between the various
applications.

This problem replaces the thermal conductivity calculated by the Material with a value computed by
another application that runs a phase-based micro-structure simulation.

!---

## [#step11]

MOOSE includes a system to create custom input syntax for common tasks, in this step the syntax
for the two equations and velocity auxiliary calculation are simplified for end-users.

!!!
