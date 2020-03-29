onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /project_tb/UUT/i_clk
add wave -noupdate -radix unsigned /project_tb/UUT/i_start
add wave -noupdate -radix unsigned /project_tb/UUT/i_rst
add wave -noupdate -radix unsigned /project_tb/UUT/i_data
add wave -noupdate -radix unsigned /project_tb/UUT/o_address
add wave -noupdate -radix unsigned /project_tb/UUT/o_done
add wave -noupdate -radix unsigned /project_tb/UUT/o_en
add wave -noupdate -radix unsigned /project_tb/UUT/o_we
add wave -noupdate -radix unsigned /project_tb/UUT/o_data
add wave -noupdate -radix unsigned /project_tb/UUT/o_address_dly
add wave -noupdate -radix unsigned /project_tb/UUT/o_en_dly
add wave -noupdate -radix unsigned /project_tb/UUT/o_we_dly
add wave -noupdate -radix unsigned /project_tb/UUT/data0
add wave -noupdate -radix unsigned /project_tb/UUT/data1
add wave -noupdate -radix unsigned /project_tb/UUT/data2
add wave -noupdate -radix unsigned /project_tb/UUT/data3
add wave -noupdate -radix unsigned /project_tb/UUT/data4
add wave -noupdate -radix unsigned /project_tb/UUT/data5
add wave -noupdate -radix unsigned /project_tb/UUT/data6
add wave -noupdate -radix unsigned /project_tb/UUT/data7
add wave -noupdate -radix unsigned /project_tb/UUT/i_addr
add wave -noupdate -radix unsigned /project_tb/UUT/i_data_en
add wave -noupdate -radix unsigned /project_tb/UUT/WZ_BIT
add wave -noupdate -radix unsigned /project_tb/UUT/WZ_NUM
add wave -noupdate -radix unsigned /project_tb/UUT/WZ_OFFSET
add wave -noupdate -radix binary /project_tb/UUT/WZ_OFFSET_ONE_HOT
add wave -noupdate -radix unsigned /project_tb/UUT/wz0
add wave -noupdate -radix unsigned /project_tb/UUT/wz1
add wave -noupdate -radix unsigned /project_tb/UUT/wz2
add wave -noupdate -radix unsigned /project_tb/UUT/wz3
add wave -noupdate -radix unsigned /project_tb/UUT/wz4
add wave -noupdate -radix unsigned /project_tb/UUT/wz5
add wave -noupdate -radix unsigned /project_tb/UUT/wz6
add wave -noupdate -radix unsigned /project_tb/UUT/wz7
add wave -noupdate -radix unsigned /project_tb/UUT/wz
add wave -noupdate -radix unsigned /project_tb/UUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {231259 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1664286 ps}
