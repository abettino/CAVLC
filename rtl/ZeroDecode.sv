module ZeroDecode (
                   input Clk,
                   input nReset,
                   input  logic Enable,
                   input  logic [15:0] BitstreamShifted,
                   input  logic [4:0] TotalCoeff,
                   output logic [4:0] NumShift,
                   output logic ShiftEn,
                   output logic Done
                   );


logic [3:0]                     TotalZeroes;  
logic [3:0]                     NumShiftTotalZero;
logic [3:0]                     NumShiftRunBefore;
logic [3:0]                     ZeroesLeft;


logic [3:0]                     RunBefore;

logic [4:0]                     CoeffCnt;



enum logic [1:0] {
                  IDLE,
                  TOTAL_ZERO,
                  ZERO_RUN,
                  WAIT
                  } CurrentState, NextState;


always_ff @(posedge Clk or negedge nReset)
  if (!nReset) CurrentState <= IDLE;
  else CurrentState <= NextState;

always_comb begin
  unique case (CurrentState)
    IDLE : if (Enable && TotalCoeff >= 1) NextState = TOTAL_ZERO;
    else NextState = IDLE;
    TOTAL_ZERO : NextState = ZERO_RUN;
    ZERO_RUN : if (ZeroesLeft == 0 || CoeffCnt==TotalCoeff) NextState = WAIT;
    else NextState = ZERO_RUN;
    WAIT : if (!Enable) NextState = IDLE;
    else NextState = WAIT;
    
  endcase
end



TotalZeroTable_1 TotalZeroTable  (
  .Bits (BitstreamShifted[15:7]),
  .TotalCoeff(TotalCoeff),
  .TotalZeroes(TotalZeroes),
  .NumShift (NumShiftTotalZero)
);


RunBeforeTable uRunBeforeTable (
                       .ZeroesLeft(ZeroesLeft),
                       .Bits(BitstreamShifted[15:5]),
                       .RunBefore(RunBefore),
                       .NumShift(NumShiftRunBefore)
);


always_ff @(posedge Clk or negedge nReset)
  if (!nReset) begin
    ZeroesLeft <= '0;
    CoeffCnt <= '0;              
  end
  else begin
    if (CurrentState == IDLE) begin 
      ZeroesLeft <= '0;
      CoeffCnt <= '0;
    end
    else if (CurrentState == TOTAL_ZERO) begin 
      ZeroesLeft <= TotalZeroes;
      CoeffCnt <= CoeffCnt + 1;
    end
    else if (CurrentState == ZERO_RUN) begin 
      ZeroesLeft <= ZeroesLeft - RunBefore;
      if (CoeffCnt < TotalCoeff) CoeffCnt <= CoeffCnt + 1;
    end
  end

always_comb begin
  case (CurrentState)
    IDLE : begin
      NumShift = '0;
      ShiftEn = '0;
    end
    TOTAL_ZERO : begin
      NumShift = {1'b0,NumShiftTotalZero};
      ShiftEn = '1;
    end
    ZERO_RUN : begin
      NumShift = {1'b0,NumShiftRunBefore};
      if (CoeffCnt < TotalCoeff) ShiftEn = '1;
      else ShiftEn = '0;
    end
    default : begin
      NumShift = '0;
      ShiftEn = '0;
    end
  endcase
end

always_ff @(posedge Clk or negedge nReset)
  if (!nReset) begin
    Done <= '0;
  end
  else begin
    if ((Enable && TotalCoeff <= 1) || (CurrentState == ZERO_RUN && ZeroesLeft==0) || (CurrentState==ZERO_RUN && CoeffCnt==TotalCoeff)) Done <= 1'b1;
    else Done <= 1'b0;
  end
endmodule

