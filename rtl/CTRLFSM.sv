module CTRLFSM (
                input  logic        Clk,              // Clock.
                input  logic        nReset,           // Async reset.           
                input  logic        Enable,
                input  logic        BarrelShifterReady,
                input  logic [4:0]  NumShift_CoeffTokenDecode,
                output logic        ShiftEn,
                output logic [4:0]  NumShift
);


enum logic [3:0] {
            WAIT_ENABLE,
            COEFF_TOKEN_0,
            COEFF_TOKEN_1,
            LEVEL_DECODE,
            XX
            } CurrentState, NextState;


always_ff @(posedge Clk or negedge nReset)
  if (!nReset) CurrentState <= WAIT_ENABLE;
  else CurrentState <= NextState;


always_comb begin
  NextState = XX;
  unique case (CurrentState)
    WAIT_ENABLE : if (Enable & BarrelShifterReady) NextState = COEFF_TOKEN_0;
                  else NextState = WAIT_ENABLE;
    COEFF_TOKEN_0 : NextState = COEFF_TOKEN_1;
    COEFF_TOKEN_1 : NextState = LEVEL_DECODE;
    LEVEL_DECODE : NextState = LEVEL_DECODE;
    XX : NextState = WAIT_ENABLE;
  endcase
end


always_ff @(posedge Clk or negedge nReset)
  if (!nReset) begin
    ShiftEn <= '0;
    NumShift <= '0;
  end
  else begin
    case (CurrentState)
      COEFF_TOKEN_1 : begin
        ShiftEn <= '1;
        NumShift <= NumShift_CoeffTokenDecode;
      end
      default : begin
        ShiftEn <= '0;
        NumShift <= '0;
      end
    endcase
  end

endmodule