# Step 13: Material Coupling id=step13

!---

## Temperature Dependence

+Viscosity+, +density+, +thermal conductivity+, and +specific heat capacity+ of the fluid are
all depend on temperature.

This dependence is added by adding an optional lookup table that contains a relationship
between temperature and the desired value.


!---

## PackedColumn.h

!listing step13_material_coupling/include/materials/PackedColumn.h

!---

## PackedColumn.C

!listing step13_material_coupling/src/materials/PackedColumn.C

!---

## Step 13: Input File

!listing step13_material_coupling/problems/coupled.i

!---

## Step 13: Run and Visualize with Peacock

```bash
cd ~/projects/moose/tutorials/darcy-thermo_mech/step13_material_coupling
make -j 12 # use number of processors for you system
cd problems
~/projects/moose/python/peacock/peacock -i coupled.i
```

!---

## Step 13: Results

!!media step13_result.mp4
