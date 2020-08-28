#pragma once

// MOOSE includes
#include "NodalConstraint.h"

// Forward Declarations
class RigidBeam;

/**
 * <Description>
 */
class RigidBeam : public NodalConstraint
{
public:
  static InputParameters validParams();

  RigidBeam(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual(Moose::ConstraintType type) override;
  virtual Real computeQpJacobian(Moose::ConstraintJacobianType type) override;

  std::vector<unsigned int> _primary_node_ids;
};
