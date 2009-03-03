vlog -work work ../rtl/CAVLC.sv
vlog -work work tbCAVLC.sv

vsim -novopt tbCAVLC

add wave -radix 16 {tbCAVLC/uCAVLC/*}

run -all