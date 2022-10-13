vlib work
vmap work work

vlog     ../tb/pwm_module_testbench.sv
vcom -93 ../hdl/pwm_module.vhd

vsim -t 1ps -voptargs=+acc=lprn -lib work  pwm_module_testbench

do waves.do 
view wave
run 100 ms