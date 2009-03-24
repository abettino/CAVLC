////////////////////////////////////////////////////////////////////////////////
//  File : LevelProcessingUnit.sv
//  Desc : Level Processing unit. Converts the Level code into
//         an output level.
////////////////////////////////////////////////////////////////////////////////
module LevelProcessingUnit (
  input  logic        Clk,            // Clock.
  input  logic        nReset,         // Async reset.                           
  input  logic  [1:0] TrailingOnes,   // Number of trailing ones.
  input  logic        TrailingOneMode,// Indicates trailine one proc.
  input  logic        LPUTrig,        // LPU trigger.
  input  logic  [2:0] SuffixLength,
  input  logic [13:0] CodeNum,
  output logic [12:0] LevelOut,
  output logic        WrReq
);
// Declarations.
////////////////////////////////////////////////////////////////////////////////
logic [13:0]                                    MidCalc;
logic [13:0]                                    CodeNumInt;
// Divide level out by 2.
assign LevelOut = MidCalc[13:1];
// Special case.
always_comb begin
  if (SuffixLength == 0 && TrailingOnes<3) CodeNumInt = CodeNum + 2;
  else CodeNumInt = CodeNum;
end
// Sync. output logic.
////////////////////////////////////////////////////////////////////////////////
always_ff @(posedge Clk or negedge nReset)
  if (!nReset) begin 
    MidCalc <= '0;
    WrReq <= '0;
  end
  else if (TrailingOneMode & LPUTrig) begin // trailing one, 1 or -1 output.
    MidCalc <= CodeNum[0] ? '1 : 'h02;
    WrReq <= '1;
  end
  else if (LPUTrig) begin  // standard output.
    MidCalc <= CodeNumInt[0] ? -CodeNumInt-1 : CodeNumInt+2;
    WrReq <= '1;
  end
  else begin
    WrReq <= '0;
  end
////////////////////////////////////////////////////////////////////////////////
endmodule