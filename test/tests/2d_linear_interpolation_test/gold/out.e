CDF      
      
len_string     !   len_line   Q   four      	time_step          len_name   !   num_dim       	num_nodes         num_elem      
num_el_blk        num_node_sets         num_side_sets         num_el_in_blk1        num_nod_per_el1       num_side_ss1      num_nod_ns1       num_nod_var       num_info  ░         api_version       @всH   version       @всH   floating_point_word_size            	file_size               title         out.e      maximum_name_length                    
time_whole                            ТД   	eb_status                             4   eb_prop1               name      ID              8   	ns_status         	                    <   ns_prop1      	         name      ID              @   	ss_status         
                    D   ss_prop1      
         name      ID              H   coordx                      @      L   coordy                      @      М   coordz                      @      ╠   eb_names                       $         ns_names      	                 $      0   ss_names      
                 $      T   
coor_names                         d      x   connect1                  	elem_type         HEX8                 ▄   elem_num_map                          №   elem_ss1                          	    side_ss1                          	   node_ns1                           	0   vals_nod_var1                          @      ТМ   vals_nod_var2                          @      Т╠   vals_nod_var3                          @      У   vals_nod_var4                          @      УL   name_nod_var                       Д      	P   info_records                      И░      	╘                  ?Ё      ?Ё      ?Ё      ?Ё      @       @       @       @       ?Ё      ?Ё      @       @       ?Ё      ?Ё      @       @       @       ?Ё      ?Ё      @       @       ?Ё      ?Ё      @                                                                                                                                                                                                                                                                                                              u                                v                                w                                A                                ####################                                                             # Created by MOOSE #                                                             ####################                                                             ### Command Line Arguments ###                                                   -i                                                                               2d_linear_interpolation_test.i                                                                                                                                    ### Input File ###                                                                                                                                                                                                                                 [Mesh]                                                                             action                         = initial_mesh_refinement                         name                           = Mesh                                            parser_handle                  = 0x7fff5fbfe980                                  uniform_refine                 = 0                                               unique_id                      = 35                                              construct_side_list_from_node_list = 0                                           second_order                   = 0                                               file                           = cube.e                                          nemesis                        = 0                                               patch_size                     = 40                                              skip_partitioning              = 0                                             []                                                                                                                                                                [Functions]                                                                        [./u]                                                                              action                       = add_function                                      isMooseObjectAction          = 1                                                 name                         = Functions/u                                       parser_handle                = 0x7fff5fbfe980                                    type                         = PiecewiseBilinear                                 unique_id                    = 4                                                 axis                         = 0                                                 built_by_action              = add_function                                      scale_factor                 = 1                                                 xaxis                        = -1                                                yaxis                        = -1                                                yourFileName                 = fred.csv                                        [../]                                                                                                                                                             [./v]                                                                              action                       = add_function                                      isMooseObjectAction          = 1                                                 name                         = Functions/v                                       parser_handle                = 0x7fff5fbfe980                                    type                         = PiecewiseBilinear                                 unique_id                    = 4                                                 axis                         = -1                                                built_by_action              = add_function                                      scale_factor                 = 1                                                 xaxis                        = 1                                                 yaxis                        = -1                                                yourFileName                 = fred.csv                                        [../]                                                                                                                                                             [./w]                                                                              action                       = add_function                                      isMooseObjectAction          = 1                                                 name                         = Functions/w                                       parser_handle                = 0x7fff5fbfe980                                    type                         = PiecewiseBilinear                                 unique_id                    = 4                                                 axis                         = -1                                                built_by_action              = add_function                                      scale_factor                 = 1                                                 xaxis                        = -1                                                yaxis                        = 2                                                 yourFileName                 = fred.csv                                        [../]                                                                                                                                                             [./A]                                                                              action                       = add_function                                      isMooseObjectAction          = 1                                                 name                         = Functions/A                                       parser_handle                = 0x7fff5fbfe980                                    type                         = PiecewiseBilinear                                 unique_id                    = 4                                                 axis                         = -1                                                built_by_action              = add_function                                      scale_factor                 = 1                                                 xaxis                        = 0                                                 yaxis                        = 1                                                 yourFileName                 = fred.csv                                        [../]                                                                                                                                                           [Functions]                                                                        action                         = no_action                                       name                           = Functions                                       parser_handle                  = 0x7fff5fbfe980                                  unique_id                      = 20                                            []                                                                                                                                                                [Variables]                                                                        action                         = no_action                                       name                           = Variables                                       parser_handle                  = 0x7fff5fbfe980                                  unique_id                      = 20                                                                                                                               [./A]                                                                              action                       = copy_nodal_vars                                   initial_from_file_timestep   = 2                                                 name                         = Variables/A                                       parser_handle                = 0x7fff5fbfe980                                    unique_id                    = 12                                              [../]                                                                                                                                                             [./w]                                                                              action                       = copy_nodal_vars                                   initial_from_file_timestep   = 2                                                 name                         = Variables/w                                       parser_handle                = 0x7fff5fbfe980                                    unique_id                    = 12                                              [../]                                                                                                                                                             [./v]                                                                              action                       = copy_nodal_vars                                   initial_from_file_timestep   = 2                                                 name                         = Variables/v                                       parser_handle                = 0x7fff5fbfe980                                    unique_id                    = 12                                              [../]                                                                                                                                                             [./u]                                                                              action                       = copy_nodal_vars                                   initial_from_file_timestep   = 2                                                 name                         = Variables/u                                       parser_handle                = 0x7fff5fbfe980                                    unique_id                    = 12                                              [../]                                                                                                                                                             [./A]                                                                              action                       = add_variable                                      family                       = LAGRANGE                                          initial_condition            = 0                                                 name                         = Variables/A                                       order                        = FIRST                                             parser_handle                = 0x7fff5fbfe980                                    scaling                      = 1                                                 unique_id                    = 11                                              [../]                                                                                                                                                             [./w]                                                                              action                       = add_variable                                      family                       = LAGRANGE                                          initial_condition            = 0                                                 name                         = Variables/w                                       order                        = FIRST                                             parser_handle                = 0x7fff5fbfe980                                    scaling                      = 1                                                 unique_id                    = 11                                              [../]                                                                                                                                                             [./v]                                                                              action                       = add_variable                                      family                       = LAGRANGE                                          initial_condition            = 0                                                 name                         = Variables/v                                       order                        = FIRST                                             parser_handle                = 0x7fff5fbfe980                                    scaling                      = 1                                                 unique_id                    = 11                                              [../]                                                                                                                                                             [./u]                                                                              action                       = add_variable                                      family                       = LAGRANGE                                          initial_condition            = 0                                                 name                         = Variables/u                                       order                        = FIRST                                             parser_handle                = 0x7fff5fbfe980                                    scaling                      = 1                                                 unique_id                    = 11                                              [../]                                                                          []                                                                                                                                                                [Kernels]                                                                          [./diffA]                                                                          action                       = add_kernel                                        isMooseObjectAction          = 1                                                 name                         = Kernels/diffA                                     parser_handle                = 0x7fff5fbfe980                                    type                         = Diffusion                                         unique_id                    = 16                                                built_by_action              = add_kernel                                        execute_on                   = residual                                          start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      use_displaced_mesh           = 0                                                 variable                     = A                                               [../]                                                                                                                                                             [./diffw]                                                                          action                       = add_kernel                                        isMooseObjectAction          = 1                                                 name                         = Kernels/diffw                                     parser_handle                = 0x7fff5fbfe980                                    type                         = Diffusion                                         unique_id                    = 16                                                built_by_action              = add_kernel                                        execute_on                   = residual                                          start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      use_displaced_mesh           = 0                                                 variable                     = w                                               [../]                                                                                                                                                             [./diffv]                                                                          action                       = add_kernel                                        isMooseObjectAction          = 1                                                 name                         = Kernels/diffv                                     parser_handle                = 0x7fff5fbfe980                                    type                         = Diffusion                                         unique_id                    = 16                                                built_by_action              = add_kernel                                        execute_on                   = residual                                          start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      use_displaced_mesh           = 0                                                 variable                     = v                                               [../]                                                                                                                                                             [./diffu]                                                                          action                       = add_kernel                                        isMooseObjectAction          = 1                                                 name                         = Kernels/diffu                                     parser_handle                = 0x7fff5fbfe980                                    type                         = Diffusion                                         unique_id                    = 16                                                built_by_action              = add_kernel                                        execute_on                   = residual                                          start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      use_displaced_mesh           = 0                                                 variable                     = u                                               [../]                                                                                                                                                           [Kernels]                                                                          action                         = no_action                                       name                           = Kernels                                         parser_handle                  = 0x7fff5fbfe980                                  unique_id                      = 20                                            []                                                                                                                                                                [BCs]                                                                              action                         = no_action                                       name                           = BCs                                             parser_handle                  = 0x7fff5fbfe980                                  unique_id                      = 20                                                                                                                               [./A]                                                                              action                       = add_bc                                            isMooseObjectAction          = 1                                                 name                         = BCs/A                                             parser_handle                = 0x7fff5fbfe980                                    type                         = FunctionDirichletBC                               unique_id                    = 19                                                boundary                     = 1                                                 built_by_action              = add_bc                                            execute_on                   = residual                                          function                     = A                                                 use_displaced_mesh           = 0                                                 variable                     = A                                               [../]                                                                                                                                                             [./w]                                                                              action                       = add_bc                                            isMooseObjectAction          = 1                                                 name                         = BCs/w                                             parser_handle                = 0x7fff5fbfe980                                    type                         = FunctionDirichletBC                               unique_id                    = 19                                                boundary                     = 1                                                 built_by_action              = add_bc                                            execute_on                   = residual                                          function                     = w                                                 use_displaced_mesh           = 0                                                 variable                     = w                                               [../]                                                                                                                                                             [./v]                                                                              action                       = add_bc                                            isMooseObjectAction          = 1                                                 name                         = BCs/v                                             parser_handle                = 0x7fff5fbfe980                                    type                         = FunctionDirichletBC                               unique_id                    = 19                                                boundary                     = 1                                                 built_by_action              = add_bc                                            execute_on                   = residual                                          function                     = v                                                 use_displaced_mesh           = 0                                                 variable                     = v                                               [../]                                                                                                                                                             [./u]                                                                              action                       = add_bc                                            isMooseObjectAction          = 1                                                 name                         = BCs/u                                             parser_handle                = 0x7fff5fbfe980                                    type                         = FunctionDirichletBC                               unique_id                    = 19                                                boundary                     = 1                                                 built_by_action              = add_bc                                            execute_on                   = residual                                          function                     = u                                                 use_displaced_mesh           = 0                                                 variable                     = u                                               [../]                                                                          []                                                                                                                                                                [Executioner]                                                                      action                         = setup_executioner                               isMooseObjectAction            = 1                                               l_abs_step_tol                 = -1                                              l_max_its                      = 10000                                           l_tol                          = 1e-05                                           name                           = Executioner                                     nl_abs_step_tol                = 1e-50                                           nl_abs_tol                     = 1e-50                                           nl_max_funcs                   = 10000                                           nl_max_its                     = 50                                              nl_rel_step_tol                = 1e-50                                           nl_rel_tol                     = 1e-12                                           no_fe_reinit                   = 0                                               parser_handle                  = 0x7fff5fbfe980                                  scheme                         = backward-euler                                  type                           = Transient                                       unique_id                      = 5                                               _mesh                          = 0x101b3c1b0                                     built_by_action                = setup_executioner                               dt                             = 1                                               dtmax                          = 1e+30                                           dtmin                          = 0                                               end_time                       = 2                                               growth_factor                  = 2                                               n_startup_steps                = 0                                               num_steps                      = 1.79769e+308                                    predictor_scale                = 0                                               ss_check_tol                   = 1e-08                                           ss_tmin                        = 0                                               start_time                     = 0                                               sync_times                     = -1                                              trans_ss_check                 = 0                                             []                                                                                                                                                                [Output]                                                                           action                         = setup_output                                    elemental_as_nodal             = 0                                               exodus                         = 1                                               exodus_inputfile_output        = 1                                               file_base                      = out                                             gmv                            = 0                                               gnuplot_format                 = ps                                              interval                       = 1                                               iteration_plot_start_time      = 1.79769e+308                                    max_pps_rows_screen            = 0                                               name                           = Output                                          nemesis                        = 0                                               output_displaced               = 0                                               output_initial                 = 1                                               parser_handle                  = 0x7fff5fbfe980                                  perf_log                       = 1                                               postprocessor_csv              = 0                                               postprocessor_ensight          = 0                                               postprocessor_gnuplot          = 0                                               postprocessor_screen           = 1                                               print_linear_residuals         = 0                                               screen_interval                = 1                                               show_setup_log_early           = 0                                               tecplot                        = 0                                               tecplot_binary                 = 0                                               unique_id                      = 8                                               xda                            = 0                                             []                                                                                                                                                                [init_problem]                                                                     action                         = init_problem                                    name                           = init_problem                                    parser_handle                  = 0x7fff5fbfe980                                  unique_id                      = 41                                            []                                                                                                                                                                [copy_nodal_vars]                                                                  action                         = copy_nodal_vars                                 initial_from_file_timestep     = 2                                               name                           = copy_nodal_vars                                 parser_handle                  = 0x7fff5fbfe980                                  unique_id                      = 12                                            []                                                                                                                                                                [check_integrity]                                                                  action                         = check_integrity                                 name                           = check_integrity                                 parser_handle                  = 0x7fff5fbfe980                                  unique_id                      = 42                                            []                                                                                                                                                                [no_action]                                                                        action                         = no_action                                       name                           = no_action                                       parser_handle                  = 0x7fff5fbfe980                                  unique_id                      = 20                                            []                                                                                                                                                                [setup_dampers]                                                                    action                         = setup_dampers                                   name                           = setup_dampers                                   parser_handle                  = 0x7fff5fbfe980                                  unique_id                      = 39                                            []                                                                                                                                                                [setup_quadrature]                                                                 action                         = setup_quadrature                                name                           = setup_quadrature                                order                          = AUTO                                            parser_handle                  = 0x7fff5fbfe980                                  type                           = GAUSS                                           unique_id                      = 30                                            []                                                                                                                                                                [setup_subproblem]                                                                 action                         = setup_subproblem                                coord_type                     = XYZ                                             name                           = setup_subproblem                                parser_handle                  = 0x7fff5fbfe980                                  unique_id                      = 7                                             []                                                                                                                                                                [no_action]                                                                        action                         = no_action                                       name                           = no_action                                       unique_id                      = 20                                                                                                                                                                                                                                                                                                                    ?Ё      ?Ё      ?Ё      ?Ё      ?Ё      @       @       @       @       ?Ё      ?Ё      @       @       ?Ё      ?Ё      @       @       @      ?Ё      ?Ё      @      @      ?Ё      ?Ё      @      ?Ё      ?Ё      @      @      @       @       @      @      @       @      @      @      @      @      @      @      @      @      @      @      @      @      @      @      @      @      ?       ?       @      @      ?       ?       @      ?Ё      ?Ё      @      @      @       @       @      @      