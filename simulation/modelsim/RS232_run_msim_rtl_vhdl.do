transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/TRETEC/Documents/Master_1/VHDL/RS232/comparateur.vhd}
vcom -93 -work work {C:/Users/TRETEC/Documents/Master_1/VHDL/RS232/compteur_generic.vhd}
vcom -93 -work work {C:/Users/TRETEC/Documents/Master_1/VHDL/RS232/reg_dec.vhd}
vcom -93 -work work {C:/Users/TRETEC/Documents/Master_1/VHDL/RS232/registre.vhd}
vcom -93 -work work {C:/Users/TRETEC/Documents/Master_1/VHDL/RS232/UC_RS232.vhd}
vcom -93 -work work {C:/Users/TRETEC/Documents/Master_1/VHDL/RS232/RS232_decoder.vhd}

vcom -93 -work work {C:/Users/TRETEC/Documents/Master_1/VHDL/RS232/simulation/modelsim/RS232_decoder.vht}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  RS232_decoder_vhd_tst

add wave *
view structure
view signals
run -all
