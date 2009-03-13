
module CoeffTokenDecode (
                         input logic Clk,
                         input logic nReset,
                         input logic Enable,
                         input logic [15:0] BitstreamShifted,
                         output logic [4:0] TotalCoeff,
                         output logic [1:0] TrailingOnes,
                         output logic [4:0] NumShift
                         );



parameter COEFF_MEM_SIZE = 5;


logic [4:0]                                 TotalCoeffInt;
logic [1:0]                                 TrailingOnesInt;

logic [4:0]                                 TotalCoeff02;
logic [1:0]                                 TrailingOnes02;
logic [4:0]                                 NumShift02;

logic [4:0]                                 TotalCoeff48;
logic [1:0]                                 TrailingOnes48;
logic [4:0]                                 NumShift48;


logic [4:0]                                 nC;

logic [4:0]                                 TotalCoeffPrev;
logic [1:0]                                 CoeffCnt;


logic [4:0]                                 TotalCoeffMem[0:COEFF_MEM_SIZE-1];
logic [2:0]                                 CoeffMemPtr;
logic [2:0]                                 CoeffMemCnt;
logic [2:0]                                 CoeffSamples;
logic [15:0]                                TotalCoeffSum;
logic [4:0]                                 TotalCoeffAvg;
logic                                       CalcAvg;                                    



//always_ff @(posedge Clk or negedge nReset)
//  if (!nReset) nC <= '0;
//  else nC <= TotalCoeffAvg;


always_ff @(posedge Clk or negedge nReset)
  if (!nReset) {TotalCoeff,TrailingOnes} <= {'0,'0};
  else if (Enable) {TotalCoeff,TrailingOnes} <= {TotalCoeffInt,TrailingOnesInt};

always_comb begin
  case (nC)
    0,1,2 : begin 
      TotalCoeffInt = TotalCoeff02;
      TrailingOnesInt = TrailingOnes02;
      NumShift = NumShift02;
    end
    5,6,7,8 : begin
      TotalCoeffInt = TotalCoeff48;
      TrailingOnesInt = TrailingOnes48;
      NumShift = NumShift48;
    end
    default : begin
      TotalCoeffInt = 'x;
      TrailingOnesInt = 'x;
      NumShift = '0;
    end
  endcase
end

CoeffTokenROM02 uCoeffTokenROM02 (
                                  .Address     (BitstreamShifted), 
                                  .TotalCoeff  (TotalCoeff02), 
                                  .TrailingOnes(TrailingOnes02),
                                  .NumShift    (NumShift02)
                                  );



CoeffTokenROM48 uCoeffTokenROM48 (
                                  .Address     (BitstreamShifted), 
                                  .TotalCoeff  (TotalCoeff48), 
                                  .TrailingOnes(TrailingOnes48),
                                  .NumShift    (NumShift48)
                                  );


always_ff @(posedge Clk or negedge nReset) begin
  if (!nReset) begin
    TotalCoeffPrev <= '0;
    CoeffCnt <= '0;
    nC <= '0;
  end
  else begin
    if (Enable) begin
      TotalCoeffPrev <= TotalCoeff;
      CoeffCnt <= {CoeffCnt[0],1'b1};
    end

    if (CoeffCnt==0) nC <= '0;
    else if (CoeffCnt==1) nC <= TotalCoeff;
    else nC <= (TotalCoeff + TotalCoeffPrev) >> 1;
  end
end

/*
always_ff @(posedge Clk or negedge nReset) begin
  if (!nReset) begin
    for (int i=0;i<COEFF_MEM_SIZE;i++) TotalCoeffMem[i] <= '0;
    CoeffMemPtr <= '0;
    CoeffSamples <= '0;
    CoeffMemCnt <= '0;
    CalcAvg <= '0;
    TotalCoeffSum <= '0;
    TotalCoeffAvg <= '0;
  end
  else begin
    if (Enable) begin
      for (int i=0;i<COEFF_MEM_SIZE;i++) if (i==CoeffMemPtr) TotalCoeffMem[i] <= TotalCoeffInt;
      if (CoeffMemPtr == COEFF_MEM_SIZE - 1) CoeffMemPtr <= 0;
      else CoeffMemPtr <= CoeffMemPtr + 1;
      if (CoeffMemPtr != COEFF_MEM_SIZE) CoeffSamples <= CoeffSamples + 1;
      CalcAvg <= '1;
      TotalCoeffSum <= '0;
    end
    else begin
      if (CalcAvg) begin
        if (CoeffMemCnt == CoeffSamples -1) begin
          CoeffMemCnt <= 0;
          CalcAvg <= '0;
        end
        else begin 
          CoeffMemCnt <= CoeffMemCnt + 1;
        end
        for (int i=0;i<COEFF_MEM_SIZE;i++) if (i==CoeffMemCnt) TotalCoeffSum <= TotalCoeffSum + TotalCoeffMem[i];
      end
      else begin
        if (CoeffSamples != 0) TotalCoeffAvg <= TotalCoeffSum/CoeffSamples;
      end
    end
  end
end
*/




endmodule