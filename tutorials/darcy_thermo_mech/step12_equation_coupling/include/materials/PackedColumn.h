//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "ADMaterial.h"

// A helper class from MOOSE that linear interpolates x,y data
#include "LinearInterpolation.h"

/**
 * Material-derived objects override the computeQpProperties()
 * function.  They must declare and compute material properties for
 * use by other objects in the calculation such as Kernels and
 * BoundaryConditions.
 */
class PackedColumn : public ADMaterial
{
public:
  static InputParameters validParams();

  PackedColumn(const InputParameters & parameters);

protected:
  /// Necessary override. This is where the values of the properties are computed.
  virtual void computeQpProperties() override;

  /// The radius of the spheres in the column
  const Function & _radius;

  /// Value of viscosity from the input file
  const Real & _input_viscosity;

  /// Compute permeability based on the radius (mm)
  ADLinearInterpolation _permeability_interpolation;

  /// The permeability (K)
  ADMaterialProperty(Real) & _permeability;

  /// The viscosity of the fluid (mu)
  MaterialProperty<Real> & _viscosity;

  usingMaterialMembers;
};
