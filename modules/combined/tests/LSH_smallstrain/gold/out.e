CDF      
      
len_string     !   len_line   Q   four      	time_step          num_dim       	num_nodes         num_elem      
num_el_blk        num_node_sets         num_side_sets         num_el_in_blk1        num_nod_per_el1       num_side_ss1      
num_df_ss1        num_side_ss2      
num_df_ss2        num_side_ss3      
num_df_ss3        num_side_ss4      
num_df_ss4        num_nod_ns1       num_nod_ns2       num_nod_ns3       num_nod_ns4       num_nod_var       num_elem_var      num_info           api_version       @��R   version       @��R   floating_point_word_size            	file_size               title         out.e         .   
time_whole                            g    	eb_status                                eb_prop1               name      ID                 	ns_status                                ns_prop1               name      ID                  	ss_status         	                    0   ss_prop1      	         name      ID              @   coordx                      @      P   coordy                      @      �   coordz                      @      �   
coor_names                          d         eb_names                        $      t   ns_names                        �      �   ss_names      	                  �         connect1      
            	elem_type         HEX8                 �   elem_num_map                          �   elem_ss1                          �   side_ss1                          �   dist_fact_ss1                              �   elem_ss2                          �   side_ss2                          �   dist_fact_ss2                              �   elem_ss3                             side_ss3                             dist_fact_ss3                                 elem_ss4                          <   side_ss4                          @   dist_fact_ss4                              D   node_ns1                          d   node_ns2                          t   node_ns3                          �   node_ns4                          �   vals_nod_var1                          @      g(   vals_nod_var2                          @      gh   vals_nod_var3                          @      g�   vals_nod_var4                          @      g�   vals_nod_var5                          @      h(   vals_nod_var6                          @      hh   vals_nod_var7                          @      h�   name_nod_var                        �      �   name_elem_var                           �      �   vals_elem_var1eb1            
                    h�   vals_elem_var2eb1            
                    h�   vals_elem_var3eb1            
                    h�   vals_elem_var4eb1            
                    i    info_records                      V                                                            ��      ��      ��      ��      ?�      ?�      ?�      ?�      ��      ��      ?�      ?�      ��      ��      ?�      ?�      ?�      ��      ��      ?�      ?�      ��      ��      ?�                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         stress_yy                        plastic_strain_xx                plastic_strain_yy                plastic_strain_zz                disp_x                           disp_y                           disp_z                            stress_yy                        plastic_strain_xx                plastic_strain_yy                plastic_strain_zz                ####################                                                             # Created by MOOSE #                                                             ####################                                                                                                                                              [Mesh]                                                                             dim                            = 3                                               file                           = 1x1x1cube.e                                     second_order                   = 0                                               uniform_refine                 = 0                                             []                                                                                                                                                                [Variables]                                                                        active                         = 'disp_x disp_y disp_z '                                                                                                          [./disp_x]                                                                         family                       = LAGRANGE                                          initial_condition            = 0                                                 initial_from_file_timestep   = 2                                                 order                        = FIRST                                             scaling                      = 1                                               [../]                                                                                                                                                             [./disp_y]                                                                         family                       = LAGRANGE                                          initial_condition            = 0                                                 initial_from_file_timestep   = 2                                                 order                        = FIRST                                             scaling                      = 1                                               [../]                                                                                                                                                             [./disp_z]                                                                         family                       = LAGRANGE                                          initial_condition            = 0                                                 initial_from_file_timestep   = 2                                                 order                        = FIRST                                             scaling                      = 1                                               [../]                                                                          []                                                                                                                                                                [Preconditioning]                                                                []                                                                                                                                                                [AuxVariables]                                                                                                                                                      [./stress_yy]                                                                      family                       = MONOMIAL                                          initial_condition            = 0                                                 initial_from_file_timestep   = 2                                                 order                        = CONSTANT                                          scaling                      = 1                                               [../]                                                                                                                                                             [./plastic_strain_xx]                                                              family                       = MONOMIAL                                          initial_condition            = 0                                                 initial_from_file_timestep   = 2                                                 order                        = CONSTANT                                          scaling                      = 1                                               [../]                                                                                                                                                             [./plastic_strain_yy]                                                              family                       = MONOMIAL                                          initial_condition            = 0                                                 initial_from_file_timestep   = 2                                                 order                        = CONSTANT                                          scaling                      = 1                                               [../]                                                                                                                                                             [./plastic_strain_zz]                                                              family                       = MONOMIAL                                          initial_condition            = 0                                                 initial_from_file_timestep   = 2                                                 order                        = CONSTANT                                          scaling                      = 1                                               [../]                                                                          []                                                                                                                                                                [Functions]                                                                        active                         = 'top_pull '                                                                                                                      [./top_pull]                                                                       type                         = ParsedFunction                                    vals                         =                                                   value                        = t*(1.0/5.0)                                       vars                         =                                                 [../]                                                                          []                                                                                                                                                                [Kernels]                                                                          active                         = 'solid_x solid_y solid_z '                                                                                                       [./solid_x]                                                                        type                         = StressDivergence                                  component                    = 0                                                 start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      variable                     = disp_x                                          [../]                                                                                                                                                             [./solid_y]                                                                        type                         = StressDivergence                                  component                    = 1                                                 start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      variable                     = disp_y                                          [../]                                                                                                                                                             [./solid_z]                                                                        type                         = StressDivergence                                  component                    = 2                                                 start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      variable                     = disp_z                                          [../]                                                                          []                                                                                                                                                                [AuxKernels]                                                                                                                                                        [./stress_yy]                                                                      type                         = StressAux                                         index                        = 1                                                 start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      variable                     = stress_yy                                       [../]                                                                                                                                                             [./plastic_strain_xx]                                                              type                         = PlasticStrainAux                                  index                        = 0                                                 start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      variable                     = plastic_strain_xx                               [../]                                                                                                                                                             [./plastic_strain_yy]                                                              type                         = PlasticStrainAux                                  index                        = 1                                                 start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      variable                     = plastic_strain_yy                               [../]                                                                                                                                                             [./plastic_strain_zz]                                                              type                         = PlasticStrainAux                                  index                        = 2                                                 start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      variable                     = plastic_strain_zz                               [../]                                                                          []                                                                                                                                                                [BCs]                                                                              active                         = 'y_pull_function y_bot x_bot z_bot '                                                                                             [./y_pull_function]                                                                type                         = FunctionDirichletBC                               boundary                     = '5 '                                              function                     = top_pull                                          start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      variable                     = disp_y                                          [../]                                                                                                                                                             [./x_bot]                                                                          type                         = DirichletBC                                       boundary                     = '4 '                                              start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      value                        = 0                                                 variable                     = disp_x                                          [../]                                                                                                                                                             [./y_bot]                                                                          type                         = DirichletBC                                       boundary                     = '3 '                                              start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      value                        = 0                                                 variable                     = disp_y                                          [../]                                                                                                                                                             [./z_bot]                                                                          type                         = DirichletBC                                       boundary                     = '2 '                                              start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      value                        = 0                                                 variable                     = disp_z                                          [../]                                                                          []                                                                                                                                                                [AuxBCs]                                                                         []                                                                                                                                                                [Materials]                                                                        active                         = 'constant '                                                                                                                      [./constant]                                                                       type                         = LSHPlasticMaterial                                block                        = '1 '                                              disp_x                       = 'disp_x '                                         disp_y                       = 'disp_y '                                         disp_z                       = 'disp_z '                                         hardening_constant           = 1206                                              max_its                      = 10                                                poissons_ratio               = 0.3                                               print_debug_info             = 1                                                 start_time                   = -1.79769e+308                                     stop_time                    = 1.79769e+308                                      t_ref                        = 0                                                 thermal_conductivity         = 0                                                 thermal_expansion            = 0                                                 tolerance                    = 1e-05                                             yield_stress                 = 240                                               youngs_modulus               = 210000                                          [../]                                                                          []                                                                                                                                                                [Executioner]                                                                      auto_scaling                   = 0                                               l_abs_step_tol                 = -1                                              l_max_its                      = 100                                             l_tol                          = 1e-09                                           nl_abs_step_tol                = 1e-50                                           nl_abs_tol                     = 1e-10                                           nl_max_funcs                   = 10000                                           nl_max_its                     = 100                                             nl_rel_step_tol                = 1e-50                                           nl_rel_tol                     = 1e-12                                           no_fe_reinit                   = 0                                               perf_log                       = 1                                               petsc_options                  = '-snes_mf_operator -ksp_monitor -snes_ksp_... ew '                                                                               petsc_options_iname            = '-snes_type -snes_ls -ksp_gmres_restart '       petsc_options_value            = 'ls basic 101 '                                 scheme                         = backward-euler                                  type                           = Transient                                       dt                             = 0.0015                                          dtmax                          = 1e+30                                           dtmin                          = 0                                               end_time                       = 0.0105                                          initial_mesh_rebalance         = 0                                               n_startup_steps                = 0                                               num_steps                      = 1.79769e+308                                    ss_check_tol                   = 1e-08                                           ss_tmin                        = 0                                               start_time                     = 0                                               sync_times                     = '-1 '                                           trans_ss_check                 = 0                                             []                                                                                                                                                                [Postprocessors]                                                                 []                                                                                                                                                                [Output]                                                                           exodus                         = 1                                               file_base                      = out                                             gmv                            = 0                                               gnuplot_format                 = ps                                              interval                       = 1                                               output_displaced               = 0                                               output_initial                 = 1                                               postprocessor_csv              = 0                                               postprocessor_ensight          = 0                                               postprocessor_gnuplot          = 0                                               postprocessor_screen           = 1                                               print_linear_residuals         = 0                                               print_out_info                 = 0                                               tecplot                        = 0                                               tecplot_binary                 = 0                                               xda                            = 0                                             []                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ?X�t�j~�@O�   �@O�   �@O�   �@O�   �@O�   �@O�   �@O�   �@O�   �                                                                                                                                                                                                                                ���9�����9��|���9�タ��9��|                ?3�*0U=�?3�*0U=�                ?3�*0U=�?3�*0U=����9��                ���9�み��9��                ���9��@O�   �                        ?h�t�j~�@_����N@_����N@_����N@_����N@_����N@_����N@_����N@_����N                                                                                                                                                                                                                                �'��9�֑�'��9��R�'��9��Ŀ'��9���                ?C�*0U/&?C�*0U/&                ?C�*0U/&?C�*0U/&�'��9�ٙ                �'��9�� �'��9��~                �'��9��J@_����N                        ?rn��O�<@g������@g������@g������@g������@g������@g������@g������@g������                                                                                                                                                                                                                                �1��+�п1��+䆿1��+ݟ�1��+��                ?M}�H�e?M}�H�e                ?M}�H�e?M}�H�e�1��+�r                �1��+�L�1��+��                �1��+�@g������                        ?x�t�j~�@n1R~�@n1R~�@n1R~�@n1R~�@n1R~�@n1R~�@n1R~�@n1R~�����f� ¾���f� ¾���f� ¾���f� ¾���f� ¾���f� ¾���f� ¾���f� �?��f� �?��f� �?��f� �?��f� �?��f� �?��f� �?��f� �?��f� þ���f� þ���f� þ���f� þ���f� þ���f� þ���f� þ���f� þ���f� �                                �8VqI^x�8VqI^z_�8VqI^z�8VqI^z{                ?S�*0U1?S�*0U1                ?S�*0U1?S�*0U1�8VqI^��                �8VqI^yؿ8VqI^w�                �8VqI^u�@n1R~�����f� �?��f� þ���f� �?~�Q��@n�C�Az@n�C�Az@n�C�Az@n�C�Az@n�C�Az@n�C�Az@n�C�Az@n�C�Az�'E����'E����'E����'E����'E����'E����'E����'E����?7E����?7E����?7E����?7E����?7E����?7E����?7E����?7E����'E����'E����'E����'E����'E����'E����'E����'E����                                �A�t*�ڿA�t*w��A�t*���A�t*f�                ?X�t�MG�?X�t�MG�                ?X�t�MG�?X�t�MG��A�t*�                �A�t*o�A�t*�                �A�t*� @n�C�Az�'E����?7E����'E����?�n��O�;@n74�{h@n74�{h@n74�{h@n74�{h@n74�{h@n74�{h@n74�{h@n74�{h�5i	yg���5i	yg���5i	yg���5i	yg���5i	yg���5i	yg���5i	yg���5i	yg��?Ei	yg��?Ei	yg��?Ei	yg��?Ei	yg��?Ei	yg��?Ei	yg��?Ei	yg��?Ei	yg���5i	yg���5i	yg���5i	yg���5i	yg���5i	yg���5i	yg���5i	yg���5i	yg��                                �E�C���E�C�T�E�C���E�C�m                ?]}�HB�^?]}�HB�^                ?]}�HB�^?]}�HB�^�E�C�*                �E�C��c�E�C��                �E�C�k@n74�{h�5i	yg��?Ei	yg���5i	yg��?��$�/@n$�%�L@n$�%�L@n$�%�L@n$�%�L@n$�%�L@n$�%�L@n$�%�L@n$�%�L�?/?��ƿ?/?��ƿ?/?��ƿ?/?��ƿ?/?��ƿ?/?��ƿ?/?��ƿ?/?���?O/?���?O/?���?O/?���?O/?���?O/?���?O/?���?O/?���?O/?��Ŀ?/?��ƿ?/?��ƿ?/?��ƿ?/?��ƿ?/?��ƿ?/?��ƿ?/?��ƿ?/?���                                �J�yc��J�yXM�J�ybs�J�yYi                ?a4ꜟ{?a4ꜟ{                ?a4ꜟ{?a4ꜟ{�J�y`�                �J�yZF�J�y[                �J�yau@n$�%�L�?/?���?O/?��Ŀ?/?���