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




enum logic [1:0] {
                  IDLE,
                  TOTAL_ZERO,
                  ZERO_RUN
                  } CurrentState, NextState;


always_ff @(posedge Clk or negedge nReset)
  if (!nReset) CurrentState <= IDLE;
  else CurrentState <= NextState;

always_comb begin
  unique case (CurrentState)
    IDLE : if (Enable) NextState = TOTAL_ZERO;
    else NextState = IDLE;
    TOTAL_ZERO : NextState = ZERO_RUN;
    ZERO_RUN : if (ZeroesLeft == 0) NextState = IDLE;
    else NextState = ZERO_RUN;
    
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
  end
  else begin
    if (CurrentState == IDLE) ZeroesLeft <= '0;
    else if (CurrentState == TOTAL_ZERO) ZeroesLeft <= TotalZeroes;
    else if (CurrentState == ZERO_RUN) ZeroesLeft <= RunBefore==0 ? 0 : ZeroesLeft - RunBefore;
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
      ShiftEn = '1;
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
    if (CurrentState == ZERO_RUN && ZeroesLeft==0) Done <= 1'b1;
    else Done <= 1'b0;
  end
endmodule

