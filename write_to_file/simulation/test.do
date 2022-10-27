vlib work
vmap work work

vcom -93 ../tb/write_to_file.vhd

vsim -t 1ps -vopt -voptargs=+acc=lprn -L work write_to_file

do wave_test.do 
view wave
run 5 us