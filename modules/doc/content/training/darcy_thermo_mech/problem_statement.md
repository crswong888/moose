# Tutorial - Solving a Simple Problem with MOOSE

Welcome to the Tutorial portion of the MOOSE Workshop! Here, we will guide you through the steps to create and solve a few simple physics problems using the MOOSE Framework. As we work through these, we will introduce the core C++ classes that are available to developers and explain the basic components of a MOOSE object. We will demonstrate how to set up the input files that invoke those objects, as well as their functions, and execute the application. Meanwhile, the theory behind the Galerkin FEM, and the instructions for how to how to convert your governing PDEs into an expression that is compatible with MOOSE, will be provided.

### How to Work Through this Tutorial

<!--This section will evolve as I work through the tutorial steps and get a better idea of their structure/flow-->

Our mission for this virtual version of the MOOSE Workshop is to provide you with the same experience you'd get from our live versions. You should work through the steps of this tutorial in the order in which we have presented them. This is necessary since, there are important technical concepts discussed alongside the problem demonstrations. As the demonstrations continue to gain complexity, we will introduce the relevant concepts on an as-needed basis. But, if certain problems seem redundant to you, or if you feel that you are comfortable with the concepts and theory, feel free to skip over them. Navigating through this portion of the workshop works exactly the same as it was discussed on the [header page](workshop.md#how-to).

The physical details of the problem we will use for our demonstrations are trivial. We've concluded that the problem we selected was suitable for providing an example as we present the concepts which are important for MOOSE developers to understand. That being said, let us proceed with the tutorial. After reading the [#problem], please proceed to the index of [#steps] and follow the links.
<!--(we might be able to make some improvements to navigation, but later)-->

## Problem Statement id=problem

Consider a system containing two pressure vessels at differing temperatures. The vessels are connected via a pipe that contains a filter consisting of close-packed steel spheres as shown in [problem-schematic]. Predict the velocity and temperature of the fluid inside the filter. The pipe is 0.304-m in length and 0.0514-m in diameter. The fluid inside the system is liquid water.

!media problem_schematic.png
       style=width:80%;margin-left:auto;margin-right:auto;
       id=problem-schematic
       caption=Schematic of the pressure vessel system used for demonstrations throughout the tutorial. (Pamuk and Ozdemir, [*"Friction factor, permeability, and inertial coefficient of oscillating flow through porous media of packed balls"*](https://www.sciencedirect.com/science/article/pii/S0894177711002640), Experimental Thermal and Fluid Science, v. 38, pp. 134-139, 2012.)

Note that, for this tutorial, we are particularly interested in the outlined portion of the pipe of length $L$ shown in [problem-schematic]. This region shall serve as our problem domain, $\Omega$.

### Governing Equations

To solve this problem, we will need to consider the following physics:

- Conservation of Mass:

\begin{equation}
\label{mass}
\nabla \cdot \bar{u} = 0
\end{equation}

- Conservation of Energy:

\begin{equation}
\label{energy}
C \left(\dfrac{\partial T}{\partial t} + \epsilon \bar{u} \cdot \nabla T \right) - \nabla \cdot k \nabla T = 0
\end{equation}

- Darcy's Law:

\begin{equation}
\label{darcy}
\bar{u} = -\dfrac{\bold{K}}{\mu} \left(\nabla p - \rho \bar{g} \right)
\end{equation}

The variables shown in [mass], [energy], and [darcy] denote the properties listed in [variables].

!table id=variables caption=Disambiguation of problem variables.
| Symbol | Property |
| - | - |
| $\bar{u}$ | Velocity |
| $C$ | Heat Capacity |
| $T$ | Temperature |
| $t$ | Time |
| $\epsilon$ | Porosity |
| $k$ | Thermal Conductivity |
| $\bold{K}$ | Permeability Tensor |
| $p$ | Pressure |
| $\rho$ | Density |
| $\bar{g}$ | Gravity Vector |

If we assume a zero-gravity condition, i.e., $\bar{g} = 0$, and if we impose the divergence-free condition of [mass] onto [darcy], we are left with the following system of two equations that the two unknowns, $p$ and $T$, must satisfy:

<!-- the `\newline \, \newline` creates some white space between the individual equations in the system-->
\begin{equation}
\label{system}
-\nabla \cdot \dfrac{\bold{K}}{\mu} \nabla p = 0
\newline \, \newline
C \left(\dfrac{\partial T}{\partial t} + \epsilon \bar{u} \cdot \nabla T \right) - \nabla \cdot k \nabla T = 0
\end{equation}

The system's overall heat capacity, density, and thermal conductivity are weighted by the contributions of the individual materials and each depend on the porosity of the packed steel sphere medium. These three relationships are defined by the following:

\begin{equation}
\label{heat-cap}
C \equiv \epsilon \rho_{f} c_{p,f} + (1 - \epsilon) \rho_{s} c_{p,s}
\end{equation}

\begin{equation}
\label{density}
\rho \equiv \epsilon \rho_{f} + (1 - \epsilon) \rho_{s}
\end{equation}

\begin{equation}
\label{thermal-cond}
k \equiv \epsilon k_{f} + (1 - \epsilon) k_{s}
\end{equation}

Here, $c_{p}$ denotes specific heat and the subscripts, $f$ and $s$ refer to the fluid material (water) and solid material (steel), respectively.

### Material Properties

The material properties of the fluid, $f$, and the solid, $s$, are given in [mats].

<!-- The properties listed here are somewhat inconsistent with what we input in the code. First off, this is not a comprehensive list of all the mat props we'll see in the tutorial. And second, some of these properties depend on the temperature, for which we make different assumptions about its value at different steps in the tutorial. I'll need to update this table once I am clear about what our assumptions are... -->

!table id=mats caption=Material property values.
| Property | Value | Units |
| :- | :- | :- |
| Viscosity of water, $\mu_f$ | $7.98\times10^{-4}$ |  $\textrm{P}\cdot\textrm{s}$ |
| Density of water, $\rho_f$ | 996 | $\textrm{kg}/\textrm{m}^3$ |
| Density of steel, $\rho_s$ | 8000 | $\textrm{kg}/\textrm{m}^3$ |
| Thermal conductivity of water, $k_f$ | 0.600 | $\textrm{W}/\textrm{m}\,\textrm{K}$ |
| Thermal conductivity of steel, $k_s$ | 18.00 | $\textrm{W}/\textrm{m}\,\textrm{K}$ |
| Specific heat capacity of water, $c_p{_f}$ | 4180 | $\textrm{J}/(\textrm{kg}\,\textrm{K})$ |
| Specific heat capacity of steel, $c_p{_s}$ | 466 | $\textrm{J}/(\textrm{kg}\,\textrm{K})$ |

## Tutorial Steps id=steps

!!!
I'm thinking each step has the following basic components:
1. Outline/Goals
2. Physics
3. Concepts/Theory
4. Demonstration
  - Source code
  - Input File
  - Results
If we can make that work repeatedly, it'd be neat...
!!!

<!--again, I'd like to reformat this TOC, I'm just not fond of this bulleted list style, but it works for now-->

- [Step 1: Creating and Executing a MOOSE Object](step01.md)

  - [Statement of Physics](step01.md#physics)
  - [MOOSE Objects](step01.md#physics)
  - [Input Files](step01.md#inputs)

    - [Execute an Input File](step01.md#execute)

  - [Demonstration](step01.md#demo)

    - [Input File](step01.md#input-demo)
    - [Results](step01.md#results-demo)

- [Step 2: Generate a Weak Form and Create a Kernel Object] *To be continued...*
