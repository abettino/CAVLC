module CoeffTokenDecode (
                         input logic Clk,
                         input logic nReset,
                         input logic Enable,
                         input logic [15:0] BitstreamShifted,
                         output logic [4:0] TotalCoeff,
                         output logic [1:0] TrailingOnes,
                         output logic [4:0] NumShift
                         );



logic [4:0]                                 TotalCoeffInt;
logic [1:0]                                 TrailingOnesInt;

always_ff @(posedge Clk or negedge nReset)
  if (!nReset) {TotalCoeff,TrailingOnes} <= {'0,'0};
  else if (Enable) {TotalCoeff,TrailingOnes} <= {TotalCoeffInt,TrailingOnesInt};

CoeffTokenROM02 uCoeffTokenROM02 (
                                  .Address     (BitstreamShifted), 
                                  .TotalCoeff  (TotalCoeffInt), 
                                  .TrailingOnes(TrailingOnesInt),
                                  .NumShift    (NumShift)
                                  );


endmodule