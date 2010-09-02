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

#ifndef DAMPERWAREHOUSE_H
#define DAMPERWAREHOUSE_H

#include "Damper.h"

#include <vector>
#include <map>
#include <set>

/**
 * Typedef to hide implementation details
 */
typedef std::vector<Damper *>::iterator DamperIterator;


/**
 * Holds dampers and provides some services
 */
class DamperWarehouse
{
public:
  DamperWarehouse();
  virtual ~DamperWarehouse();

  DamperIterator dampersBegin();
  DamperIterator dampersEnd();

  void addDamper(Damper *damper);

protected:
  std::vector<Damper *> _dampers;
};

#endif // DAMPERWAREHOUSE_H
