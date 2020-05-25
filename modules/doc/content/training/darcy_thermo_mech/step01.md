# Step 1: Creating and Executing a MOOSE Object

In this step, [#objects], and the purposes they serve, will be introduced.
Then, the way in which [!ac](FE) models are built by invoking several of those objects in a neat and organized fashion with MOOSE [#inputs] will be explained.
To demonstrate these two concepts, the reader shall consider a steady-state diffusion of pressure from one end of the pipe, between the pressure vessels, to the other (see [Problem Statement](problem_statement.md)). For this, a [!ac](BVP) that is so simple that the reader need not concern themselves with the physics and focus only on how to write the code to solve the governing equation, will be enforced. While there are important [!ac](FEM) and C++ concepts at work here, for now, simply consider them as a given.

## Statement of Physics id=physics

The Laplace equation shall be employed to model the steady-state diffusion of pressure, $u$, on $\Omega$. Thus, find $u$, such that

!equation id=laplace
-\nabla \cdot \nabla u = 0 \in \Omega

satisfies the following [!ac](BVP): $u = 4000 \, \textrm{Pa}$ at the inlet (left) boundary, $u = 0$ at the outlet (right) boundary, and $\nabla u \cdot \hat{n} = 0$, where $\hat{n}$ is the surface normal vector, on the remaining boundaries.

It is is necessary to acknowledge that [!ac](PDEs) must be expressed in a certain format to be able to solve them with MOOSE. That is, assuming that the natural boundary condition, $\nabla u \cdot \hat{n}$, is satisfied, then the *weak form* of [laplace] is

!equation id=weak
\int_{\Omega} \nabla \psi \cdot \nabla u \, d\Omega = 0, \, \forall \, \psi

Later, exactly what is meant by the terminology, "weak form," will be explained when the Galerkin [!ac](FEM) is discussed, so do not worry about this just yet.

## MOOSE Objects id=objects

The idea of object-oriented programming is to create many different functions that process a well-defined and unique task, and then call upon them wherever they are needed<!--Provide link to discussion of OOP somewhere on the website here-->. Generally, when one refers to objects in C++ programming it could mean several different things. More specifically, when one mentions objects in MOOSE, these are usually a reference to a particular C++ class that exists within the MOOSE source code. It may also be a reference to a sub-class, or a class which inherits from another one and uses it as a template. Examples of MOOSE objects include the `Kernel` and `Material` classes, as well as all of the classes which inherit from those.

For this step, some MOOSE object that is capable of solving the Laplace equation is needed. Fortunately, there exists within the MOOSE Framework a `Diffusion` object, which is, itself, a type of `Kernel`:

!listing framework/include/kernels/Diffusion.h
         start=class

In `Diffusion.h`, the `Diffusion` class has been identified, as well as the data types and names of the functions it performs. In essence, this is the purpose of header files, which have the `.h` extension, in C++ programming. Still, one might notice that there are no indications of [laplace] nor [weak] here. Actually, [weak] is provided as part of another file:

!listing framework/src/kernels/Diffusion.C
         re=Real\sDiffusion::computeQpResidual.*?^}

In the above code, one should recognize the integrand on the left-hand side of [weak].
This is why it was necessary to present this equation - MOOSE is designed to solve [!ac](PDEs) in this format. All that remains is to evaluate the integral. Once that is taken care of, a completed MOOSE object that can solve [laplace] will be realized. The means by which integration is handled will be discussed later in this tutorial.

## Input Files id=inputs

If the C++ content given in the previous section seems strange or intimidating, don't worry, it's not important right now. The main point was to show how to implement a [!ac](PDE) in the form of a MOOSE object. These objects are then used to solve problems by writing an input file, for which one appends the `.i` extension to. For such files, MOOSE uses the "hierarchical input text" (hit) format. More often, this input style is referred to as being block structured. To demonstrate this format, notice that the diffusion object may be invoked by the following syntax:

!listing tutorials/darcy_thermo_mech/step01_diffusion/problems/step1.i block=Kernels

Note that, one could have also input `type = Diffusion`, but here, a variant of this object, whose difference is not important at the moment, was used instead.

For each block, which usually refers to some object like the `Kernel` class, one adds sub-blocks, which usually refer to some inherited object like the `Diffusion` class. Within each sub-block, any number of name/value pairs are provided, and these correspond to the parameters required for a given MOOSE object. The diffusion object doesn't need any inputs except the variable for which to operate on, although, there are usually several more required. Variables also have their own block in input files. At the very least, a MOOSE input file requires the following six block types:

- `[Mesh]`: Define the geometry of the domain
- `[Variables]`: Define the unknown(s) of the problem
- `[Kernels]`: Define the equation(s) to solve
- `[BCs]`: Define the boundary condition(s) of the problem
- `[Executioner]`: Define how the problem will solve
- `[Outputs]`: Define how the solution will be written

The names of blocks suggest what types of MOOSE objects belong to them and the tasks they perform. It should be obvious that, for the most basic [!ac](FE) analysis problems, one must define the mesh, variables, equations, and boundary conditions. One must also decide how they're going to handle the algebra and record the results, so for these purposes, one includes the `[Executioner]` and `[Outputs]` blocks. Thus, these six blocks shall be included when the input file is written for the given diffusion problem.

!alert note title=Here's a tip
If you're ever wondering where to put a sub-block type, visit the [Source Documentation](source/index.md) page and check which block type that object is filed under. You'll also notice that the block structure of an input file is directly related to how the `/src` directories in the MOOSE repository are organized. <!--May I address the reader personally when I include things like helpful tips?-->

### Execute an Input File id=execute

There are a couple of ways to go about executing an input file, but, regardless of which, the major requirement is an executable. C++ is sometimes referred to as a compiled, or machine, language, because an application's entire code must be first transcribed into a single file that is more suitable for binary computations. During this transcription, a code may even be optimized for speed and data allocation, which makes C/C++, perhaps, the most computationally efficient programming languages in existence. For each step of this tutorial, a MOOSE application that the reader may compile themselves has already been built. To do this for the current step, one may run the following commands in their system's terminal:

```bash
cd ~/projects/moose/tutorials/darcy-thermo_mech/step01_diffusion
make -j 12 # use number of processors available on your system, i.e., 2, 4, ..., 12, or <N_procs>
```

This should create a file called `darcy_thermo_mech-opt` in the `step01_diffusion` directory, which will be used to run the input file.

!alert note title=MOOSE Applications
You may visit our [Getting Started](getting_started/index.md) page to learn more about creating and compiling custom MOOSE applications <!--also mention C++ appendix if I create one and talk about make files and compiling-->.

The most basic way to execute an input file is from a system's terminal. All a user needs to do is navigate to the directory where their input file is stored and then pass it to the application's executable with the `-i` command. For this problem, run the following commands:

```bash
cd ~/projects/moose/tutorials/darcy-thermo_mech/step01_diffusion/problems
../darcy_thermo_mech-opt -i step1.i
```

MOOSE will then process the [!ac](FE) simulation and populate the input file directory with all of the requested outputs, e.g., ExodusII or comma delimited files. Here, a file called `step1_out.e` should have been created. As mentioned in [Helpful Software](training/index.md#helpful-software), users can open this file to visualize the results of their solution with PEACOCK or ParaView. It was also mentioned that MOOSE has its own [!ac](GUI): [PEACOCK](application_usage/peacock.md). Coincidentally, PEACOCK provides the second way in which an input file may be executed. For this problem, run the following commands:

```bash
cd ~/projects/moose/tutorials/darcy-thermo_mech/step01_diffusion/problems
~/projects/moose/python/peacock/peacock -i step1.i
```

This will open the PEACOCK window and the first thing one may notice is a planar mesh of the pressure vessel pipe. To execute the input file, click on the "Execute" tab and then click "Run". Once the solve completes, click on the "ExodusViewer" tab to view the results<!--I should provide a graphic for this-->.

Finally, the two basic ways to execute an input file have been demonstrated. Note that, for PEACOCK, the command-line syntax can be simplified by creating a bash alias for it. Be sure to visit the documentation page for PEACOCK to learn how to do this.

## Demonstration id=demo

### Input File id=input-demo

In this section<!--chapter?-->, the reader will set up the input file to model the steady-state diffusion of pressure over the length of the pipe. Recall that six basic blocks - those which were mentioned in [#inputs] - are required.
For the `[Mesh]` block, the geometry of the pipe, whose dimensions were provided in the [Problem Statement](problem_statement.md) shall be defined. Then, the pressure variable, $u$, shall be added to the `[Variables]` block. Following that, the `[Kernels]` block, whose syntax has already been demonstrated, shall be included. Note that the blocks need not be developed in any particular order, but one which corresponds with the procedure for a typical [!ac](FE) analysis might be followed.

Now that the domain, $\Omega$, the primary variable, $u$, and the [!ac](PDE) have been specified, the [!ac](BVP), given in [#physics], must be enforced by invoking the `DirichletBC` object under the `[BCs]` block. Obviously, this object will enforce the Dirichlet, or essential, boundary conditions, i.e., the pressures prescribed at the pipe's inlet and outlet (note that, it is not necessary to enforce the natural boundary conditions, $\nabla u \cdot \hat{n}$, for this problem). Finally, a steady-state executioner object to solve the resulting system of equations, using Newton's method, shall be called upon, and its solution shall be output in ExodusII format by adding the `[Executioner]` and `[Outputs]` blocks, respectively.

!listing step01_diffusion/problems/step1.i

One may notice that, in addition to the basic six, a `[Problems]` block was included here. The purpose of this was to indicate that the planar mesh is part of an asymmetric body and to solve the [!ac](FE) problem with respect to a cylindrical coordinate system. There are, of course, several block types beyond the six core ones - many of which will be seen throughout this tutorial.

### Results id=result-demo

In [#execute],
some ways in which to visualize the results of the [!ac](FE) simulation were discussed, but, in case these were unclear or forgotten, consider another way to produce a rendering by running the following commands:

```bash
cd ~/projects/moose/tutorials/darcy-thermo_mech/step01_diffusion/problems
~/projects/moose/python/peacock/peacock -r step1_out.e
```

If, by now, the user executed `step1.i` from the terminal, then, after running the above commands, they will notice that the PEACOCK window opens to the "ExodusViewer" tab and they should see a result which resembles that shown in [results].
Notice that the [!ac](FEM) solution satisfies the boundary conditions given in [#physics], i.e., a pressure of 4000-Pa can be observed at the inlet and zero pressure at the outlet. The pressure distribution over the length of the pipe also appears to be uniform across its radius, indicating that there is no flux through any of the remaining boundaries. Thus, $\nabla u \cdot \hat{n} = 0$ is also satisfied at those boundaries.

!media step01_result.png
       style=width:100%;margin-left:auto;margin-right:auto;
       id=results
       caption=Rendering of [!ac](FEM) solution of [laplace] subject to the [!ac](BVP) given in [#physics].
<!--this image needs to be cropped - way too much white space-->
