# Welcome to the MOOSE Workshop!

### Purpose

Our workshop is intended to introduce developers to the basics of MOOSE, train them on how to contribute to the Framework and create their own applications, and provide simple tutorials and demonstrations showing how to implement new capabilities and solve problems. MOOSE is under a constant state of development, and its open-sourced coding style allows anyone, from anywhere in the world, to make contributions and improve the software, including you. This workshop will focus on the fundamental C++ classes that are available in MOOSE, which are used to solve any given physics problem, such as +Kernels+, +Materials+, +BCs+ (boundary conditions), and +UserObjects+. In addition, we will discuss our +Mesh+ class used to set up problem geometry, our +Preconditioner+ and +Executioner+ classes used to control the numerical solution, our +PostProcessors+ and +Outputs+ classes used to analyze and interpret results, and so much more. Finally, we will introduce more advanced topics, e.g., dynamics, contact, and other physics modules.

### How to Use This Manual id=how-to

This workshop is broken up into chapters, and some chapters are further subdivided into individual sections (see [#TOC]).
Aside from the [Tutorial](tutorial.md) chapter, the reader need not proceed through the sections in any particular order, and they should work at their own pace or even skip over anything that may seem redundant to them. Historically, we have hosted [#lws] which required interested developers to wait for the dates in which they occur and then travel to a, potentially, far away location. However, to better support our growing user-base, we have created this online version of the workshop, which provides significant advantages over the in-person version. We hope that participants will fully engage themselves in the tutorials and attempt to reproduce the results of demonstrations. It is strongly encouraged that you carefully read through the content we have provided. Rest assured you will be writing new MOOSE objects in no time!

While it is generally assumed that the reader has some background in computer programming, specifically, with C/C++, we will refer them to helpful pages located elsewhere on our website throughout the tutorials. We have also provided an entire chapter dedicated to the basics of object-oriented programming and C++ coding at the end of this manual for anyone not familiar with these topics or needs a refresher. For those of you who have no interest in application development, and simply wish to use our free software to solve problems or conduct research, it is still highly recommended that you follow this guide and consider taking on the challenge of contributing to the Framework.

!!!
*need to explain a few more things here* :

- nagivation, buttons, links

  - might be helpful to show pictures or graphics to explain this

- the greater MOOSE website will be referenced
- you will need to download and install the MOOSE package (compile, etc.) (see getting started)
- we are always available to contact (google groups)
!!!

## Live Workshops id=lws

The core MOOSE team at the INL will occasionally host a Live workshop at some specified destination in the United States, usually, on site or at some location near the laboratory in Idaho Falls, ID. Registration is open for all who wish to attend, although space is typically limited.

!!!
*need to explain a few more things here* :

- [Workshop Slides](https://www.mooseframework.org/workshop)
- how do we usually announce this?
- how often (more exactly) do we run these?
- how can some be sure they find out when one is happening? mailing list? moose-announce google group?
!!!

## Supplements, Links, Etc.

In addition to this workshop, be sure to explore all of the helpful resources available on the MOOSE Framework website. The following links are especially important for beginners to be aware of:

- [Getting Started/Installing MOOSE](getting_started/index.md)
- [Example Problems](examples/index.md)
- [MOOSE Users Mailing List](https://groups.google.com/forum/#!forum/moose-users)
- [Contact Us](help/contact_us.md)

### Helpful Software id=helpful-software

The first thing you will need to begin using MOOSE is a proper operating system. If you have a Mac, then you're in good shape. For PC users, we recommended installing some flavor of Linux OS on your machine. While we are working on support for Windows, MOOSE is most compatible with Unix-based systems. If you've never used Linux before, and don't have a Mac, consider trying [Ubuntu](https://www.ubuntu.com). It is the most popular flavor of Linux and has long-term support for its users.

Next, you'll need an editor. While there are many options available, many MOOSE developers prefer [Atom](https://atom.io), and so we recommend this application as your choice of text editor. We especially recommend Atom, because we have developed the following add-ons, specifically, for MOOSE:

- [autocomplete-moose](https://atom.io/packages/autocomplete-moose)
- [language-moose](https://atom.io/packages/language-moose)
- [linter-moose](https://atom.io/packages/linter-moose)
- [moose-doxygen](https://atom.io/packages/moose-doxygen)

Using Atom, along with those packages listed above, will considerably improve your experience when writing new MOOSE C++ objects or input files.

Finally, it will be extremely helpful to have some sort of graphical post-processor, particularly one that can read ExodusII files. We have developed our own graphical user-interface (GUI): [PEACOCK](application_usage/peacock.md), which can do much more than open ExodusII files, but we'll talk more about this later. Another option that we recommend trying is [ParaView](https://www.paraview.org/). Both of these applications are free and will allow you to visualize and process the results of your problems.

## Table of Contents id=TOC

<!--It would be nice to have a bit more freedom on how I can present this table of contents. For example, it would be nice if I could use indents instead of a bulleted list, and structure it manually-->

- [Preface](preface.md)

  - [Introduction to the MOOSE Framework](preface.md#moose-intro)
  - [What is the Finite Element Method?](preface.md#fem?)

- [Part 1: Tutorial](tutorial.md)

  - [Problem Statement](tutorial.md#problem)
  - [Tutorial Steps](tutorial.md#steps)

    1. [Creating and Executing a MOOSE Object](step01.md)
    2. *To be continued...*
