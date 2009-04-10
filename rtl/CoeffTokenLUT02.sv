module CoeffTokenLUT02(
                       input logic [15:0] Bits,
                       output logic [4:0] TotalCoeff, 
                       output logic [1:0] TrailingOnes, 
                       output logic [4:0] NumShift
                       );


logic [4:0]                             TotalCoeff00,TotalCoeff01,TotalCoeff02,TotalCoeff03,
                                        TotalCoeff04,TotalCoeff05,TotalCoeff06,TotalCoeff07,
                                        TotalCoeff08,TotalCoeff09,TotalCoeff10,TotalCoeff11,
                                        TotalCoeff12,TotalCoeff13,TotalCoeff14;

logic [1:0]                             TrailingOnes00,TrailingOnes01,TrailingOnes02,TrailingOnes03,
                                        TrailingOnes04,TrailingOnes05,TrailingOnes06,TrailingOnes07,
                                        TrailingOnes08,TrailingOnes09,TrailingOnes10,TrailingOnes11,
                                        TrailingOnes12,TrailingOnes13,TrailingOnes14;


logic [14:0]                            LeadingZeros;


always_comb begin 
  LeadingZeros[14] = ~|Bits[15:2];
  LeadingZeros[13] = ~|Bits[15:3];
  LeadingZeros[12] = ~|Bits[15:4];
  LeadingZeros[11] = ~|Bits[15:5];
  LeadingZeros[10] = ~|Bits[15:6];
  LeadingZeros[9] = ~|Bits[15:7];
  LeadingZeros[8] = ~|Bits[15:8];
  LeadingZeros[7] = ~|Bits[15:9];
  LeadingZeros[6] = ~|Bits[15:10];
  LeadingZeros[5] = ~|Bits[15:11];
  LeadingZeros[4] = ~|Bits[15:12];
  LeadingZeros[3] = ~|Bits[15:13];
  LeadingZeros[2] = ~|Bits[15:14];
  LeadingZeros[1] = ~|Bits[15:15];
  LeadingZeros[0] = Bits[15];
end



always_comb begin
  if (LeadingZeros[14]) begin
    NumShift = 15;
    TrailingOnes = TrailingOnes14;
    TotalCoeff = TotalCoeff14;
  end
  else if (LeadingZeros[13] | LeadingZeros[12]) begin
    NumShift = 16;
    if (LeadingZeros[13]) begin 
      TrailingOnes = TrailingOnes13;
      TotalCoeff = TotalCoeff13;
    end
    else begin
      TrailingOnes = TrailingOnes12;
      TotalCoeff = TotalCoeff12;
    end
  end
  else if (LeadingZeros[11]) begin
    NumShift = 15;
    TrailingOnes = TrailingOnes11;
    TotalCoeff = TotalCoeff11;
  end
  else if (LeadingZeros[10]) begin
    NumShift = 14;
    TrailingOnes = TrailingOnes10;
    TotalCoeff = TotalCoeff10;
  end
  else if (LeadingZeros[9]) begin
    NumShift = 13;
    TrailingOnes = TrailingOnes09;
    TotalCoeff = TotalCoeff09;
  end
  else if (LeadingZeros[8]) begin
    NumShift = 11;
    TrailingOnes = TrailingOnes08;
    TotalCoeff = TotalCoeff08;
  end
  else if (LeadingZeros[7]) begin
    NumShift = 10;
    TrailingOnes = TrailingOnes07;
    TotalCoeff = TotalCoeff07;
  end
  else if (LeadingZeros[6]) begin
    NumShift = 9;
    TrailingOnes = TrailingOnes06;
    TotalCoeff = TotalCoeff06;
  end
  else if (LeadingZeros[5]) begin
    NumShift = 8;
    TrailingOnes = TrailingOnes05;
    TotalCoeff = TotalCoeff05;  // 
  end
  else if (LeadingZeros[4]) begin
    if (Bits[10]) NumShift = 6;
    else NumShift = 7;
    TrailingOnes = TrailingOnes04;
    TotalCoeff = TotalCoeff04;
  end
  else if (LeadingZeros[3]) begin
    if (Bits[11]) NumShift = 5;
    else NumShift = 6;
    TrailingOnes = TrailingOnes03;
    TotalCoeff = TotalCoeff03;
  end
  else if (LeadingZeros[2]) begin
    NumShift = 3;
    TrailingOnes = TrailingOnes02;
    TotalCoeff = TotalCoeff02;
  end
  else if (LeadingZeros[1]) begin
    NumShift = 2;
    TrailingOnes = TrailingOnes01;
    TotalCoeff = TotalCoeff01;
  end
  else if (LeadingZeros[0]) begin
    NumShift = 1;
    TrailingOnes = TrailingOnes00;
    TotalCoeff = TotalCoeff00;
  end
  else begin
    NumShift = 1;
    TrailingOnes = TrailingOnes00;
    TotalCoeff = TotalCoeff00;
  end
