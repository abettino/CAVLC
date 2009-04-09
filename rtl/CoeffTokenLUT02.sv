module CoeffTokenLUT02(
                       input logic [15:0] Bits,
                       output logic [4:0] TotalCoeff, 
                       output logic [1:0] TrailingOnes, 
                       output logic [4:0] NumShift
                       );


logic [3:0]                             LeadingZeroes;

logic                                   LeadingZ16;

logic [4:0]                             TotalCoeff16,TotalCoeff15,TotalCoeff14,TotalCoeff13,
                                        TotalCoeff11,TotalCoeff10,TotalCoeff9,
                                        TotalCoeff8,TotalCoeff7,TotalCoeff6,TotalCoeff321;


logic [4:0]                             NumShift16,NumShift15,NumShift14,NumShift13,
                                        NumShift11,NumShift10,NumShift9,
                                        NumShift8,NumShift7,NumShift6,NumShift321;


logic [1:0]                             TrailingOnes16,TrailingOnes15,TrailingOnes14,TrailingOnes13,
                                        TrailingOnes11,TrailingOnes10,TrailingOnes9,
                                        TrailingOnes8,TrailingOnes7,TrailingOnes6,TrailingOnes321;

assign LeadingZ16 = ~|Bits[15:4] & |Bits[3:2];
assign LeadingZ15 = ~|Bits[15:5];
assign LeadingZ14 = ~|Bits[15:6];
assign LeadingZ13 = ~|Bits[15:7];
assign LeadingZ11 = ~|Bits[15:8];
assign LeadingZ10 = ~|Bits[15:9];
assign LeadingZ09 = ~|Bits[15:10];
assign LeadingZ08 = ~|Bits[15:11];
assign LeadingZ07 = ~|Bits[15:12] & !Bits[10];
assign LeadingZ06 = ~|Bits[15:13];


always_comb begin
  if (LeadingZ16) begin
    TotalCoeff = TotalCoeff16;
    TrailingOnes = TrailingOnes16;
    NumShift = 5'd16;
  end
  else if (LeadingZ15) begin
    TotalCoeff = TotalCoeff15;
    TrailingOnes = TrailingOnes15;
    NumShift = 5'd15;
  end
  else if (LeadingZ14) begin
    TotalCoeff = TotalCoeff14;
    TrailingOnes = TrailingOnes14;
    NumShift = 5'd14;
  end
  else if (LeadingZ13) begin
    TotalCoeff = TotalCoeff13;
    TrailingOnes = TrailingOnes13;
    NumShift = 5'd13;
  end
  else if (LeadingZ11) begin
    TotalCoeff = TotalCoeff11;
    TrailingOnes = TrailingOnes11;
    NumShift = 5'd11;
  end
  else if (LeadingZ10) begin
    TotalCoeff = TotalCoeff10;
    TrailingOnes = TrailingOnes10;
    NumShift = 5'd10;
  end
  else if (LeadingZ09) begin
    TotalCoeff = TotalCoeff9;
    TrailingOnes = TrailingOnes9;
    NumShift = 5'd9;
  end
  else if (LeadingZ08) begin
    TotalCoeff = TotalCoeff8;
    TrailingOnes = TrailingOnes8;
    NumShift = 5'd8;
  end
  else if (LeadingZ07) begin
    TotalCoeff = TotalCoeff7;
    TrailingOnes = TrailingOnes7;
    NumShift = 5'd7;
  end
  else if (LeadingZ06) begin
    TotalCoeff = TotalCoeff6;
    TrailingOnes = TrailingOnes6;
    NumShift = NumShift6;
  end
  else begin
    TotalCoeff = TotalCoeff321;
    TrailingOnes = TrailingOnes321;
    NumShift = NumShift321;
  end
end


CoeffTokenLUT02_16 uCoeffTokenLUT02_16 (
                           .Bits(Bits[3:0]),
                           .TotalCoeff(TotalCoeff16), 
                           .TrailingOnes(TrailingOnes16) 
                           );

CoeffTokenLUT02_15 uCoeffTokenLUT02_15 (
                           .Bits(Bits[4:1]),
                           .TotalCoeff(TotalCoeff15), 
                           .TrailingOnes(TrailingOnes15) 
                           );


CoeffTokenLUT02_14 uCoeffTokenLUT02_14 (
                           .Bits(Bits[5:2]),
                           .TotalCoeff(TotalCoeff14), 
                           .TrailingOnes(TrailingOnes14) 
                           );

CoeffTokenLUT02_13 uCoeffTokenLUT02_13 (
                           .Bits(Bits[6:3]),
                           .TotalCoeff(TotalCoeff13), 
                           .TrailingOnes(TrailingOnes13) 
                           );


CoeffTokenLUT02_11 uCoeffTokenLUT02_11 (
                           .Bits(Bits[7:5]),
                           .TotalCoeff(TotalCoeff11), 
                           .TrailingOnes(TrailingOnes11) 
                           );


CoeffTokenLUT02_10 uCoeffTokenLUT02_10 (
                           .Bits(Bits[8:6]),
                           .TotalCoeff(TotalCoeff10), 
                           .TrailingOnes(TrailingOnes10) 
                           );


CoeffTokenLUT02_9 uCoeffTokenLUT02_9 (
                           .Bits(Bits[9:7]),
                           .TotalCoeff(TotalCoeff9), 
                           .TrailingOnes(TrailingOnes9) 
                           );


CoeffTokenLUT02_8 uCoeffTokenLUT02_8 (
                           .Bits(Bits[10:8]),
                           .TotalCoeff(TotalCoeff8), 
                           .TrailingOnes(TrailingOnes8) 
                           );

CoeffTokenLUT02_7 uCoeffTokenLUT02_7 (
                           .Bits(Bits[11:9]),
                           .TotalCoeff(TotalCoeff7), 
                           .TrailingOnes(TrailingOnes7) 
                           );

// actually 5 and 6
CoeffTokenLUT02_6 uCoeffTokenLUT02_6 (
                           .Bits(Bits[12:10]),
                           .TotalCoeff(TotalCoeff6), 
                           .TrailingOnes(TrailingOnes6), 
                           .NumShift(NumShift6)
                           );


CoeffTokenLUT02_321 uCoeffTokenLUT02_321 (
                           .Bits(Bits[15:13]),
                           .TotalCoeff(TotalCoeff321), 
                           .TrailingOnes(TrailingOnes321), 
                           .NumShift(NumShift321)
                           );

endmodule