module CoeffTokenDecode (
                         input logic Clk,
                         input logic nReset,
                         input logic [15:0] BitstreamShifted,
                         output logic [4:0] TotalCoeff,
                         output logic [1:0] TrailingOnes,
                         output logic [4:0] NumShift
                         );





CoeffTokenROM02 uCoeffTokenROM02 (
                                  .Address     (BitstreamShifted), 
                                  .TotalCoeff  (TotalCoeff), 
                                  .TrailingOnes(TrailingOnes),
                                  .NumShift    (NumShift)
                                  );


endmodule