# MOOSE Workshop

!style halign=center
www.mooseframework.org

!---

!include intro/inl_background.md

!---

!include intro/moose_introduction.md

!---

!include intro/moose_multiphysics.md

!---

!include problem/overview.md

!---

!include problem/summary.md

!---

!include problem/step01.md

!---

!include numerical/fem_overview.md

!---

!include numerical/fem_shape.md

!---

!include numerical/fem_solve.md

!---

!include cpp/01_basics.md

!---

!include cpp/02_scope.md

!---

!include cpp/03_types.md

!---

!include cpp/04_classes.md

!---

!include cpp/standards.md

!---

!include problem/step02.md end=end-intro

!---

!include systems/mooseobject.md

!---

!include systems/inputparameters.md

!---

!include systems/kernels.md end=end-non-ad-kernel

!---

# Step 2: Pressure Kernel id=step02b

## (continued)

!include problem/step02.md start=end-intro

!---

# Kernel System

## (continued)

!include systems/kernels.md start=end-non-ad-kernel end=end-ad-kernel

!---

!include problem/step03.md

!---

# Kernel System

## (continued)

!include systems/kernels.md start=end-non-ad-kernel start=end-ad-kernel

!---

!include problem/step04.md

!---

!include problem/laplace_young.md

!---

!include systems/mesh.md

!---

!include systems/outputs.md

!---

!include problem/step05.md end=end-intro

!---

!include systems/materials.md end=end-non-ad-material

!---

# Step 5: Pressure Kernel with Material id=step05

## (continued)

!include problem/step05.md start=end-intro

!---

!include infrastructure/testing.md

!---

!include problem/step06.md end=end-intro

!---

!include systems/functions.md

!---

# Step 6: Function Properties id=step06

## (continued)

!include problem/step06.md start=end-intro

!---

!include problem/step07.md end=end-intro

!---

# Material System

## (continued)

!include systems/materials.md start=end-non-ad-material

!---

# Step 7: Material with AD Properties

## (continued)

!include problem/step07.md start=end-intro

!---

!include problem/step08.md end=end-intro

!---

!include systems/auxkernels.md

!---

# Step 8: Velocity Auxiliary Variable

## (continued)

!include problem/step08.md start=end-intro

!---

!include problem/step09.md end=end-steady

!---

!include systems/executioners.md

!---

!include systems/timeintegrators.md

!---

!include systems/timesteppers.md

!---

# Step 9: Heat Conduction id=step09

## (continued)

!include problem/step09.md start=end-steady

!---

!include problem/step10.md end=end-intro

!---

!include systems/initialconditions.md

!---

# Step 10: Variable Starting Temperature

## (continued)

!include problem/step10.md start=end-intro

!---

!include problem/step11.md end=end-intro

!---

!include systems/boundaryconditions.md


!---

# Step 11: Outflow Boundary Condition

## (continued)

!include problem/step11.md start=end-intro

!---

!include problem/step12.md


!!STEP13...

!!!

!---

!include problem/step07.md end=end-intro


!---

!include systems/adaptivity.md end=end-intro

!---

# Step 7: Mesh Adaptivity id=step07b

## (continued)

!include problem/step07.md start=end-intro

!---

!include problem/step08.md end=end-intro

!---

!include systems/userobjects.md

!---

!include systems/postprocessors.md

!---

!include systems/vectorpostprocessors.md

!---

# Step 8: Postprocessors

## (continued)

!include problem/step08.md start=end-intro

!---

!include problem/step09.md end=end-intro

!---

!include modules/index.md

!---

# Step 9: Mechanics id=step09b

## (continued)

!include problem/step09.md start=end-intro

!---

!include problem/step10.md end=end-intro

!---

!include systems/multiapps.md

!---

!include systems/transfers.md

!---

# Step 10: Multiscale Simulation id=step10b

## (continued)

!include problem/step10.md start=end-intro

!---

!include problem/step11.md end=end-intro

!---

!include systems/actions.md

!---

# Step 11: Custom Syntax id=step11b

## (continued)

!include problem/step11.md start=end-intro

!---

!include infrastructure/mms.md

!---

!include infrastructure/debugging.md

!---

!include infrastructure/restart.md

!---

!include systems/index.md

!!!

!---

!bibtex bibliography title-level=1
