module CTRLFSM (
                input  logic        Clk,              // Clock.
                input  logic        nReset,           // Async reset.           
                input  logic        Enable,
                input  logic        BarrelShifterReady,
                input  logic  [4:0] NumShift_CoeffTokenDecode,
                input  logic  [4:0] NumShift_LevelDecode,
                input  logic        ShiftEn_LevelDecode,
                input  logic        LevelDecodeDone,
                output logic        ShiftEn,
                output logic  [4:0] NumShift,
                output logic        CoeffTokenDecodeEnable,
                output logic        LevelDecodeEnable
);


enum logic [3:0] {
            WAIT_ENABLE,
            COEFF_TOKEN_0,
            COEFF_TOKEN_1,
            LEVEL_DECODE,
            ZERO_DECODE,  
            XX
            } CurrentState, NextState;


always_ff @(posedge Clk or negedge nReset)
  if (!nReset) CurrentState <= WAIT_ENABLE;
  else         CurrentState <= NextState;


always_comb begin
  NextState = XX;
  unique case (CurrentState)
    WAIT_ENABLE   : if (Enable & BarrelShifterReady) NextState = COEFF_TOKEN_0;
                    else                             NextState = WAIT_ENABLE;
    COEFF_TOKEN_0 : NextState = COEFF_TOKEN_1;
    COEFF_TOKEN_1 : NextState = LEVEL_DECODE;
    LEVEL_DECODE  : if (LevelDecodeDone) NextState = ZERO_DECODE;
                    else NextState = LEVEL_DECODE;
    ZERO_DECODE   : NextState = ZERO_DECODE;
    XX            : NextState = WAIT_ENABLE;
  endcase
end


always_comb begin
  case (CurrentState)
    COEFF_TOKEN_1 : begin 
      ShiftEn  = '1;
      NumShift = NumShift_CoeffTokenDecode;
    end
    LEVEL_DECODE :  begin
      ShiftEn  = ShiftEn_LevelDecode;
      NumShift = NumShift_LevelDecode;
    end
    default : begin
      ShiftEn  = '0;
      NumShift = '0;
    end
  endcase
end

always_ff @(posedge Clk or negedge nReset)
  if (!nReset) begin
    CoeffTokenDecodeEnable <= '0;
    LevelDecodeEnable      <= '0;
  end
  else begin
    CoeffTokenDecodeEnable <= (CurrentState==COEFF_TOKEN_0);
    LevelDecodeEnable <= (CurrentState==LEVEL_DECODE);
  end

endmodule