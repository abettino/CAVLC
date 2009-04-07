module CoeffTokenROM8 (input [15:0] Address, output reg [4:0] TotalCoeff, output reg [1:0] TrailingOnes, output reg [4:0] NumShift);
always @* begin
if (Address[15:10]==6'b000011) begin
  TotalCoeff = 5'd0;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b000000) begin
  TotalCoeff = 5'd1;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b000001) begin
  TotalCoeff = 5'd1;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b000100) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b000101) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b000110) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b001000) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b001001) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b001010) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b001011) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b001100) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b001101) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b001110) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b001111) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b010000) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b010001) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b010010) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b010011) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b010100) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b010101) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b010110) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b010111) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b011000) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b011001) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b011010) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b011011) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b011100) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b011101) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b011110) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b011111) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b100000) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b100001) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b100010) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b100011) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b100100) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b100101) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b100110) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b100111) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b101000) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b101001) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b101010) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b101011) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b101100) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b101101) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b101110) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b101111) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b110000) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b110001) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b110010) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b110011) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b110100) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b110101) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b110110) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b110111) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b111000) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b111001) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b111010) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b111011) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b111100) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b111101) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b111110) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b111111) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else begin
  TotalCoeff=5'd31;
  TrailingOnes=2'd0;
  NumShift=5'd0;

end
end
endmodule
