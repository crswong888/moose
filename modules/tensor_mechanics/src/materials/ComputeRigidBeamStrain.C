// TODO: A lot of this stuff, which comes almost verbatim from computeIncrementalBeamStrain, could
// be moved to a utils or some type of base class for beam strain.

#include "ComputeRigidBeamStrain.h"

// MOOSE includes

registerMooseObject("TensorMechanicsApp", ComputeRigidBeamStrain);

InputParameters
ComputeRigidBeamStrain::validParams()
{
  InputParameters params = Material::validParams();

  params.addClassDescription("");

  params.addRequiredCoupledVar(
      "displacements",
      "The displacements appropriate for the simulation geometry and coordinate system");
  params.addRequiredCoupledVar(
    "rotations", "The rotations appropriate for the simulation geometry and coordinate system");

  params.addParam<Real>(
      "penalty", 1.0e+08, "The penalty stiffness coefficient.");

  return params;
}

ComputeRigidBeamStrain::ComputeRigidBeamStrain(const InputParameters & parameters)
  : Material(parameters),
  _ndisp(coupledComponents("displacements")),
  _nrot(coupledComponents("rotations")),
  _disp_num(_ndisp),
  _rot_num(_nrot),
  _penalty(getParam<Real>("penalty")),
  _material_stiffness(declareProperty<RealVectorValue>("material_stiffness")),
  _material_flexure(declareProperty<RealVectorValue>("material_flexure")),
  _original_length(declareProperty<Real>("original_length")),
  _total_rotation(declareProperty<RankTwoTensor>("total_rotation")),
  _nl_sys(_fe_problem.getNonlinearSystemBase()),
  _disp_strain_increment(declareProperty<RealVectorValue>("mech_disp_strain_increment")),
  _rot_strain_increment(declareProperty<RealVectorValue>("mech_rot_strain_increment")),
  _K11(declareProperty<RankTwoTensor>("Jacobian_11")),
  _K21_cross(declareProperty<RankTwoTensor>("Jacobian_12")),
  _K21(declareProperty<RankTwoTensor>("Jacobian_21")),
  _K22(declareProperty<RankTwoTensor>("Jacobian_22")),
  _K22_cross(declareProperty<RankTwoTensor>("Jacobian_22_cross"))
{
  // Checking for consistency between length of the provided displacements and rotations vector
  if (_ndisp != _nrot)
    mooseError("In ComputeRigidBeamStrain ",
               _name,
               ": The number of variables supplied in 'displacements and 'rotations' must match.");

  // fetch coupled variables and gradients (as stateful properties if necessary)
  for (unsigned int i = 0; i < _ndisp; ++i)
  {
    MooseVariable * disp_variable = getVar("displacements", i);
    _disp_num[i] = disp_variable->number();

    MooseVariable * rot_variable = getVar("rotations", i);
    _rot_num[i] = rot_variable->number();
  }

  // TODO: I need to ensure that _material_stiffness and _material_flexure aren't already declared
  // by some other object on the same block, i.e., by ComputeElasticityBeam.
  //
  // OR! I need to get the material property instead of declare it here if it is. If this were
  // the case, I would simply use the penalty coefficient to multiply these properties, ensuring
  // that the rigid stiffness controls relative to a nominal one. But, wether to declare these
  // properties using ComputeElasticityBeam or just declare them here would be a user's choice.
}

