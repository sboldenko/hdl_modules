vlib work
vmap work work

vcom -93 ../tb/read_from_file.vhd

vsim -t 1ps -vopt -voptargs=+acc=lprn -L work read_from_file

do wave_test.do 
view wave
run 5 us