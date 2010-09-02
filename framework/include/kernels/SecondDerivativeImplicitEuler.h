/****************************************************************/
/*               DO NOT MODIFY THIS HEADER                      */
/* MOOSE - Multiphysics Object Orieneted Simulation Environment */
/*                                                              */
/*            @ 2010 Battelle Energy Alliance, LLC              */
/*                   ALL RIGHTS RESERVED                        */
/*                                                              */
/*          Prepared by Battelle Energy Alliance, LLC           */
/*            Under Contract No. DE-AC07-05ID14517              */
/*            With the U. S. Department of Energy               */
/*                                                              */
/*            See COPYRIGHT for full restrictions               */
/****************************************************************/

#ifndef SECONDDERIVATIVEIMPLICITEULER_H
#define SECONDDERIVATIVEIMPLICITEULER_H

#include "Kernel.h"

//Forward Declarations
class SecondDerivativeImplicitEuler;

template<>
InputParameters validParams<SecondDerivativeImplicitEuler>();

class SecondDerivativeImplicitEuler : public Kernel
{
public:

  SecondDerivativeImplicitEuler(std::string name, MooseSystem & moose_system, InputParameters parameters);
  
protected:
  virtual Real computeQpResidual();

  virtual Real computeQpJacobian();

};
#endif //SECONDDERIVATIVEIMPLICITEULER_H