void
ComputeRigidBeamStrain::initQpStatefulProperties()
{
  // Calculation of beam geometric properties are independent of the current _qp index, so only
  // only perform them for the first point and then copy their reults to all other points.
  if (_qp == 0)
  {
    // Set the beam eleastic properties as the penalty coefficient
    _material_stiffness[0](0) = _penalty;
    _material_stiffness[0](2) = _penalty;
    _material_stiffness[0](1) = _penalty;

    // material_flexure relates the rotational strains to moments
    _material_flexure[0](0) = _penalty;
    _material_flexure[0](1) = _penalty;
    _material_flexure[0](2) = _penalty;

    // calculate original length of beam element - "master" = node_ptr(0) and "slave" = node_ptr(1)
    //
    //devel Note: I'm not sure I really understand the purpose of only computing the number of beam
    // length components equal to the number of displacements as in computeIncrementalBeamStrain ...
    // A user shouldn't have a beam run into a dimension where there not interested in displacement in
    // the first place. If we really want to enforce this, then we should provide some warning in the
    // constructor about the num of disp not being equal to the problem dimensions. Also, computing
    // the length over the (unsigned int i = 0; i < _ndisp; ++i) loop does not gaurantee that the
    // length is computer along the respective axes, for example, what if a user only specified
    // displacements = 'disp_y disp_z', this loop is going to account for the x and y components of
    // length... (assuming the user doesn't consider the disp_y and disp_z the 0 and 1 components).
    // ALSO! If we're going to compute the beam length like this, then we should also compute
    // the _total_rotation vector in this way (I think... this might not apply in the same way.)
    // If we ARE gonna do this loop, we should somehow appropriately link it to _disp_num not _ndisp
    _dxyz = (*_current_elem->node_ptr(1)) - (*_current_elem->node_ptr(0));
    _original_length[0] = _dxyz.norm();

    for (unsigned int i = 0; i < 3; ++i) //devel
    {
      std::cout << "_dxyz(" << i << ") = " << _dxyz(i) << "\n";
    }

    // compute initial orientation of the beam for calculating initial rotation matrix
    //
    //devel Note: not sure how this is going to effect my formulation, cuz the orientation is implicit
    // in the formulation.
    //
    //devel Note: Perhaps there is some way I can derive the multi-freedom constriaint equations in
    // terms of the rotation matrix. In the local configuration - all that matters is that the 2 nodes
    // don't move along the beam axis relative to one another, so I suspect that this is the case.
    //
    //devel Note: get_dxyzdxi seems to return the QP Jacobian map (dNdxi * nodal global coordinates)
    // which seems to basically be the absolute location of the QP relative to an end-node in global
    RealVectorValue x_orientation = _dxyz / _dxyz.norm();

    // There exists an infinite number of vectors which are perpindicular to x_orientation. For a
    // rigid beam, the cross-sectional axes are trivial - so simply rotate the y-axis about the
    // z-axis by the same amount that x_orientation has from the x-axis to get a y_orientation
    RealVectorValue y_orientation;
    y_orientation(0) = -x_orientation(1);
    y_orientation(1) = x_orientation(0);

    // Now, the z_orientation is automatically determined by the cross-product
    RealVectorValue z_orientation;
    z_orientation(0) = (x_orientation(1) * y_orientation(2) - x_orientation(2) * y_orientation(1));
    z_orientation(1) = (x_orientation(2) * y_orientation(0) - x_orientation(0) * y_orientation(2));
    z_orientation(2) = (x_orientation(0) * y_orientation(1) - x_orientation(1) * y_orientation(0));

    // And finally, the 3x3 matrix describing the beams local axes is
    _original_local_config(0, 0) = x_orientation(0);
    _original_local_config(0, 1) = x_orientation(1);
    _original_local_config(0, 2) = x_orientation(2);
    _original_local_config(1, 0) = y_orientation(0);
    _original_local_config(1, 1) = y_orientation(1);
    _original_local_config(1, 2) = y_orientation(2);
    _original_local_config(2, 0) = z_orientation(0);
    _original_local_config(2, 1) = z_orientation(1);
    _original_local_config(2, 2) = z_orientation(2);

    _total_rotation[0] = _original_local_config;


    for (unsigned int i = 0; i < 3; ++i) //devel
      for (unsigned int j = 0; j < 3; ++j)
      {
        std::cout << "_original_local_config(" << i << ", " << j << ") = "
                  << _original_local_config(i, j) << "\n";
      }

  }
  else
  {
    _original_length[_qp] = _original_length[0];
    _total_rotation[_qp] = _total_rotation[0];
    _material_stiffness[_qp] = _material_stiffness[0];
    _material_flexure[_qp] = _material_flexure[0];
  }
}

void
ComputeRigidBeamStrain::computeProperties()
{
  // Fetch the solution for the two end nodes at time t
  const NumericVector<Number> & sol = *_nl_sys.currentSolution();
  const NumericVector<Number> & sol_old = _nl_sys.solutionOld();

  unsigned int disp0_sol_idx, rot0_sol_idx, disp1_sol_idx, rot1_sol_idx;
  for (unsigned int i = 0; i < _ndisp; ++i)
  {
    // Get indices of solution vector corresponding to DOFs at element local nodes
    disp0_sol_idx = (*_current_elem->node_ptr(0)).dof_number(_nl_sys.number(), _disp_num[i], 0);
    rot0_sol_idx = (*_current_elem->node_ptr(0)).dof_number(_nl_sys.number(), _rot_num[i], 0);
    disp1_sol_idx = (*_current_elem->node_ptr(1)).dof_number(_nl_sys.number(), _disp_num[i], 0);
    rot1_sol_idx = (*_current_elem->node_ptr(1)).dof_number(_nl_sys.number(), _rot_num[i], 0);

    // Compute current displacement & rotation increments
    _disp0(i) = sol(disp0_sol_idx) - sol_old(disp0_sol_idx);
    _rot0(i) = sol(rot0_sol_idx) - sol_old(rot0_sol_idx);
    _disp1(i) = sol(disp1_sol_idx) - sol_old(disp1_sol_idx);
    _rot1(i) = sol(rot1_sol_idx) - sol_old(rot1_sol_idx);
  }

  for (_qp = 0; _qp < _qrule->n_points(); ++_qp)
    computeQpStrain();

  if (_fe_problem.currentlyComputingJacobian())
    computeStiffnessMatrix();
}

