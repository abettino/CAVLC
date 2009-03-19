set compile_roms false


if ([string equal $compile_roms "true"]) {
vlog -work work  ../rtl/CoeffTokenROM02.v \
../rtl/CoeffTokenROM48.v \
../rtl/CoeffTokenROM8.v \
}

vlog -work work  ../rtl/CoeffTokenDecode.sv \
../rtl/FIFOMemory.v \
../rtl/FIFO.sv \
../rtl/CTRLFSM.sv \
../rtl/BarrelShifter.sv \
../rtl/PulseGenRising.v \
../rtl/LevelDecode.sv \
../rtl/LevelProcessingUnit.sv \
../rtl/OneFinder.sv \
../rtl/ZeroDecode.sv \
../rtl/TotalZeroTable_1.v \
../rtl/RunBeforeTable.v \
../rtl/CAVLC.sv


vlog -work work tbCAVLC.sv

vsim -novopt tbCAVLC

add wave -radix 16 {tbCAVLC/uCAVLC/*}

add wave -group {FIFO} -radix 16 {tbCAVLC/uCAVLC/uBarrelShifter/uFIFO/*}
add wave -group {FIFO Memory} -radix 16 {tbCAVLC/uCAVLC/uBarrelShifter/uFIFO/uFIFOMemory/*}
add wave -group {FIFO Memory} -radix 16 {tbCAVLC/uCAVLC/uBarrelShifter/uFIFO/uFIFOMemory/Memory[0]}
add wave -group {FIFO Memory} -radix 16 {tbCAVLC/uCAVLC/uBarrelShifter/uFIFO/uFIFOMemory/Memory[1]}
add wave -group {FIFO Memory} -radix 16 {tbCAVLC/uCAVLC/uBarrelShifter/uFIFO/uFIFOMemory/Memory[2]}
add wave -group {FIFO Memory} -radix 16 {tbCAVLC/uCAVLC/uBarrelShifter/uFIFO/uFIFOMemory/Memory[3]}
add wave -group {FIFO Memory} -radix 16 {tbCAVLC/uCAVLC/uBarrelShifter/uFIFO/uFIFOMemory/Memory[4]}
add wave -group {FIFO Memory} -radix 16 {tbCAVLC/uCAVLC/uBarrelShifter/uFIFO/uFIFOMemory/Memory[5]}
add wave -group {FIFO Memory} -radix 16 {tbCAVLC/uCAVLC/uBarrelShifter/uFIFO/uFIFOMemory/Memory[6]}
add wave -group {FIFO Memory} -radix 16 {tbCAVLC/uCAVLC/uBarrelShifter/uFIFO/uFIFOMemory/Memory[7]}
add wave -group {BarrelShifter} -radix 16 {tbCAVLC/uCAVLC/uBarrelShifter/*}
add wave -group {CoeffTokenDecode} -radix 16 {tbCAVLC/uCAVLC/uCoeffTokenDecode/*}
add wave -group {LevelDecode} -radix 16 {tbCAVLC/uCAVLC/uLevelDecode/*}
add wave -group {LevelProcUnit} -radix 16 {tbCAVLC/uCAVLC/uLevelDecode/uLevelProcessingUnit/*}
add wave -group {CTRL FSM} -radix 16 {tbCAVLC/uCAVLC/uCTRLFSM/*}
add wave -group {Zero Decode} -radix 16 {tbCAVLC/uCAVLC/uZeroDecode/*}
add wave -group {Run before table} -radix 16 {tbCAVLC/uCAVLC/uZeroDecode/uRunBeforeTable/*}
add wave -group {Top out} -radix 10 {tbCAVLC/uCAVLC/LevelOut}
add wave -group {Top out} -radix 10 {tbCAVLC/uCAVLC/WrReq}


run -all