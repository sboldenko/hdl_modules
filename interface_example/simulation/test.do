vlib work
vmap work work

vlog ../hdl/axi_stream_interface.sv
vlog ../tb/axi_stream_interface_testbench.sv
vlog ../hdl/axi_stream_interface_top.sv

vsim -t 1ps -voptargs=+acc=lprn -lib work  axi_stream_interface_testbench

do waves.do 
view wave
run 10 us