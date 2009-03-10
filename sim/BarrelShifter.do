vlog -work work  ../rtl/BarrelShifter.sv \
../rtl/FIFOMemory.v \
../rtl/FIFO.sv \

vlog -work work tbBarrelShifter.sv

vsim -novopt tbBarrelShifter

add wave -group {BarrelShifter} -radix 16 {tbBarrelShifter/uBarrelShifter/*}
add wave -group {BarrelShifter} -radix 10 {tbBarrelShifter/capture_count}
add wave -group {FIFO} -radix 16 {tbBarrelShifter/uBarrelShifter/uFIFO/*}
add wave -group {FIFO mem} -radix 16 {tbBarrelShifter/uBarrelShifter/uFIFO/uFIFOMemory/Memory[0]}
add wave -group {FIFO mem} -radix 16 {tbBarrelShifter/uBarrelShifter/uFIFO/uFIFOMemory/Memory[1]}
add wave -group {FIFO mem} -radix 16 {tbBarrelShifter/uBarrelShifter/uFIFO/uFIFOMemory/Memory[2]}
add wave -group {FIFO mem} -radix 16 {tbBarrelShifter/uBarrelShifter/uFIFO/uFIFOMemory/Memory[3]}
add wave -group {FIFO mem} -radix 16 {tbBarrelShifter/uBarrelShifter/uFIFO/uFIFOMemory/Memory[4]}
add wave -group {FIFO mem} -radix 16 {tbBarrelShifter/uBarrelShifter/uFIFO/uFIFOMemory/Memory[5]}
add wave -group {FIFO mem} -radix 16 {tbBarrelShifter/uBarrelShifter/uFIFO/uFIFOMemory/Memory[6]}
add wave -group {FIFO mem} -radix 16 {tbBarrelShifter/uBarrelShifter/uFIFO/uFIFOMemory/Memory[7]}
add wave -group {FIFO mem} -radix 16 {tbBarrelShifter/uBarrelShifter/uFIFO/uFIFOMemory/Memory[7]}
add wave -group {FIFO mem} -radix 16 {tbBarrelShifter/uBarrelShifter/uFIFO/uFIFOMemory/WE}
add wave -group {FIFO mem} -radix 16 {tbBarrelShifter/uBarrelShifter/uFIFO/uFIFOMemory/DataIn}
add wave -group {FIFO mem} -radix 16 {tbBarrelShifter/uBarrelShifter/uFIFO/uFIFOMemory/AddrWrite}
run -all