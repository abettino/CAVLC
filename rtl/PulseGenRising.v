// Module will generate a single cycle pulse on the rising
// edge of D. Make sure D is sync to Clk.
module PulseGenRising (
  input Clk,
  input nReset,
  input D,
  output Pulse
);

reg DPrev;

always @(posedge Clk or negedge nReset) 
  if (!nReset) DPrev <= 1'b0;
  else         DPrev <= D;

assign Pulse = D & !DPrev;

endmodule