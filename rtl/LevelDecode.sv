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

logic                            Level1Thresh,Level2Thresh,Level3Thresh;
logic                            PrevT1Mode;

logic                            ShiftEnState;

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

assign Level1Thresh = (OnePos > 2) || (OnePos==2 && PrevT1Mode);
//assign Level2Thresh = (OnePos == 2 && ExtraBit[4]) || OnePos > 2;
assign Level2Thresh = OnePos > 2;
//assign Level3Thresh = (OnePos == 2 && ExtraBit[4:3]) || OnePos > 2;
assign Level3Thresh = OnePos > 2;

always_ff @(posedge Clk or negedge nReset)
  if (!nReset) begin
    SuffixLength <= '0;
    PrevT1Mode <= '0;
  end
  else begin
    PrevT1Mode <= |TrailingOnesLeft;
    if (Enable & TrailingOnesLeft==0) begin
      if (!StallPipeLine) begin
        case (SuffixLength)
          0 : if ((OnePos > 5 || (OnePos > 3 && TrailingOnes < 3)) | Stalled) SuffixLength <= 3'd2;
              else SuffixLength <= 3'd1;
          1 : if (Level1Thresh) SuffixLength <= 3'd2;
          2 : if (Level2Thresh)  SuffixLength <= 3'd3;
          3 : if (Level3Thresh)  SuffixLength <= 3'd4;
          4 :  SuffixLength <= 4'd4;
          //        4 : if (CodeNum >= 24) SuffixLength <= 3'd5;
          //        5 : if (CodeNum >= 48) SuffixLength <= 3'd6;
        endcase
      end
    end
    else begin
      if (TotalCoeff > 10 && TrailingOnes < 3)  SuffixLength <= 1;
      else SuffixLength <= '0;
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
/*
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
 */
   if (!Stalled && (OnePos == 'hE || OnePos == 'hF) && TrailingOnesLeft==0) StallPipeLine = '1;
   else StallPipeLine = '0;
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
            if (!Stalled) begin
              if (OnePos <= 13) CodeNum <= OnePos;
              else if (OnePos > 13 && OnePos <= 29) CodeNum <= 14+BitstreamShifted[15:13];
            end
            else begin
              if (PrevOnePos=='hE) CodeNum <= 'd14+BitstreamShifted[15:12];
              else if (PrevOnePos=='hF) CodeNum <= 'd30+BitstreamShifted[15:4];
            end
            LPUTrig <= !StallPipeLine;
          end
          1 : begin
            if (!Stalled) CodeNum <= {OnePos,1'b0}+ExtraBit[4];
            else if (PrevOnePos=='hE) CodeNum <= 'd28+BitstreamShifted[15];
            else if (PrevOnePos=='hF) CodeNum <= 'd30+BitstreamShifted[15:4];
            LPUTrig <= !StallPipeLine;
          end
          2 : begin
            if (!Stalled) CodeNum <= {OnePos,2'b0}+ExtraBit[4:3];
            else if (PrevOnePos=='hE) CodeNum <= 'd56+BitstreamShifted[15:14];
            else if (PrevOnePos=='hF) CodeNum <= 'd60+BitstreamShifted[15:4];
            LPUTrig <= !StallPipeLine;
          end
          3 : begin
            if (!Stalled)             CodeNum <= {OnePos,3'b0}+ExtraBit[4:2];
            else if (PrevOnePos=='hE) CodeNum <= 'd112+BitstreamShifted[15:13];
            else if (PrevOnePos=='hF) CodeNum <= 'd120+BitstreamShifted[15:4];
            LPUTrig <= !StallPipeLine;
          end
          4 : begin
            if (!Stalled) CodeNum <= {OnePos,4'b0} + ExtraBit[4:1];
            else if (PrevOnePos=='hE) CodeNum <= 'd224+BitstreamShifted[15:12];
            else if (PrevOnePos=='hF) CodeNum <= 'd120+BitstreamShifted[15:4];
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
assign ShiftEnState = Enable & !DoneInt;

always_comb begin
  case({ShiftEnState,|TrailingOnesLeft,StallPipeLine,Stalled})
    4'b1100 : begin //trailing ones.
      NumShift = 1;
      ShiftEn = '1;
    end
    4'b1010 : begin // stall pipeline.
      NumShift = OnePos + 1;
      ShiftEn = '1;
    end
    4'b1001 : begin // pipeline stalled.
      if (PrevOnePos == 'hE && SuffixLength!=0) NumShift=SuffixLength;
      else if (PrevOnePos == 'hE) NumShift = 'd4;
      else NumShift = 'd12;
      ShiftEn = '1;
    end
    4'b1000 : begin // standard.
      NumShift = SuffixLength+OnePos+1;
      ShiftEn = '1;
    end
    default : begin
      NumShift = '0;
      ShiftEn = '0;
    end
  endcase
end


// always_comb begin
//   if (Enable & !DoneInt) begin
//     if (|TrailingOnesLeft) begin
//       NumShift = 1;
//       ShiftEn = '1;
//     end
//     else begin
//       if (StallPipeLine) begin
//         NumShift = OnePos + 1;
//         ShiftEn = '1;
//       end
//       else if (Stalled) begin
//         if (PrevOnePos=='hE) begin
//           NumShift=SuffixLength;
//           ShiftEn = '1;
//         end
//         else begin
//           NumShift = 'd12;
//           ShiftEn = '1;
//         end
//       end
//       else begin
//         NumShift = SuffixLength+OnePos+1;
//         ShiftEn = '1;
// /*        case (SuffixLength)
//           0 : begin 
//             NumShift = OnePos + 1;
//             ShiftEn = '1;
//           end
//           1 : begin
//             NumShift = OnePos + 2;
//             ShiftEn = '1;
//           end
//           2 : begin
//             NumShift = OnePos + 3;
//             ShiftEn = '1;
//           end
//           3 : begin
//             NumShift = OnePos + 4;
//             ShiftEn = '1;
//           end
//           4 : begin
//             NumShift = OnePos + 5;
//             ShiftEn = '1;
//           end
//           default : begin
//             NumShift = '0;
//             ShiftEn = '0;
//           end
//       endcase
// */
//       end
//     end
//   end
//   else begin
//     NumShift = '0;
//     ShiftEn = '0;
//   end
// end

// Level Process Unit. Convert CodeNum to LevelOut.
LevelProcessingUnit uLevelProcessingUnit (
  .Clk          (Clk), 
  .nReset       (nReset), 
  .Enable       (Enable),                                         
  .TrailingOnes (TrailingOnes),
  .TotalCoeff   (TotalCoeff),
  .TrailingOneMode (TrailingOneMode),
  .SuffixLength (SuffixLengthLPU),
  .LPUTrig      (LPUTrig),
  .CodeNum      (CodeNum),
  .LevelOut     (LevelOut),
  .WrReq        (WrReq)                                   
);

endmodule