vlog -work work  ../rtl/CoeffTokenDecode.sv \
../rtl/CoeffTokenROM02.v \
../rtl/FIFOMemory.v \
../rtl/FIFO.sv \
../rtl/CTRLFSM.sv \
../rtl/BarrelShifter.sv \
../rtl/PulseGenRising.v \
../rtl/CAVLC.sv


vlog -work work tbCAVLC.sv

vsim -novopt tbCAVLC

add wave -radix 16 {tbCAVLC/uCAVLC/*}

add wave -group {FIFO} -radix 16 {tbCAVLC/uCAVLC/uBarrelShifter/uFIFO/*}
add wave -group {BarrelShifter} -radix 16 {tbCAVLC/uCAVLC/uBarrelShifter/*}
add wave -group {CoeffTokenDecode} -radix 16 {tbCAVLC/uCAVLC/uCoeffTokenDecode/*}
add wave -group {CTRL FSM} -radix 16 {tbCAVLC/uCAVLC/uCTRLFSM/*}

run -all