end

CoeffTokenLUT02_14 uCoeffTokenLUT02_14 (
                           .Bits(2'b0),
                           .TotalCoeff(TotalCoeff14), 
                           .TrailingOnes(TrailingOnes14) 
                           );

CoeffTokenLUT02_13 uCoeffTokenLUT02_13 (
                           .Bits(Bits[1:0]),
                           .TotalCoeff(TotalCoeff13), 
                           .TrailingOnes(TrailingOnes13) 
                           );



CoeffTokenLUT02_12 uCoeffTokenLUT02_12 (
                           .Bits(Bits[2:0]),
                           .TotalCoeff(TotalCoeff12), 
                           .TrailingOnes(TrailingOnes12) 
                           );

CoeffTokenLUT02_11 uCoeffTokenLUT02_11 (
                           .Bits(Bits[3:1]),
                           .TotalCoeff(TotalCoeff11), 
                           .TrailingOnes(TrailingOnes11) 
                           );

CoeffTokenLUT02_10 uCoeffTokenLUT02_10 (
                           .Bits(Bits[4:2]),
                           .TotalCoeff(TotalCoeff10), 
                           .TrailingOnes(TrailingOnes10) 
                           );


CoeffTokenLUT02_09 uCoeffTokenLUT02_09 (
                           .Bits(Bits[5:3]),
                           .TotalCoeff(TotalCoeff09), 
                           .TrailingOnes(TrailingOnes09) 
                           );


CoeffTokenLUT02_08 uCoeffTokenLUT02_08 (
                           .Bits(Bits[6:5]),
                           .TotalCoeff(TotalCoeff08), 
                           .TrailingOnes(TrailingOnes08) 
                           );


CoeffTokenLUT02_07 uCoeffTokenLUT02_07 (
                           .Bits(Bits[7:6]),
                           .TotalCoeff(TotalCoeff07), 
                           .TrailingOnes(TrailingOnes07) 
                           );


CoeffTokenLUT02_06 uCoeffTokenLUT02_06 (
                           .Bits(Bits[8:7]),
                           .TotalCoeff(TotalCoeff06), 
                           .TrailingOnes(TrailingOnes06) 
                           );


CoeffTokenLUT02_05 uCoeffTokenLUT02_05 (
                           .Bits(Bits[9:8]),
                           .TotalCoeff(TotalCoeff05), 
                           .TrailingOnes(TrailingOnes05) 
                           );


CoeffTokenLUT02_04 uCoeffTokenLUT02_04 (
                           .Bits(Bits[10:9]),
                           .TotalCoeff(TotalCoeff04), 
                           .TrailingOnes(TrailingOnes04) 
                           );


CoeffTokenLUT02_03 uCoeffTokenLUT02_03 (
                           .Bits(Bits[11:10]),
                           .TotalCoeff(TotalCoeff03), 
                           .TrailingOnes(TrailingOnes03) 
                           );

CoeffTokenLUT02_02 uCoeffTokenLUT02_02 (
                           .Bits(0),
                           .TotalCoeff(TotalCoeff02), 
                           .TrailingOnes(TrailingOnes02) 
                           );

CoeffTokenLUT02_01 uCoeffTokenLUT02_01 (
                           .Bits(0),
                           .TotalCoeff(TotalCoeff01), 
                           .TrailingOnes(TrailingOnes01) 
                           );

CoeffTokenLUT02_00 uCoeffTokenLUT02_00 (
                           .Bits(0),
                           .TotalCoeff(TotalCoeff00), 
                           .TrailingOnes(TrailingOnes00) 
                           );


endmodule
