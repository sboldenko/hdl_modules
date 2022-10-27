
add wave -noupdate -divider axi_stream_interface_testbench
add wave -noupdate -format Logic -radix UNSIGNED  -group {testbench} /axi_stream_interface_testbench/*

add wave -noupdate -divider axi_stream_interface_top
add wave -noupdate -format Logic -radix UNSIGNED  -group {top} /axi_stream_interface_testbench/axi_stream_interface_top_inst/*

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1611 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps