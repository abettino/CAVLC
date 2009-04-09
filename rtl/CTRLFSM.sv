////////////////////////////////////////////////////////////////////////////////
//  File : CTRLFSM.sv
//  Desc : Control state machine. 
//   
////////////////////////////////////////////////////////////////////////////////
module CTRLFSM (
   input  logic        Clk,                      // Clock.
   input  logic        nReset,                   // Async reset.           
   input  logic        Enable,                   // Enable from external ctrl.
   input  logic        BarrelShifterReady,       // Barrel shifter has data.
   input  logic  [4:0] TotalCoeff,               // From CoeffTokenDecode.
   input  logic  [4:0] NumShift_CoeffTokenDecode,// Shift number. 
   input  logic  [4:0] NumShift_LevelDecode,     // Shift from LevelDecode.
   input  logic        ShiftEn_LevelDecode,      // ShiftEn from Level Decode.
   input  logic [4:0]  NumShift_ZeroDecode,      // Shift number.  
   input  logic        ShiftEn_ZeroDecode,       // ShiftEn from Zero decode. 
   input  logic        LevelDecodeDone,          // Indicates LevelDecode complete.
   input  logic        ZeroDecodeDone,           // Inidcates ZeroDecode complete.
   output logic        ShiftEn,                  // Control to Barrel Shifter
   output logic  [4:0] NumShift,                 // NumShift to barrel shifter.
   output logic        CoeffTokenDecodeEnable,   // Control to CoeffTokenDecode.
   output logic        LevelDecodeEnable,        // Control to LevelDecode.
   output logic        ZeroDecodeEnable,         // Control to ZeroDecode.
   output logic        BlockDone,                // Output status to ext. control.
   output logic        BarrelShiftEn
);
// 
logic                  DisableReg;

////////////////////////////////////////////////////////////////////////////////
// State machine.
////////////////////////////////////////////////////////////////////////////////
// State Encodings
enum logic [3:0] {
            WAIT_ENABLE,
            WAIT_B_SHIFTER,          
            COEFF_TOKEN_0,
            COEFF_TOKEN_1,
            LEVEL_DECODE,
            ZERO_DECODE,  
            CHECK_ENABLE,
            XX
            } CurrentState, NextState;
// Sync. logic.
always_ff @(posedge Clk or negedge nReset)
  if (!nReset) CurrentState <= WAIT_ENABLE;
  else         CurrentState <= NextState;
// Next State comb logic.
always_comb begin
  NextState = XX;
  unique case (CurrentState)
    WAIT_ENABLE   : if (Enable)                      NextState = WAIT_B_SHIFTER;
                    else                             NextState = WAIT_ENABLE;
    WAIT_B_SHIFTER : if (BarrelShifterReady)         NextState = COEFF_TOKEN_0;
                     else                            NextState = WAIT_B_SHIFTER;
    COEFF_TOKEN_0 ://  if (Enable)                     NextState = COEFF_TOKEN_1;
//                     else                            NextState = WAIT_ENABLE;
      NextState = COEFF_TOKEN_1;
    COEFF_TOKEN_1 :                                  NextState = LEVEL_DECODE;
    LEVEL_DECODE  : if (LevelDecodeDone)             NextState = ZERO_DECODE;
                    else                             NextState = LEVEL_DECODE;
    ZERO_DECODE   : if (!ZeroDecodeDone)             NextState = ZERO_DECODE;
//                    else if (!Enable)                NextState = WAIT_ENABLE;
//                    else                             NextState = COEFF_TOKEN_0;
    else NextState = WAIT_ENABLE;
    CHECK_ENABLE  : if (!Enable) NextState = WAIT_ENABLE;
    else NextState = COEFF_TOKEN_0;
    XX            :                                  NextState = WAIT_ENABLE;
    default       :                                  NextState = WAIT_ENABLE;
  endcase
end
////////////////////////////////////////////////////////////////////////////////
// Shift Enable and Number shift mux.
// this mux selects which modules is controlling the barrel shifter based
// on the current state.
////////////////////////////////////////////////////////////////////////////////
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
    ZERO_DECODE : begin
      ShiftEn = ShiftEn_ZeroDecode;
      NumShift = NumShift_ZeroDecode;
    end
    default : begin
      ShiftEn  = '0;
      NumShift = '0;
    end
  endcase
end
////////////////////////////////////////////////////////////////////////////////
// Sync output control and individual module enable signals.
////////////////////////////////////////////////////////////////////////////////
always_ff @(posedge Clk or negedge nReset)
  if (!nReset) begin
    CoeffTokenDecodeEnable <= '0;
    LevelDecodeEnable      <= '0;
    ZeroDecodeEnable       <= '0;
    BlockDone              <= '0;
    BarrelShiftEn          <= '0;
  end
  else begin
    CoeffTokenDecodeEnable <= (CurrentState==COEFF_TOKEN_0);
    LevelDecodeEnable      <= (CurrentState==LEVEL_DECODE);
    ZeroDecodeEnable       <= (CurrentState==ZERO_DECODE);
//    if (CurrentState == WAIT_ENABLE) BarrelShiftEn <= '0;
//    else BarrelShiftEn <= '1;
    BarrelShiftEn <= !((CurrentState == WAIT_ENABLE) & !Enable);
    BlockDone              <= ((CurrentState==ZERO_DECODE) && ZeroDecodeDone);  
  end

////////////////////////////////////////////////////////////////////////////////
// disabl reg
always_ff @(posedge Clk or negedge nReset)
  if (!nReset) DisableReg <= '0;
  else if (CurrentState == WAIT_ENABLE) DisableReg <= '0;
//  else if (!Enable) DisableReg <= '1;

endmodule