#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file d:/work/ti/dragonslair/cart/cpld\gigacart_synplify.tcl
#-- Written on Sun Sep 16 22:29:09 2018


#device options
set_option -technology ispmach4000b

#compilation/mapping options
set_option -default_enum_encoding default
set_option -symbolic_fsm_compiler true
set_option -map_logic false
set_option -max_terms_per_macrocell 16
set_option -resource_sharing true

#map options
set_option -frequency 200
set_option -fanin_limit 20
set_option -auto_constrain_io true
set_option -disable_io_insertion false
set_option -compiler_compatible true

#simulation options
set_option -write_verilog false
set_option -write_vhdl false

#timing analysis options
set_option -num_critical_paths 3
set_option -num_startend_points 0

#automatic place and route (vendor) options
set_option -write_apr_constraint 1
set_option -areadelay 0
set_option -synthesis_onoff_pragma false

#-- add_file options
add_file -vhdl -lib work "design.vhd"

#-- top module name
set_option -top_module gigacart

#-- set result format/file last
project -result_file "gigacart.edi"

#-- error message log file
project -log_file gigacart.srf

#-- run Synplify with 'arrange VHDL file'
project -run hdl_info_gen -fileorder
project -run
