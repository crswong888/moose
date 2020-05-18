# Step 1: Creating and Executing a MOOSE Object

In this step, we will introduce [#objects] and the purposes they serve. We will then explain how finite element models are built by invoking several of those objects in a neat and organized fashion with MOOSE [#inputs].
To demonstrate these two concepts, we shall consider a steady-state diffusion of pressure from one end of the pipe between the pressure vessels to the other (see [Problem Statement](tutorial.md#problem)). For this, we'll enforce a boundary value problem that is so simple that we need not concern ourselves with the physics and focus only on how to write the code to solve the governing equation. While there are important FEM and C++ concepts at work here, for now, let's simply consider them as a given.

## Statement of Physics id=physics

We shall employ the Laplace equation to model the steady-state diffusion of pressure, $u$, on $\Omega$. That is, let us find $u$, such that

\begin{equation}
\label{laplace}
-\nabla \cdot \nabla u = 0 \in \Omega
\end{equation}

satisfies the following boundary value problem: $u = 4000 \, \textrm{Pa}$ at the inlet (left) boundary, $u = 0$ at the outlet (right) boundary, and $\nabla u \cdot \hat{n} = 0$, where $\hat{n}$ is the surface normal vector, on the remaining boundaries.

It is is necessary to acknowledge that we must express PDEs in a certain format to be able to solve them with MOOSE. That is, if we assume that the natural boundary condition, $\nabla u \cdot \hat{n}$, is satisfied, then the *weak form* of [laplace] is

\begin{equation}
\label{weak}
\int_{\Omega} \nabla \psi \cdot \nabla u \, d\Omega = 0, \, \forall \, \psi
\end{equation}

Later, we will explain what, exactly, we mean by "weak form" when we discuss the Galerkin FEM, so don't worry about this just yet.

## MOOSE Objects id=objects

The idea of object-oriented programming is to create many different functions that process a well-defined and unique task, and then call upon them wherever necessary <!--Provide link to discussion of OOP somewhere on the website here-->. When we talk about objects in C++ programming, in general, it could mean several different things. When we talk about objects in MOOSE, we are usually referring to a particular C++ class that exists within the MOOSE source code. We may also be referring to a sub-class, or a class which inherits from another one and uses it as a template. Examples of MOOSE objects include the `Kernel` and `Material` classes, as well as all of the classes which inherit from these.

For this step, we'll need some MOOSE object that's capable of solving the Laplace equation. Indeed, there exists within the MOOSE Framework a `Diffusion` object, which is itself a type of `Kernel`:

!listing framework/include/kernels/Diffusion.h
         start=class

In `Diffusion.h`, we have identified the `Diffusion` class and provided the data type and name of the functions it performs. Conceptually, this is the purpose of header files, which have the `.h` extension, in C++ programming. However, we don't see any sign of [laplace] nor [weak] here. Actually, we provide this as part of another file:

!listing framework/src/kernels/Diffusion.C
         re=Real\sDiffusion::computeQpResidual.*?^}

Here, we clearly see the integrand on the left-hand side of [weak]. All that's left now is to evaluate the integral. Once we take care of that, we have ourselves a completed MOOSE object that can solve [laplace]. We'll discuss how integration is handled later in this tutorial.

## Input Files id=inputs

If the C++ content given in the previous section seems strange or intimidating to you, don't worry, it's not important right now. What we have been able to show, however, is how we implement a PDE in the form of a MOOSE object. We then use these objects to solve problems by writing an input file, for which we append the `.i` extension to. For such files, MOOSE uses the "hierarchical input text" (hit) format. More often, we refer to this input style as being block structured. To demonstrate this format, we'll invoke our diffusion object by the following syntax:

!listing tutorials/darcy_thermo_mech/step01_diffusion/problems/step1.i block=Kernels

Note that, we could have also input `type = Diffusion`, but here, we're using a variant of this object whose difference is not important at the moment.

For each block, which usually refers to some object like the `Kernel` class, we add sub-blocks, which usually refer to some inherited object like our `Diffusion` class. Within each sub-block, any number of name/value pairs are provided, and these correspond to the parameters required for a given MOOSE object. Our diffusion object doesn't need any inputs except the variable for which to operate on. Variables also have their own block in input files. At the very least, a MOOSE input file requires the following six block types:

- `[Mesh]`: Define the geometry of the domain
- `[Variables]`: Define the unknown(s) of the problem
- `[Kernels]`: Define the equation(s) to solve
- `[BCs]`: Define the boundary condition(s) of the problem
- `[Executioner]`: Define how the problem will solve
- `[Outputs]`: Define how the solution will be written

The names of blocks suggest what types of MOOSE objects belong to them and the tasks they perform. It should be obvious that, for the most basic finite element analysis problems, we need to define the mesh, variables, equations, and boundary conditions. We also need to decide how we're going to handle the algebra and record the results, so for these purposes, we include the `[Executioner]` and `[Outputs]` blocks. Thus, we will include these six blocks when writing the input file for our diffusion problem.

!alert note title=Here's a tip
If you're ever wondering where to put a sub-block type, visit the [Source Documentation](source/index.md) page and check which block type that object is filed under. You'll also notice that the block structure of an input file is directly related to how the `/src` directories in the MOOSE repository are organized.

### Execute an Input File id=execute

There are a couple of ways to go about executing your input file, but, regardless of which, you'll need an executable. C++ is sometimes referred to as a compiled, or machine, language, because your entire application's code must be first transcribed into a single file that is more suitable for binary computations. During this transcription, your code may even be optimized for speed and data allocation, which makes C/C++, perhaps, the most computationally efficient programming languages in existence. For this tutorial, we have already built MOOSE applications that you may compile yourself. To do this for the current step, you'll want to run the following commands in your system's terminal:

```bash
cd ~/projects/moose/tutorials/darcy-thermo_mech/step01_diffusion
make -j 12 # use number of processors available on your system, i.e., 2, 4, ..., 12, or <N_procs>
```

This should create a file called `darcy_thermo_mech-opt` in the `step01_diffusion` directory, which we will use to run the input file.

!alert note title=MOOSE Applications
You may visit our [Getting Started](getting_started/index.md) page to learn more about creating and compiling custom MOOSE applications <!--also mention C++ appendix if I create one and talk about make files and compiling-->.

The most basic way to execute your input file is from your system's terminal. All you have to do is navigate to the directory where your input file is stored, and pass it to the application's executable with the `-i` command. For our problem, run the following commands:

```bash
cd ~/projects/moose/tutorials/darcy-thermo_mech/step01_diffusion/problems
../darcy_thermo_mech-opt -i step1.i
```

MOOSE will then process your finite element simulation and populate the input file directory with all of the requested outputs, e.g., ExodusII or comma delimited files. Here, a file called `step1_out.e` should have been created. As we mentioned in the [Helpful Software](workshop.md#helpful-software) section of this workshop, you can open this file to vizualize the results of your solution with PEACOCK or ParaView. We also mentioned that MOOSE has its own GUI: [PEACOCK](application_usage/peacock.md), which provides us with the second way in which you may execute an input file. For our problem, run the following commands:

```bash
cd ~/projects/moose/tutorials/darcy-thermo_mech/step01_diffusion/problems
~/projects/moose/python/peacock/peacock -i step1.i
```

This will open up the PEACOCK window and the first thing you'll notice is a planar mesh of the pressure vessel pipe. To execute our input file, you'll need to click on the "Execute" tab and then click "Run". Once the solve completes, you may click on the "ExodusViewer" tab to view the results<!--I should provide a graphic for this-->.

Finally, we have demonstrated the two basic ways to execute your input file. Note that, for PEACOCK, the command-line syntax can be simplified by creating a bash alias for it. Be sure to visit our documentation page for PEACOCK to learn how to do this.

## Demonstration id=demo

### Input File id=input-demo

Here, we'll set up the input file to model the steady-state diffusion of pressure over the length of the pipe. Remember that we require the six basic blocks that were mentioned in [#inputs].
For the `[Mesh]` block, we'll set up the geometry of the pipe, whose dimensions were provided in the [Problem Statement](tutorial.md#problem). We'll then add the pressure variable, $u$, to the `[Variables]` block. After that, we will add our `[Kernels]` block, which we've already seen how to set up.

Now that we have our domain, $\Omega$, our primary variable, $u$, and our PDE input, we'll enforce the boundary value problem given in [#physics] by invoking the `DirichletBC` object under the `[BCs]` block. Obviously, the `DirichletBC` object will enforce our Dirichlet, or essential, boundary conditions, i.e., the pressures prescribed at the pipe's inlet and outlet (note that, we need not enforce our natural boundary conditions, $\nabla u \cdot \hat{n}$, for this problem). Finally, we will call upon a steady-state executioner object to solve our problem, using Newton's method, and output the solution in ExodusII format by adding the `[Executioner]` and `[Outputs]` blocks, respectively.

!listing step01_diffusion/problems/step1.i

You'll notice that we've also added a `[Problems]` block here. The purpose of this was to indicate that our planar mesh is part of an asymmetric body and solve our finite element problem in a cylindrical coordinate system. There are, of course, several block types beyond the six core ones - many of which we will see throughout this tutorial.

### Results id=result-demo

In [#execute], we talked about how to visualize the result of your finite element simulation, but, just in case you missed it, you may run the following command:

```bash
cd ~/projects/moose/tutorials/darcy-thermo_mech/step01_diffusion/problems
~/projects/moose/python/peacock/peacock -r step1_out.e
```

If, by now, you've executed `step1.i`, the PEACOCK window will open up to the "ExodusViewer" tab and you should see a result which resembles that shown in [results]. Notice that the FEM solution satisfies the boundary conditions given in [#physics], i.e., a pressure of 4000-Pa can be observed at the inlet and zero pressure at the outlet. The pressure distribution over the length of the pipe also appears to be uniform across its radius, indicating that there is no flux through any of the remaining boundaries. Thus, $\nabla u \cdot \hat{n} = 0$ is also satisfied at those boundaries.

!media step01_result.png
       style=width:100%;margin-left:auto;margin-right:auto;
       id=results
       caption=Rendering of FEM solution of [laplace] subject to the boundary value problem given in [#physics].
<!--this image needs to be cropped - way too much white space-->
