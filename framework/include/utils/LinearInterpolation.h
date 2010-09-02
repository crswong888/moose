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

#ifndef LINEARINTERPOLATION_H
#define LINEARINTERPOLATION_H

#include <vector>
#include <fstream>
#include <sstream>
#include <string>


/**
 * This class applies the Least Squares algorithm to a set of points to provide a smooth curve for
 * sampling values.
 *
 * Requires: LAPACK
 */
class LinearInterpolation
{
public:

  /* Constructor, Takes two vectors of points for which to apply the fit.  One should be of the
   * independant variable while the other should be of the dependant varible.  These values should
   * correspond to one and other in the same position.
   */
  LinearInterpolation(std::vector<double> X, std::vector<double> Y);

  virtual ~LinearInterpolation()
    {}

  /**
   * This function will take an indenandant variable input and will return the dependant variable
   * based on the generated fit
   */
  double sample(double x);

  /**
   * This function will dump GNUPLOT input files that can be run to show the data points and
   * function fits
   */
  void dumpSampleFile(std::string base_name, std::string x_label="X", std::string y_label="Y", float xmin=0, float xmax=0, float ymin=0, float ymax=0);

  /**
   * This function returns the size of the array holding the points, i.e. the number of sample points
   */
  unsigned int getSampleSize();
  
private:

  std::vector<double> _x;
  std::vector<double> _y;

  static int _file_number;
};

#endif //LINEARINTERPOLATION_H
  
  
  
      
