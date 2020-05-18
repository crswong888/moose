# Step 13: Material Coupling

!---

## Temperature Dependence

Viscosity, density, thermal conductivity, and specific heat capacity of the fluid are setup to vary
as a function of temperature.


!---

## Step 13: Input File

!listing step06_coupled_darcy_heat_conduction/problems/step6b_transient_inflow.i

!---

## Step 6b: Run and Visualize with Peacock

```bash
cd ~/projects/moose/tutorials/darcy-thermo_mech/step06_coupled_darcy_heat_conduction
make -j 12 # use number of processors for you system
cd problems
~/projects/moose/python/peacock/peacock -i step6b_transient_inflow.i
```

!---

## Step 6b: Results

!media step06b_result.mp4
