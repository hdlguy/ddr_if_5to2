# This file sets up the simulation environment.
create_project -force proj 
set_property part xc7a50tfgg484-2 [current_project]
set_property target_language Verilog [current_project]
set_property "default_lib" "work" [current_project]
create_fileset -simset simset

read_ip [ glob ../source/ddr_if_clk_wiz/ddr_if_clk_wiz.xci ]
read_ip [ glob ../source/ddr_io_wiz0/ddr_io_wiz0.xci ]
generate_target {all} [get_ips *]

read_verilog -sv [glob ../source/dac_if_5to2.v]
read_verilog -sv [glob ../source/dac_if_5to2_tb.v]

current_fileset -simset [ get_filesets simset ]

set_property -name {xsim.elaborate.debug_level} -value {all} -objects [current_fileset -simset]
set_property -name {xsim.simulate.runtime} -value {600ns} -objects [current_fileset -simset]

close_project


