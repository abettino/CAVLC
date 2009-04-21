module CoeffTokenLUT02StagesTop (
                                 input [15:0] Data,
                                 input Clk,
                                 input nReset,
                                 input Enable,
                                 output reg [4:0] TotalCoeff, 
                                 output reg [1:0] TrailingOnes,
                                 output reg [4:0] NumShift,
                                 output reg Done                          
                                 );

wire [4:0]                                   TotalCoeffStage1,TotalCoeffStage2,TotalCoeffStage3,TotalCoeffStage4;
wire [1:0]                                   TrailingOnesStage1,TrailingOnesStage2,TrailingOnesStage3,TrailingOnesStage4;
wire [4:0]                                   NumShiftStage1,NumShiftStage2,NumShiftStage3,NumShiftStage4;
wire                                         MatchStage1,MatchStage2,MatchStage3,MatchStage4;


reg [1:0]                                    StageCnt;
reg                                          Matched;

always @(posedge Clk or negedge nReset) begin
  if (!nReset) begin
    StageCnt <= 2'b0;
    Matched <= 1'b0;
  end
  else begin
    if (!Enable) begin 
      StageCnt <= 2'b0;
      Done <= 1'b0;
      Matched <= 1'b0;
    end
    else if (Enable & !Matched) begin 

      StageCnt <= StageCnt + 1;

      case (StageCnt)
        0 : begin
          if (MatchStage1) begin
            Matched <= 1'b1;
            TotalCoeff <= TotalCoeffStage1;
            TrailingOnes <= TrailingOnesStage1;
            NumShift <= NumShiftStage1;
            Done <= 1'b1;
          end
        end
        1 : begin
          if (MatchStage2) begin
            Matched <= 1'b1;
            TotalCoeff <= TotalCoeffStage2;
            TrailingOnes <= TrailingOnesStage2;
            NumShift <= NumShiftStage2;
            Done <= 1'b1;
          end
        end
        2 : begin
          if (MatchStage3) begin
            Matched <= 1'b1;
            TotalCoeff <= TotalCoeffStage3;
            TrailingOnes <= TrailingOnesStage3;
            NumShift <= NumShiftStage3;
            Done <= 1'b1;
          end
        end
        3 : begin
          if (MatchStage4) begin
            Matched <= 1'b1;
            TotalCoeff <= TotalCoeffStage4;
            TrailingOnes <= TrailingOnesStage4;
            NumShift <= NumShiftStage4;
            Done <= 1'b1;
          end
        end
      endcase
    end
  end
end

LUT02Stage1 LUT02Stage1 (.Address(Data[15:10]), .TotalCoeff(TotalCoeffStage1), .TrailingOnes(TrailingOnesStage1), .NumShift(NumShiftStage1),.Match(MatchStage1));
LUT02Stage2 LUT02Stage2 (.Address(Data[11:6]),.TotalCoeff(TotalCoeffStage2), .TrailingOnes(TrailingOnesStage2),.NumShift(NumShiftStage2), .Match(MatchStage2));
LUT02Stage3 LUT02Stage3 (.Address(Data[7:1]),.TotalCoeff(TotalCoeffStage3), .TrailingOnes(TrailingOnesStage3),.NumShift(NumShiftStage3), .Match(MatchStage3));
LUT02Stage4 LUT02Stage4 (.Address(Data[3:0]),.TotalCoeff(TotalCoeffStage4), .TrailingOnes(TrailingOnesStage4), .NumShift(NumShiftStage4),.Match(MatchStage4));

endmodule