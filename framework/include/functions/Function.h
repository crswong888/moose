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

#ifndef FUNCTION_H
#define FUNCTION_H

#include "MooseObject.h"

class Function;

template<>
InputParameters validParams<Function>();

/**
 * Base class for function objects.  Functions override operator() to supply a
 * value at a point.
 */
class Function : public MooseObject
{
public:
  Function(std::string name, MooseSystem & moose_system, InputParameters parameters);
  virtual ~Function();

  /**
   * Override this to evaluate the function at point (t,x,y,z)
   */
  virtual Real operator()(Real t, Real x, Real y = 0, Real z = 0) = 0;

  /**
   * Function objects can optionally provide a gradient at a point. By default
   * this returns 0, you must override it.
   */
  virtual RealGradient grad(Real t, Real x, Real y = 0, Real z = 0);
};

#endif //FUNCTION_H
