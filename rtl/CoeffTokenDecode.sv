////////////////////////////////////////////////////////////////////////////////
//  File : CoeffTokenDecode.sv
//  Desc : Coeff token decoder.
//   
////////////////////////////////////////////////////////////////////////////////
`define NEW_LUTS 

module CoeffTokenDecode (
  input  logic        Clk,             // clock.
  input  logic        nReset,          // reset.
  input  logic        Enable,          // enable.
  input  logic [15:0] BitstreamShifted,// shifted bitstream.
  input  logic  [4:0] nC,              // nC, from external.
  output logic  [4:0] TotalCoeff,      // Calculated total coeff.
  output logic  [1:0] TrailingOnes,    // traillings ones.
  output logic  [4:0] NumShift,         // amount to shift.
  output logic Done
                         );

// Declarations.
// Internal total coeff and trail ones signals.
logic [4:0]                                 TotalCoeffInt;
logic [1:0]                                 TrailingOnesInt;
// Total coeff, trailing ones, num shift for 0 <= nC < 2
logic [4:0]                                 TotalCoeff02;
logic [1:0]                                 TrailingOnes02;
logic [4:0]                                 NumShift02;
// Total coeff, trailing ones, num shift for 4 <= nC < 8 
logic [4:0]                                 TotalCoeff48;
logic [1:0]                                 TrailingOnes48;
logic [4:0]                                 NumShift48;
// Total coeff, trailing ones, num shift for 2 <= nC < 4 
logic [4:0]                                 TotalCoeff24;
logic [1:0]                                 TrailingOnes24;
logic [4:0]                                 NumShift24;
// Total coeff, trailing ones, num shift for nC >= 8 
logic [4:0]                                 TotalCoeff8;
logic [1:0]                                 TrailingOnes8;
logic [4:0]                                 NumShift8;
// Total coeff, trailing ones, num shift for nC == -1 
logic [4:0]                                 TotalCoeffNeg1;
logic [1:0]                                 TrailingOnesNeg1;
logic [4:0]                                 NumShiftNeg1;
// Total coeff, trailing ones, num shift for nC == -2 
logic [4:0]                                 TotalCoeffNeg2;
logic [1:0]                                 TrailingOnesNeg2;
logic [4:0]                                 NumShiftNeg2;

logic                                       Done02;
logic                                       EnablePulse;

PulseGenRising uPulseGenRising(
  .Clk(Clk),
  .nReset(nReset),
  .D(Enable),
  .Pulse(EnablePulse)
);

// Sync. Total Coeff and Trailing ones logic.
always_ff @(posedge Clk or negedge nReset)
  if (!nReset) {TotalCoeff,TrailingOnes} <= {'0,'0};
  else if (Enable && Done) {TotalCoeff,TrailingOnes} <= {TotalCoeffInt,TrailingOnesInt};

// Mux selects which table based on nC
always_comb begin
  case (nC)
    0,1 : begin 
      TotalCoeffInt = TotalCoeff02;
      TrailingOnesInt = TrailingOnes02;
      NumShift = NumShift02;
      Done = Done02;
    end
    2,3 : begin
      TotalCoeffInt = TotalCoeff24;
      TrailingOnesInt = TrailingOnes24;
      NumShift = NumShift24;
      Done = EnablePulse;
    end
    4,5,6,7 : begin
      TotalCoeffInt = TotalCoeff48;
      TrailingOnesInt = TrailingOnes48;
      NumShift = NumShift48;
      Done = EnablePulse;
    end
    8,9,10,11,12,13,14,15,16 : begin
      TotalCoeffInt = TotalCoeff8;
      TrailingOnesInt = TrailingOnes8;
      NumShift = NumShift8;
      Done = EnablePulse;       
    end
    'b11110 : begin
      TotalCoeffInt = TotalCoeffNeg1;
      TrailingOnesInt = TrailingOnesNeg1;
      NumShift = NumShiftNeg1;
      Done = EnablePulse;       
    end
    'b11111 : begin
      TotalCoeffInt = TotalCoeffNeg2;
      TrailingOnesInt = TrailingOnesNeg2;
      NumShift = NumShiftNeg2;
      Done = EnablePulse;
    end
    default : begin
      TotalCoeffInt = 'x;
      TrailingOnesInt = 'x;
      NumShift = '0;
      Done = 1'b1;
    end
  endcase
end


// ROM for 0 <= nC < 2
`ifdef NEW_LUTS
/*
CoeffTokenLUT02 uCoeffTokenROM02 (
  .Bits     (BitstreamShifted), 
  .TotalCoeff  (TotalCoeff02), 
  .TrailingOnes(TrailingOnes02),
  .NumShift    (NumShift02)
                                  );*/
CoeffTokenLUT02StagesTop uCoeffTokenROM02 (
                          .Data(BitstreamShifted),
                          .Clk(Clk),
                          .nReset(nReset),
                          .Enable(Enable),
                          .TotalCoeff(TotalCoeff02), 
                          .TrailingOnes(TrailingOnes02),
                          .NumShift(NumShift02),
                          .Done(Done02)                          
                          );

`else
CoeffTokenROM02 uCoeffTokenROM02 (
  .Address     (BitstreamShifted), 
  .TotalCoeff  (TotalCoeff02), 
  .TrailingOnes(TrailingOnes02),
  .NumShift    (NumShift02)
                                  );
`endif

// ROM for 4 <= nC < 8
CoeffTokenROM48 uCoeffTokenROM48 (
  .Address     (BitstreamShifted), 
  .TotalCoeff  (TotalCoeff48), 
  .TrailingOnes(TrailingOnes48),
  .NumShift    (NumShift48)
                                  );
// ROM for nC >= 8
CoeffTokenROM8 uCoeffTokenROM8 (
  .Address     (BitstreamShifted), 
  .TotalCoeff  (TotalCoeff8), 
  .TrailingOnes(TrailingOnes8),
  .NumShift    (NumShift8)
                                  );
// ROM for 2 <= nC < 4
CoeffTokenROM24 uCoeffTokenROM24 (
  .Address     (BitstreamShifted), 
  .TotalCoeff  (TotalCoeff24), 
  .TrailingOnes(TrailingOnes24),
  .NumShift    (NumShift24)
                                  );
// ROM for nC == -1
CoeffTokenROMNeg1 uCoeffTokenROMNeg1 (
 .Address     (BitstreamShifted), 
 .TotalCoeff  (TotalCoeffNeg1), 
 .TrailingOnes(TrailingOnesNeg1),
 .NumShift    (NumShiftNeg1)
                                  );
// ROM for nC == -2
CoeffTokenROMNeg2 uCoeffTokenROMNeg2 (
  .Address     (BitstreamShifted), 
  .TotalCoeff  (TotalCoeffNeg2), 
  .TrailingOnes(TrailingOnesNeg2),
  .NumShift    (NumShiftNeg2)
                                  );

endmodule