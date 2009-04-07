module CoeffTokenROMNeg2 (input [15:0] Address, output reg [4:0] TotalCoeff, output reg [1:0] TrailingOnes, output reg [4:0] NumShift);
always @* begin
if (Address[15:15]==1'b1) begin
  TotalCoeff = 5'd0;
  TrailingOnes = 2'd0;
  NumShift = 5'd1;
end
else if (Address[15:9]==7'b0001111) begin
  TotalCoeff = 5'd1;
  TrailingOnes = 2'd0;
  NumShift = 5'd7;
end
else if (Address[15:14]==2'b01) begin
  TotalCoeff = 5'd1;
  TrailingOnes = 2'd1;
  NumShift = 5'd2;
end
else if (Address[15:9]==7'b0001110) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd0;
  NumShift = 5'd7;
end
else if (Address[15:9]==7'b0001101) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd1;
  NumShift = 5'd7;
end
else if (Address[15:13]==3'b001) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd2;
  NumShift = 5'd3;
end
else if (Address[15:7]==9'b000000111) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd0;
  NumShift = 5'd9;
end
else if (Address[15:9]==7'b0001100) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd1;
  NumShift = 5'd7;
end
else if (Address[15:9]==7'b0001011) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd2;
  NumShift = 5'd7;
end
else if (Address[15:11]==5'b00001) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd3;
  NumShift = 5'd5;
end
else if (Address[15:7]==9'b000000110) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd0;
  NumShift = 5'd9;
end
else if (Address[15:7]==9'b000000101) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd1;
  NumShift = 5'd9;
end
else if (Address[15:9]==7'b0001010) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd2;
  NumShift = 5'd7;
end
else if (Address[15:10]==6'b000001) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:6]==10'b0000000111) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd0;
  NumShift = 5'd10;
end
else if (Address[15:6]==10'b0000000110) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd1;
  NumShift = 5'd10;
end
else if (Address[15:7]==9'b000000100) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd2;
  NumShift = 5'd9;
end
else if (Address[15:9]==7'b0001001) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd3;
  NumShift = 5'd7;
end
else if (Address[15:5]==11'b00000000111) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd0;
  NumShift = 5'd11;
end
else if (Address[15:5]==11'b00000000110) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd1;
  NumShift = 5'd11;
end
else if (Address[15:6]==10'b0000000101) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd2;
  NumShift = 5'd10;
end
else if (Address[15:9]==7'b0001000) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd3;
  NumShift = 5'd7;
end
else if (Address[15:4]==12'b000000000111) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd0;
  NumShift = 5'd12;
end
else if (Address[15:4]==12'b000000000110) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd1;
  NumShift = 5'd12;
end
else if (Address[15:5]==11'b00000000101) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd2;
  NumShift = 5'd11;
end
else if (Address[15:6]==10'b0000000100) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd3;
  NumShift = 5'd10;
end
else if (Address[15:3]==13'b0000000000111) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd0;
  NumShift = 5'd13;
end
else if (Address[15:4]==12'b000000000101) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd1;
  NumShift = 5'd12;
end
else if (Address[15:4]==12'b000000000100) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd2;
  NumShift = 5'd12;
end
else if (Address[15:5]==11'b00000000100) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd3;
  NumShift = 5'd11;
end
else begin
  TotalCoeff=5'd31;
  TrailingOnes=2'd0;
  NumShift=5'd0;

end
end
endmodule
