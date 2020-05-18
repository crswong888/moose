# Coupled Darcy Flow and Thermomechanics Tutorial

!! Provide a brief introduction here to the problem, two or three sentences.

## Purpose

This tutorial is broken up into parts, which are further divided into individual chapters (see [#TOC]). Historically, this tutorial has been the focus of the [live hosted workshops](training.md#lws). To better support the growing user-base, this online online version of the workshop was created to provide details typically provided in the live workshop. Readers are encouraged to engage themselves in this training by reading the content carefully and reproducing the steps, without copy and pasting. Rest assured you will be working on your custom application in no time!

!! TODO: link to the slides here

This tutorial is designed to be an in-depth explanation of creating a complete, custom multiphysics application including the process of using a [git](https://git-scm.com) repository and tests.

## Table of Contents id=TOC

!!!
We need have a simple command for building the contents, the `!content list` command should be what we use/improve.
!!!

!content list location=training/darcy_thermo_mech

<!--It would be nice to have a bit more freedom on how I can present this table of contents. For example, it would be nice if I could use indents instead of a bulleted list, and structure it manually-->

- [Preface](preface.md)

  - [Introduction to the MOOSE Framework](preface.md#moose-intro)
  - [What is the Finite Element Method?](preface.md#fem?)

- [Part 1: Tutorial](tutorial.md)

  - [Problem Statement](tutorial.md#problem)
  - [Tutorial Steps](tutorial.md#steps)

    1. [Creating and Executing a MOOSE Object](step01.md)
    2. *To be continued...*
