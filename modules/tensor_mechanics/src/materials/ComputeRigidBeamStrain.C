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
  _mech_disp_strain_increment(declareProperty<RealVectorValue>("mech_disp_strain_increment")),
  _mech_rot_strain_increment(declareProperty<RealVectorValue>("mech_rot_strain_increment")),
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
  std::cout << "\n** initQpStatefulProperties() **\n"; //devel

  // calculate original length of beam element
  // "master" is node_ptr(0) and slave is node_ptr(1)
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

  for (unsigned int i = 0; i < _ndisp; ++i) //devel
  {
    std::cout << "_dxyz(" << i << ") = " << _dxyz(i) << "\n";
  }

  _original_length[_qp] = _dxyz.norm();

  // compute initial orientation of the beam for calculating initial rotation matrix
  //
  //devel Note: not sure how this is going to effect my formulation, cuz the orientation is implicit
  // in the formulation.
  //
  //devel Note: Perhaps there is some way I can derive the multi-freedom constriaint equations in
  // terms of the rotation matrix. In the local configuration - all that matters is that the 2 nodes
  // do move along the beam axis relative to one another, so I suspect that this is the case.
  //
  //devel Note: get_dxyzdxi seems to return the QP Jacobian map (dNdxi * nodal global coordinates)
  // which seems to basically be the absolute location of the QP relative to an end-node in global
  const std::vector<RealGradient> * orientation =
      &_subproblem.assembly(_tid).getFE(FEType(), 1)->get_dxyzdxi();

  for (unsigned int i = 0; i < (*orientation).size(); ++i) //devel
    std::cout << "(*orientation)[" << i << "] = " << (*orientation)[i] << "\n";

  static int count = 0; //devel
  count++; //devel
}

void
ComputeRigidBeamStrain::computeProperties()
{
  std::cout << "\n** computeProperties() **\n"; //devel

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

  static int count = 0; //devel
  count++; //devel

  if (count == 2) //devel
    mooseError("Exiting to process results."); //devel
}

void
ComputeRigidBeamStrain::computeQpStrain()
{
  // Rotate the gradient of displacements and rotations at t+delta t from global coordinate
  // frame to beam local coordinate frame
  const RealVectorValue grad_disp_0(1.0 / _original_length[0] * (_disp1 - _disp0));
  const RealVectorValue grad_rot_0(1.0 / _original_length[0] * (_rot1 - _rot0));
  const RealVectorValue avg_rot(
      0.5 * (_rot0(0) + _rot1(0)), 0.5 * (_rot0(1) + _rot1(1)), 0.5 * (_rot0(2) + _rot1(2)));

  _grad_disp_0_local_t = _total_rotation[0] * grad_disp_0;
  _grad_rot_0_local_t = _total_rotation[0] * grad_rot_0;
  _avg_rot_local_t = _total_rotation[0] * avg_rot;


}