void
ComputeRigidBeamStrain::computeQpStrain()
{
  // Rotate the gradient of displacements and rotations at t+delta t from global coordinate frame
  // to beam local coordinate frame
  const RealVectorValue grad_disp_0(1.0 / _original_length[0] * (_disp1 - _disp0));
  const RealVectorValue grad_rot_0(1.0 / _original_length[0] * (_rot1 - _rot0));
  const RealVectorValue avg_rot(
      0.5 * (_rot0(0) + _rot1(0)), 0.5 * (_rot0(1) + _rot1(1)), 0.5 * (_rot0(2) + _rot1(2)));

  _grad_disp_0_local_t = _total_rotation[0] * grad_disp_0;
  _grad_rot_0_local_t = _total_rotation[0] * grad_rot_0;
  _avg_rot_local_t = _total_rotation[0] * avg_rot;

  // axial and shearing strains at each qp along the length of the beam
  _disp_strain_increment[_qp](0) = _grad_disp_0_local_t(0);
  _disp_strain_increment[_qp](1) = -_avg_rot_local_t(2) + _grad_disp_0_local_t(1);
  _disp_strain_increment[_qp](2) = _avg_rot_local_t(1) + _grad_disp_0_local_t(2);

  // rotational strains (curvature) at each qp along the length of the beam
  _rot_strain_increment[_qp](0) = _grad_rot_0_local_t(0);
  _rot_strain_increment[_qp](1) = _grad_rot_0_local_t(1);
  _rot_strain_increment[_qp](2) = _grad_rot_0_local_t(2);

}

void
ComputeRigidBeamStrain::computeStiffnessMatrix()
{
  //devel Note: careful when computing _k11 - it looks like they do some sign convention stuff
  // in StressDivergenceBeam, as opposed to right in here.

  // relation between translational displacements at node 0 and translational forces at node 0
  RankTwoTensor K11_local;
  K11_local.zero();
  K11_local(0, 0) = _material_stiffness[0](0);
  K11_local(1, 1) = _material_stiffness[0](1);
  K11_local(2, 2) = _material_stiffness[0](1);
  _K11[0] = _total_rotation[0].transpose() * K11_local * _total_rotation[0];

  // relation between displacements at node 0 and rotational moments at node 0
  RankTwoTensor K21_local;
  K21_local.zero();
  K21_local(2, 1) = _material_stiffness[0](1) * 0.5;
  K21_local(1, 2) = -_material_stiffness[0](1) * 0.5;
  _K21[0] = _total_rotation[0].transpose() * K21_local * _total_rotation[0];

  // relation between rotations at node 0 and rotational moments at node 0
  RankTwoTensor K22_local;
  K22_local.zero();
  K22_local(0, 0) = _material_stiffness[0](1);
  K22_local(1, 1) = _material_stiffness[0](0) + _material_stiffness[0](1) / 4.0;
  K22_local(2, 2) = _material_stiffness[0](0) + _material_stiffness[0](1) / 4.0;
  _K22[0] = _total_rotation[0].transpose() * K22_local * _total_rotation[0];

  // relation between rotations at node 0 and rotational moments at node 1
  RankTwoTensor K22_local_cross = -K22_local;
  K22_local_cross(1, 1) += 2.0 * _material_stiffness[0](1) / 4.0;
  K22_local_cross(2, 2) += 2.0 * _material_stiffness[0](1) / 4.0;
  _K22_cross[0] = _total_rotation[0].transpose() * K22_local_cross * _total_rotation[0];

  // relation between displacements at node 0 and rotational moments at node 1
  _K21_cross[0] = -_K21[0];
}
