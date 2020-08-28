#include "RigidBeam.h"

// MOOSE includes

registerMooseObject("TensorMechanicsApp", RigidBeam);

InputParameters
RigidBeam::validParams()
{
  InputParameters params = NodalConstraint::validParams();
  params.addClassDescription("");

  return params;
}

RigidBeam::RigidBeam(const InputParameters & parameters)
  : NodalConstraint(parameters)
{
}

Real
RigidBeam::computeQpResidual(Moose::ConstraintType /*type*/)
{
  return 0;
}

Real
RigidBeam::computeQpJacobian(Moose::ConstraintJacobianType /*type*/)
{
  return 0;
}
