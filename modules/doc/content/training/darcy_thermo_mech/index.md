# Coupled Darcy Flow and Thermomechanics Tutorial

In this tutorial user's will work through the steps to create and solve physics problems using MOOSE. As the tutorial progresses, the core C++ classes that are available to developers and the basic components of a MOOSE will be discussed. Demonstrations of how to set up the input files that invoke objects and associated methods will be presented. Meanwhile, the theory behind the Galerkin [!ac](FEM), and the instructions for how to how to convert the problem's governing [!ac](PDEs) into an expression that is compatible with MOOSE, will be provided.

This tutorial is the focus of the live hosted [workshops](https://www.mooseframework.org/workshop). New users are encouraged to engage themselves in this training by reading the content carefully and reproducing the steps, without simply copying and pasting code. Rest assured, you will be working on a custom application in no time!

This tutorial is designed to be an in-depth explanation of creating a complete, custom multiphysics application including the process of using a [git](https://git-scm.com) repository and tests.


!!!
We need have a simple command for building the contents, the `!content outline` command should be what we use/improve.

!content outline location=training/darcy_thermo_mech
!!!

- [Problem Statement](problem_statement.md)
- [Step 1: Creating and Executing a MOOSE Object](step01_moose_object.md)

  - [Statement of Physics](step01_moose_object.md#physics)
  - [MOOSE Objects](step01_moose_object.md#physics)
  - [Input Files](step01_moose_object.md#inputs)

    - [Execute an Input File](step01_moose_object.md#execute)

  - [Demonstration](step01_moose_object.md#demo)

    - [Input File](step01_moose_object.md#input-demo)
    - [Results](step01_moose_object.md#results-demo)

- <!--[Step 2: Generate a Weak Form and Create a Kernel Object]--> *To be continued...*

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
