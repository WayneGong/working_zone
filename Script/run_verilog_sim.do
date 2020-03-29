transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work  working_zone.v

vcom -2008 -work work  Test_Bench.vhdl 

vsim   -L rtl_work -L work -voptargs="+acc"  project_tb

do wave.do
view structure
view signals
run 3000 ns

