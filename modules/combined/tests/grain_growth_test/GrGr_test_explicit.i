[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 10
  ny = 10
  nz = 0
  xmin = 0
  xmax = 1000
  ymin = 0
  ymax = 1000
  zmin = 0
  zmax = 0
  elem_type = QUAD4
  uniform_refine = 2
[]

[GlobalParams]
  crys_num = 2
  var_name_base = gr
  implicit = false
[]

[Variables]
  [./PolycrystalVariables]
  [../]
[]

[ICs]
  [./PolycrystalICs]
    [./BicrystalCircleGrainIC]
      radius = 333.333
      x = 500
      y = 500
    [../]
  [../]
[]

[AuxVariables]
  [./bnds]
    order = FIRST
    family = LAGRANGE
  [../]
[]

[Kernels]
  [./PolycrystalKernel]
  [../]
[]

[AuxKernels]
  [./BndsCalc]
    type = BndsCalcAux
    variable = bnds
    execute_on = timestep
  [../]
[]

[Materials]
  [./Copper]
    type = GBEvolution
    block = 0
    temp = 500 # K
    wGB = 60 # nm
    GBmob0 = 2.5e-6 #m^4/(Js) from Schoenfelder 1997
    Q = 0.23 #Migration energy in eV
    GBenergy = 0.708 #GB energy in J/m^2
  [../]
[]

[Postprocessors]
  [./gr1area]
    type = ElementIntegralVariablePostprocessor
    variable = gr1
  [../]
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  #l_max_its = 3
  petsc_options_iname = -pc_type
  petsc_options_value = bjacobi
  type = Transient
  scheme = explicit-euler
  solve_type = NEWTON
  l_tol = 1.0e-6
  nl_rel_tol = 1.0e-6
  num_steps = 61
  dt = 0.08
[]

[Output]
  file_base = explicit
  output_initial = true
  postprocessor_csv = true
  interval = 20
  exodus = true
  perf_log = true
[]

