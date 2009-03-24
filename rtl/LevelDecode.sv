////////////////////////////////////////////////////////////////////////////////
//  File : LevelDecode.sv
//  Desc : Level Decode.
//   
////////////////////////////////////////////////////////////////////////////////
module LevelDecode (
  input  logic        Clk,              // clock.
  input  logic        nReset,           // reset.
  input  logic        Enable,           // enable.
  input  logic [15:0] BitstreamShifted, // shifted bitstream.
  input  logic  [4:0] TotalCoeff,       // From CoeffTokenDecode.
  input  logic  [1:0] TrailingOnes,     // From CoeffTokenDecode.
  output logic  [4:0] NumShift,         // Control Barrelshifter.
  output logic        ShiftEn,          // Control Barrelshifter.
  output logic [12:0] LevelOut,         // Output level.
  output logic        WrReq,            // Output write request.
  output logic        Done              // Level Done.
);
// Declarations.
logic [2:0]                      SuffixLength;
logic [2:0]                      SuffixLengthLPU;
logic [13:0]                     LevelCode;
logic [13:0]                     CodeNum;

logic [3:0]                      OnePos,PrevOnePos;
logic                            LPUTrig;
logic [4:0]                      ExtraBit;
logic                            StallPipeLine,Stalled;

logic [4:0]                      CoeffCount;
logic                            DoneInt;

logic [1:0]                      TrailingOnesLeft;
logic                            TrailingOneMode;
logic                            OneCoeffDone;


// External Done signal.
assign Done = (TotalCoeff > 1) ? (CoeffCount == (TotalCoeff-1)) && !StallPipeLine : DoneInt;
// Internal done signal.
assign DoneInt = (CoeffCount >= TotalCoeff);
// Count coefficients while processing.
always_ff @(posedge Clk or negedge nReset)
  if (!nReset) CoeffCount <= '0;
  else if (!Enable) CoeffCount <= '0;
  else if (Enable & !StallPipeLine) CoeffCount <= CoeffCount + 1;
////////////////////////////////////////////////////////////////////////////////
// Suffix Length control. Implemenation of the suffix rule.
// current suffix length    level threshold
//-----------------------------------------
//      0                     0
//      1                     3
//      2                     6
//      3                     12
//      4                     24
//      5                     48
//      6                     n/a
always_ff @(posedge Clk or negedge nReset)
  if (!nReset) begin
    SuffixLength <= '0;
  end
  else begin
    if (Enable & TrailingOnesLeft==0) begin
      case (SuffixLength)
        0 : SuffixLength <= 3'd1;
        1 : if (OnePos > 2) SuffixLength <= 3'd2;
        2 :  SuffixLength <= 3'd2;
//        3 : if () SuffixLength <= 3'd4;
//        4 : if (CodeNum >= 24) SuffixLength <= 3'd5;
//        5 : if (CodeNum >= 48) SuffixLength <= 3'd6;
      endcase
    end
    else begin
      SuffixLength <= '0;
    end
  end
////////////////////////////////////////////////////////////////////////////////
// one finder.
OneFinder uOneFinder (
  .BitstreamShifted(BitstreamShifted),
  .OnePos(OnePos),
  .ExtraBit(ExtraBit)
);
// Condition to stall the pipeline when the prefix length
// gets very large.
always_comb begin 
  case(SuffixLength)
    0 : begin
      StallPipeLine = '0;      
    end
    1 : begin
      StallPipeLine = '0;
    end
    2 : begin
      if (OnePos == 'hE || OnePos == 'hF) StallPipeLine = '1;
      else StallPipeLine = '0;
    end
    default : begin
      StallPipeLine = '0;
    end
  endcase
end
// Calculate the code number based on current suffix length
// and the one position.
always_ff @(posedge Clk or negedge nReset)
  if (!nReset) begin
    LevelCode <= '0;
    CodeNum  <= '0;
    LPUTrig <= '0;
    SuffixLengthLPU <= '0;
    Stalled <= '0;
    PrevOnePos <= '0;
    TrailingOnesLeft <= '0;
    TrailingOneMode <= '0;
    OneCoeffDone <= '0;
  end
  else begin
    if (!Enable) OneCoeffDone <= 1'b0;
    else if (ShiftEn && TotalCoeff==1) OneCoeffDone <= 1'b1;
    
    if (Enable & !DoneInt) begin
      if (|TrailingOnesLeft) TrailingOnesLeft <= TrailingOnesLeft - 1;
      TrailingOneMode <= |TrailingOnesLeft;
      
      SuffixLengthLPU <= SuffixLength;
      if (StallPipeLine) PrevOnePos <= OnePos;

      if (StallPipeLine) Stalled <= '1;
      else Stalled <= '0;
      
      if (TrailingOnesLeft) begin
        CodeNum <= {13'b0,BitstreamShifted[15]};
        LPUTrig <= '1;
      end
      else begin
      case (SuffixLength)
        0 : begin
          if (OnePos <= 13) CodeNum <= OnePos;
          else if (OnePos > 13 && OnePos <= 29) CodeNum <= 14+BitstreamShifted[16:13];
          LPUTrig <= !StallPipeLine;
        end
        1 : begin
          CodeNum <= {OnePos,1'b0}+ExtraBit[4];
          LPUTrig <= !StallPipeLine;
        end
        2 : begin
          if (!Stalled) CodeNum <= {OnePos,2'b0}+ExtraBit[4:3];
          else if (PrevOnePos=='hE) CodeNum <= 'd56+BitstreamShifted[15:14];
          else if (PrevOnePos=='hF) CodeNum <= 'd60+BitstreamShifted[15:4];
          
          LPUTrig <= !StallPipeLine;
        end
        default : begin
          LPUTrig <= '0;
        end
      endcase
      end
    end
    else begin
      LPUTrig <= '0;
      TrailingOnesLeft <= TrailingOnes;
    end
  end

// Num shift logic.
always_comb begin
  if (Enable & !DoneInt) begin
    if (|TrailingOnesLeft) begin
      NumShift = 1;
      ShiftEn = '1;
    end
    else begin
      case (SuffixLength)
        0 : begin 
          NumShift = OnePos + 1;
          ShiftEn = '1;
        end
        1 : begin
          NumShift = OnePos + 2;
          ShiftEn = '1;
        end
        2 : begin
          case ({StallPipeLine,Stalled})
            2'b00 : NumShift = OnePos + 3;
            2'b10 : NumShift = OnePos + 1;
            2'b11 : NumShift = OnePos + 1;
            2'b01 : NumShift = (PrevOnePos=='hE) ? 'd2 : 'd12;
          endcase
          ShiftEn = '1;
        end
        default : begin
          NumShift = '0;
          ShiftEn = '0;
        end
      endcase
    end
  end
  else begin
    NumShift = '0;
    ShiftEn = '0;
  end
end

// Level Process Unit. Convert CodeNum to LevelOut.
LevelProcessingUnit uLevelProcessingUnit (
  .Clk          (Clk), 
  .nReset       (nReset), 
  .TrailingOnes (TrailingOnes),
  .TrailingOneMode (TrailingOneMode),
  .SuffixLength (SuffixLengthLPU),
  .LPUTrig      (LPUTrig),
  .CodeNum      (CodeNum),
  .LevelOut     (LevelOut),
  .WrReq        (WrReq)                                   
);

endmodule