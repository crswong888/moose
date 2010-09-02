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

#ifndef PRINTDOFS_H
#define PRINTDOFS_H

#include "Postprocessor.h"

//Forward Declarations
class PrintDOFs;

template<>
InputParameters validParams<PrintDOFs>();

class PrintDOFs : public Postprocessor
{
public:
  PrintDOFs(std::string name, MooseSystem &moose_system, InputParameters parameters);
  
  virtual void initialize() {}
  
  virtual void execute() {}

  /**
   * This will return the degrees of freedom in the system.
   */
  virtual Real getValue();
};

#endif //PRINTDOFS_H
