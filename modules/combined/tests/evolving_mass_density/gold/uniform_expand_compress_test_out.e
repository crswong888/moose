CDF      
   0   
len_string     !   len_line   Q   four      	time_step          len_name   !   num_dim       	num_nodes         num_elem      
num_el_blk        num_node_sets         num_side_sets         num_el_in_blk1        num_nod_per_el1       num_el_in_blk2        num_nod_per_el2       num_el_in_blk3        num_nod_per_el3       num_el_in_blk4        num_nod_per_el4       num_el_in_blk5        num_nod_per_el5       num_el_in_blk6        num_nod_per_el6       num_el_in_blk7        num_nod_per_el7       num_side_ss1      num_side_ss2      num_side_ss3      num_side_ss4      num_side_ss5      num_side_ss6      num_nod_ns1       num_nod_ns2       num_nod_ns3       num_nod_ns4       num_nod_ns5       num_nod_ns6       num_nod_ns7       num_nod_ns8       num_nod_ns9       num_nod_ns10      num_nod_ns11      num_nod_ns12      num_nod_ns13      num_nod_ns14      num_nod_var       num_info  �   num_glo_var             api_version       @��H   version       @��H   floating_point_word_size            	file_size               title         #uniform_expand_compress_test_out.e     maximum_name_length                 7   
time_whole                            ��   	eb_status                                eb_prop1               name      ID                  	ns_status         	              8      <   ns_prop1      	         name      ID        8      t   	ss_status         
                    �   ss_prop1      
         name      ID              �   coordx                      �      �   coordy                      �      \   coordz                      �      �   eb_names                       �      \   ns_names      	                �      D   ss_names      
                 �         
