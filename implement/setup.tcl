# This script sets up a Vivado project with all ip references resolved.
file delete -force proj.xpr *.os *.jou *.log proj.srcs proj.cache proj.runs
#
create_project -force proj 
set_property part xc7a50tfgg484-2 [current_project]
#set_property board_part em.avnet.com:microzed_7020:part0:1.1 [current_project]
#create_project -in_memory -part xc7z020clg400-1 proj
set_property target_language Verilog [current_project]
set_property default_lib work [current_project]
load_features ipintegrator
tclapp::install ultrafast -quiet

file delete -force ./ip
file mkdir ./ip

read_ip ../source/ddr_io_wiz0/ddr_io_wiz0.xci
read_ip ../source/ddr_if_clk_wiz/ddr_if_clk_wiz.xci
upgrade_ip -quiet  [get_ips *]
generate_target {all} [get_ips *]

#source ../source/system.tcl
#generate_target {synthesis implementation} [get_files ./proj.srcs/sources_1/bd/system/system.bd]

# Read in the hdl source.
#read_vhdl [glob ../source/spi_slave/spi_slave.vhd]
read_verilog -sv  [glob ../source/ddr_if_5to2.v]

#read_xdc ../source/top.xdc

close_project


