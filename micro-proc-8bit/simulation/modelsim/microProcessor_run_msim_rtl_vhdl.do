transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Ghaith/Documents/VHDL/Vhdl/ram.vhd}
vcom -93 -work work {C:/Users/Ghaith/Documents/VHDL/Vhdl/microProcessor.vhd}
vcom -93 -work work {C:/Users/Ghaith/Documents/VHDL/Vhdl/ual.vhd}
vcom -93 -work work {C:/Users/Ghaith/Documents/VHDL/Vhdl/cpu.vhd}
vcom -93 -work work {C:/Users/Ghaith/Documents/VHDL/Vhdl/register_gen.vhd}
vcom -93 -work work {C:/Users/Ghaith/Documents/VHDL/Vhdl/register_inc.vhd}
vcom -93 -work work {C:/Users/Ghaith/Documents/VHDL/Vhdl/ctr.vhd}