coor_names                         d      �   connect1                  	elem_type         HEX8                 @   elem_num_map                          `   connect2                  	elem_type         HEX8                 |   connect3                  	elem_type         HEX8                 �   connect4                  	elem_type         HEX8                 �   connect5                  	elem_type         HEX8                 �   connect6                  	elem_type         HEX8                 �   connect7                  	elem_type         HEX8                    elem_ss1                          <   side_ss1                          @   elem_ss2                          D   side_ss2                          H   elem_ss3                          L   side_ss3                          P   elem_ss4                          T   side_ss4                          X   elem_ss5                          \   side_ss5                          `   elem_ss6                          d   side_ss6                          h   node_ns1                          l   node_ns2                           p   node_ns3      !                    �   node_ns4      "                    �   node_ns5      #                    �   node_ns6      $                    �   node_ns7      %                    �   node_ns8      &                    �   node_ns9      '                    �   	node_ns10         (                    �   	node_ns11         )                    �   	node_ns12         *                    �   	node_ns13         +                    �   	node_ns14         ,                    �   vals_nod_var1                          �      ��   vals_nod_var2                          �      �H   vals_nod_var3                          �      ��   name_nod_var      -                 d      �   info_records      .                }L      P   name_glo_var      /                 $      ��   vals_glo_var         /                    �H                                                                                             	         
                                                	   
         ?�      ?���l�D?�z�G�{        ?�      ?�7KƧ�?��Q�        ?�              ?�n��O�;?��;dZ�?�x���F        ?�333333?�              ?Ӆ�Q�?����+        ?�      ?�-V�?��
=p��?�                      ?�n��O�;?��S���?�      ?�      ?�ě��S�?�      ?�      ?��"��`B?�t�j~�?�      ?�      ?䛥�S��?�vȴ9X?�                      ?�n��O�;?ȓt�j~�?�p��
=q        ?����E�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  	   
                        
                                             	                                             	   
                                                                           	   
         	               
                        	   	   
         
      disp_x                           disp_y                           disp_z                            ####################                                                             # Created by MOOSE #                                                             ####################                                                             ### Command Line Arguments ###                                                   -i                                                                               uniform_expand_compress_test.i                                                                                                                                    ### Input File ###                                                                                                                                                [BCs]                                                                                                                                                               [./10_y]                                                                           type                         = DirichletBC                                       boundary                     = 10                                                time_periods                 =                                                   value                        = 0                                                 variable                     = disp_x                                          [../]                                                                                                                                                             [./14_y]                                                                           type                         = DirichletBC                                       boundary                     = 14                                                time_periods                 =                                                   value                        = 0                                                 variable                     = disp_z                                          [../]                                                                                                                                                             [./9_y]                                                                            type                         = DirichletBC                                       boundary                     = 9                                                 time_periods                 =                                                   value                        = 0                                                 variable                     = disp_y                                          [../]                                                                                                                                                             [./front]                                                                          type                         = FunctionDirichletBC                               boundary                     = 13                                                function                     = rampConstant2                                     time_periods                 =                                                   variable                     = disp_z                                          [../]                                                                                                                                                             [./side]                                                                           type                         = FunctionDirichletBC                               boundary                     = 12                                                function                     = rampConstant2                                     time_periods                 =                                                   variable                     = disp_x                                          [../]                                                                                                                                                             [./top]                                                                            type                         = FunctionDirichletBC                               boundary                     = 11                                                function                     = rampConstant2                                     time_periods                 =                                                   variable                     = disp_y                                          [../]                                                                          []                                                                                                                                                                [Executioner]                                                                      l_abs_step_tol                 = -1                                              l_max_its                      = 20                                              l_tol                          = 1e-05                                           nl_abs_step_tol                = 1e-50                                           nl_abs_tol                     = 1e-10                                           nl_max_funcs                   = 10000                                           nl_max_its                     = 50                                              nl_rel_step_tol                = 1e-50                                           nl_rel_tol                     = 1e-08                                           no_fe_reinit                   = 0                                               petsc_options                  = '-snes_mf_operator -ksp_monitor'                petsc_options_iname            =                                                 petsc_options_value            =                                                 scheme                         = backward-euler                                  type                           = Transient                                       _mesh                          = 0x101f67830                                     dt                             = 1                                               dtmax                          = 1e+30                                           dtmin                          = 0                                               end_time                       = 3                                               growth_factor                  = 2                                               n_startup_steps                = 0                                               num_steps                      = 3                                               predictor_scale                = 0                                               restart_file_base              =                                                 ss_check_tol                   = 1e-08                                           ss_tmin                        = 0                                               start_time                     = 0                                               sync_times                     = -1                                              time_dt                        =                                                 time_period_ends               =                                                 time_period_starts             =                                                 time_periods                   =                                                 time_t                         =                                                 trans_ss_check                 = 0                                             []                                                                                                                                                                [Functions]                                                                                                                                                         [./rampConstant2]                                                                  type                         = PiecewiseLinear                                   axis                         = 9                                                 scale_factor                 = 1                                                 x                            = '0 1 2 3'                                         y                            = '0 0.25 0 -0.25'                                [../]                                                                          []                                                                                                                                                                [Materials]                                                                                                                                                         [./density]                                                                        type                         = Density                                           block                        = '1 2 3 4 5 6 7'                                   density                      = 1                                                 disp_r                       =                                                   disp_x                       = disp_x                                            disp_y                       = disp_y                                            disp_z                       = disp_z                                          [../]                                                                                                                                                             [./stiffStuff1]                                                                    type                         = Elastic                                           active_crack_planes          =                                                   appended_property_name       =                                                   block                        = 1                                                 bulk_modulus                 = 4.44659e-323                                      cracking_release             = abrupt                                            cracking_stress              = 0                                                 disp_r                       =                                                   disp_x                       = disp_x                                            disp_y                       = disp_y                                            disp_z                       = disp_z                                            formulation                  =                                                   increment_calculation        = RashidApprox                                      lambda                       = 4.44659e-323                                      large_strain                 = 0                                                 max_cracks                   = 3                                                 poissons_ratio               = 0                                                 shear_modulus                = 4.44659e-323                                      temp                         =                                                   thermal_expansion            = 0                                                 youngs_modulus               = 1e+06                                           [../]                                                                                                                                                             [./stiffStuff2]                                                                    type                         = Elastic                                           active_crack_planes          =                                                   appended_property_name       =                                                   block                        = 2                                                 bulk_modulus                 = 4.44659e-323                                      cracking_release             = abrupt                                            cracking_stress              = 0                                                 disp_r                       =                                                   disp_x                       = disp_x                                            disp_y                       = disp_y                                            disp_z                       = disp_z                                            formulation                  =                                                   increment_calculation        = RashidApprox                                      lambda                       = 4.44659e-323                                      large_strain                 = 0                                                 max_cracks                   = 3                                                 poissons_ratio               = 0                                                 shear_modulus                = 4.44659e-323                                      temp                         =                                                   thermal_expansion            = 0                                                 youngs_modulus               = 1e+06                                           [../]                                                                                                                                                             [./stiffStuff3]                                                                    type                         = Elastic                                           active_crack_planes          =                                                   appended_property_name       =                                                   block                        = 3                                                 bulk_modulus                 = 4.44659e-323                                      cracking_release             = abrupt                                            cracking_stress              = 0                                                 disp_r                       =                                                   disp_x                       = disp_x                                            disp_y                       = disp_y                                            disp_z                       = disp_z                                            formulation                  =                                                   increment_calculation        = RashidApprox                                      lambda                       = 4.44659e-323                                      large_strain                 = 0                                                 max_cracks                   = 3                                                 poissons_ratio               = 0                                                 shear_modulus                = 4.44659e-323                                      temp                         =                                                   thermal_expansion            = 0                                                 youngs_modulus               = 1e+06                                           [../]                                                                                                                                                             [./stiffStuff4]                                                                    type                         = Elastic                                           active_crack_planes          =                                                   appended_property_name       =                                                   block                        = 4                                                 bulk_modulus                 = 4.44659e-323                                      cracking_release             = abrupt                                            cracking_stress              = 0                                                 disp_r                       =                                                   disp_x                       = disp_x                                            disp_y                       = disp_y                                            disp_z                       = disp_z                                            formulation                  =                                                   increment_calculation        = RashidApprox                                      lambda                       = 4.44659e-323                                      large_strain                 = 0                                                 max_cracks                   = 3                                                 poissons_ratio               = 0                                                 shear_modulus                = 4.44659e-323                                      temp                         =                                                   thermal_expansion            = 0                                                 youngs_modulus               = 1e+06                                           [../]                                                                                                                                                             [./stiffStuff5]                                                                    type                         = Elastic                                           active_crack_planes          =                                                   appended_property_name       =                                                   block                        = 5                                                 bulk_modulus                 = 4.44659e-323                                      cracking_release             = abrupt                                            cracking_stress              = 0                                                 disp_r                       =                                                   disp_x                       = disp_x                                            disp_y                       = disp_y                                            disp_z                       = disp_z                                            formulation                  =                                                   increment_calculation        = RashidApprox                                      lambda                       = 4.44659e-323                                      large_strain                 = 0                                                 max_cracks                   = 3                                                 poissons_ratio               = 0                                                 shear_modulus                = 4.44659e-323                                      temp                         =                                                   thermal_expansion            = 0                                                 youngs_modulus               = 1e+06                                           [../]                                                                                                                                                             [./stiffStuff6]                                                                    type                         = Elastic                                           active_crack_planes          =                                                   appended_property_name       =                                                   block                        = 6                                                 bulk_modulus                 = 4.44659e-323                                      cracking_release             = abrupt                                            cracking_stress              = 0                                                 disp_r                       =                                                   disp_x                       = disp_x                                            disp_y                       = disp_y                                            disp_z                       = disp_z                                            formulation                  =                                                   increment_calculation        = RashidApprox                                      lambda                       = 4.44659e-323                                      large_strain                 = 0                                                 max_cracks                   = 3                                                 poissons_ratio               = 0                                                 shear_modulus                = 4.44659e-323                                      temp                         =                                                   thermal_expansion            = 0                                                 youngs_modulus               = 1e+06                                           [../]                                                                                                                                                             [./stiffStuff7]                                                                    type                         = Elastic                                           active_crack_planes          =                                                   appended_property_name       =                                                   block                        = 7                                                 bulk_modulus                 = 4.44659e-323                                      cracking_release             = abrupt                                            cracking_stress              = 0                                                 disp_r                       =                                                   disp_x                       = disp_x                                            disp_y                       = disp_y                                            disp_z                       = disp_z                                            formulation                  =                                                   increment_calculation        = RashidApprox                                      lambda                       = 4.44659e-323                                      large_strain                 = 0                                                 max_cracks                   = 3                                                 poissons_ratio               = 0                                                 shear_modulus                = 4.44659e-323                                      temp                         =                                                   thermal_expansion            = 0                                                 youngs_modulus               = 1e+06                                           [../]                                                                          []                                                                                                                                                                [Mesh]                                                                             displacements                  = 'disp_x disp_y disp_z'                          uniform_refine                 = 0                                               displacements                  = 'disp_x disp_y disp_z'                          file                           = elastic_patch.e                                 ghosted_boundaries             =                                                 ghosted_boundaries_inflation   =                                                 nemesis                        = 0                                               patch_size                     = 40                                              skip_partitioning              = 0                                               type                           = MooseMesh                                       block_id                       =                                                 block_name                     =                                                 boundary_id                    =                                                 boundary_name                  =                                                 centroid_partitioner_direction =                                                 construct_side_list_from_node_list = 0                                           partitioner                    =                                                 second_order                   = 0                                               _dimension                     = 1                                             []                                                                                                                                                                [Output]                                                                           elemental_as_nodal             = 1                                               exodus                         = 1                                               exodus_inputfile_output        = 1                                               file_base                      = uniform_expand_compress_test_out                gmv                            = 0                                               gnuplot_format                 = ps                                              interval                       = 1                                               iteration_plot_start_time      = 1.79769e+308                                    max_pps_rows_screen            = 0                                               nemesis                        = 0                                               num_restart_files              = 0                                               output_displaced               = 0                                               output_initial                 = 1                                               output_solution_history        = 0                                               output_variables               =                                                 perf_log                       = 1                                               postprocessor_csv              = 0                                               postprocessor_gnuplot          = 0                                               postprocessor_screen           = 1                                               print_linear_residuals         = 0                                               screen_interval                = 1                                               show_setup_log_early           = 0                                               tecplot                        = 0                                               tecplot_binary                 = 0                                               xda                            = 0                                             []                                                                                                                                                                [Postprocessors]                                                                                                                                                    [./Mass]                                                                           type                         = Mass                                              block                        = ANY_BLOCK_ID                                      execute_on                   = timestep                                          output                       = both                                              variable                     = disp_x                                          [../]                                                                          []                                                                                                                                                                [SolidMechanics]                                                                                                                                                    [./solid]                                                                          appended_property_name       =                                                   disp_r                       =                                                   disp_x                       = disp_x                                            disp_y                       = disp_y                                            disp_z                       = disp_z                                            temp                         =                                                   use_displaced_mesh           = 1                                               [../]                                                                          []                                                                                                                                                                [Variables]                                                                                                                                                         [./disp_x]                                                                         block                        =                                                   family                       = LAGRANGE                                          initial_condition            = 0                                                 order                        = FIRST                                             scaling                      = 1                                                 initial_from_file_timestep   = 2                                                 initial_from_file_var        =                                                 [../]                                                                                                                                                             [./disp_y]                                                                         block                        =                                                   family                       = LAGRANGE                                          initial_condition            = 0                                                 order                        = FIRST                                             scaling                      = 1                                                 initial_from_file_timestep   = 2                                                 initial_from_file_var        =                                                 [../]                                                                                                                                                             [./disp_z]                                                                         block                        =                                                   family                       = LAGRANGE                                          initial_condition            = 0                                                 order                        = FIRST                                             scaling                      = 1                                                 initial_from_file_timestep   = 2                                                 initial_from_file_var        =                                                 [../]                                                                          []                                                                               Mass                                                                                                                                                                                                                                                                                                                                                                                                                                        ?�     ?�      ?�     3?ũ��l��?�z�G��        ?�     3?�7KƧ��?��Q�3        ?�     3        ?�n��Oߏ?��;dZ/?�x���n        ?�33333�?�     3        ?���Q��?����+2        ?�     3?�-V�?��
=p�"?�     3                ?�n��O�k?��S���d?�     X?�     3?�ě��T0?�     3?�     3?��"��`q?ēt�j@?�     3?�     3?ě��S�?�vȴ9XY?�     3                ?�n��Oߐ?��t�j^?�p��
=�        ?����E�        ?�      @       =��F�� =-w�R@ <��"zw�         =��F�� ==z0� <�@�;g          =��F��         =W��!@ <��r��� <�PZ��         =tN�� =��F��         <�7A�q  <�~=���         =��F�� =8C��  =t��� =��F��                 <�t�al@ = *�� =g�:�� =��F�� =JJ�  =��F�� =��F�� =ю��� =�=�� =��F�� =��F�� = �  =�D�  =��F��                 <��5�  <�� ��  <�'�W�          <�-�sA�         ?�     @      ���������ũ��l���z�G�=        ����������7KƧ�m���Q��        ��������        ��n��O�����;dZ@��x���!        ��33332���������        ����Q�W�����*�        ����������-V[���
=p����������                ��n��O� ���S���ٿ������ʿ���������ě��S̿������������������"��`�ēt�j~Կ����������������ě��S����vȴ9Wݿ�������                ��n��O� ���t�j~���p��
=@        �����E~        ?�      