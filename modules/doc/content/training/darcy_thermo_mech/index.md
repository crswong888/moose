# Coupled Darcy Flow and Thermomechanics Tutorial

Welcome to the first tutorial of the MOOSE Workshop! Here, new user's will work through the steps to create and solve a few simple physics problems using the MOOSE Framework. As the tutorial progresses, the core C++ classes that are available to developers and the basic components of a MOOSE object will be discussed. Demonstrations of how to set up the input files that invoke those objects, as well as their functions, and how to execute an application with those inputs, will be presented. Meanwhile, the theory behind the Galerkin [!ac](FEM), and the instructions for how to how to convert the problem's governing [!ac](PDEs) into an expression that is compatible with MOOSE, will be provided.

<!-- maybe here it is okay to say "you" or "your">-->

## Purpose

Historically, this tutorial has been the focus of the [live hosted workshops](training/index.md#lws). To better support the growing user-base, this online online version of the workshop was created to provide details typically discussed in the live version. New users are encouraged to engage themselves in this training by reading the content carefully and reproducing the steps, without simply copying and pasting code. Rest assured, you will be working on your custom application in no time! <!-- I really like this last sentence as it is... what do you think?-->

!! TODO: link to the slides here

This tutorial is designed to be an in-depth explanation of creating a complete, custom multiphysics application including the process of using a [git](https://git-scm.com) repository and tests.

## Tutorial Steps id=steps

!!!
We need have a simple command for building the contents, the `!content list` command should be what we use/improve. Right now, it doesn't seem to be working how we want it to.
!content list location=training/darcy_thermo_mech
!!!

- [Problem Statement](problem_statement.md)
- [Step 1: Creating and Executing a MOOSE Object](step01.md)

  - [Statement of Physics](step01.md#physics)
  - [MOOSE Objects](step01.md#physics)
  - [Input Files](step01.md#inputs)

    - [Execute an Input File](step01.md#execute)

  - [Demonstration](step01.md#demo)

    - [Input File](step01.md#input-demo)
    - [Results](step01.md#results-demo)

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
