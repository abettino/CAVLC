module LevelProcessingUnit (
                            input  logic        Clk,              // Clock.
                            input  logic        nReset,           // Async reset.                           
                            input logic LPUTrig,
                            input logic [2:0] SuffixLength,
                            input logic [13:0] CodeNum,
                            output logic [12:0] LevelOut,
                            output logic WrReq
                            );


logic [13:0]                                    MidCalc;
logic [13:0]                                    CodeNumInt;


assign LevelOut = MidCalc[13:1];


always_comb begin
  if (SuffixLength == 0) CodeNumInt = CodeNum + 2;
  else CodeNumInt = CodeNum;
end

always_ff @(posedge Clk or negedge nReset)
  if (!nReset) begin 
    MidCalc <= '0;
    WrReq <= '0;
  end
  else if (LPUTrig) begin 
    MidCalc <= CodeNumInt[0] ? -CodeNumInt-1 : CodeNumInt+2;
    WrReq <= '1;
  end
  else begin
    WrReq <= '0;
  end


endmodule