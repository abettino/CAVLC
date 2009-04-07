module CoeffTokenROM24 (input [15:0] Address, output reg [4:0] TotalCoeff, output reg [1:0] TrailingOnes, output reg [4:0] NumShift);
always @* begin
if (Address[15:14]==2'b11) begin
  TotalCoeff = 5'd0;
  TrailingOnes = 2'd0;
  NumShift = 5'd2;
end
else if (Address[15:10]==6'b001011) begin
  TotalCoeff = 5'd1;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:14]==2'b10) begin
  TotalCoeff = 5'd1;
  TrailingOnes = 2'd1;
  NumShift = 5'd2;
end
else if (Address[15:10]==6'b000111) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:11]==5'b00111) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd1;
  NumShift = 5'd5;
end
else if (Address[15:13]==3'b011) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd2;
  NumShift = 5'd3;
end
else if (Address[15:9]==7'b0000111) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd0;
  NumShift = 5'd7;
end
else if (Address[15:10]==6'b001010) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b001001) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:12]==4'b0101) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd3;
  NumShift = 5'd4;
end
else if (Address[15:8]==8'b00000111) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd0;
  NumShift = 5'd8;
end
else if (Address[15:10]==6'b000110) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b000101) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:12]==4'b0100) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd3;
  NumShift = 5'd4;
end
else if (Address[15:8]==8'b00000100) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd0;
  NumShift = 5'd8;
end
else if (Address[15:9]==7'b0000110) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd1;
  NumShift = 5'd7;
end
else if (Address[15:9]==7'b0000101) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd2;
  NumShift = 5'd7;
end
else if (Address[15:11]==5'b00110) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd3;
  NumShift = 5'd5;
end
else if (Address[15:7]==9'b000000111) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd0;
  NumShift = 5'd9;
end
else if (Address[15:8]==8'b00000110) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd1;
  NumShift = 5'd8;
end
else if (Address[15:8]==8'b00000101) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd2;
  NumShift = 5'd8;
end
else if (Address[15:10]==6'b001000) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:5]==11'b00000001111) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd0;
  NumShift = 5'd11;
end
else if (Address[15:7]==9'b000000110) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd1;
  NumShift = 5'd9;
end
else if (Address[15:7]==9'b000000101) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd2;
  NumShift = 5'd9;
end
else if (Address[15:10]==6'b000100) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:5]==11'b00000001011) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd0;
  NumShift = 5'd11;
end
else if (Address[15:5]==11'b00000001110) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd1;
  NumShift = 5'd11;
end
else if (Address[15:5]==11'b00000001101) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd2;
  NumShift = 5'd11;
end
else if (Address[15:9]==7'b0000100) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd3;
  NumShift = 5'd7;
end
else if (Address[15:4]==12'b000000001111) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd0;
  NumShift = 5'd12;
end
else if (Address[15:5]==11'b00000001010) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd1;
  NumShift = 5'd11;
end
else if (Address[15:5]==11'b00000001001) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd2;
  NumShift = 5'd11;
end
else if (Address[15:7]==9'b000000100) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd3;
  NumShift = 5'd9;
end
else if (Address[15:4]==12'b000000001011) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd0;
  NumShift = 5'd12;
end
else if (Address[15:4]==12'b000000001110) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd1;
  NumShift = 5'd12;
end
else if (Address[15:4]==12'b000000001101) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd2;
  NumShift = 5'd12;
end
else if (Address[15:5]==11'b00000001100) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd3;
  NumShift = 5'd11;
end
else if (Address[15:4]==12'b000000001000) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd0;
  NumShift = 5'd12;
end
else if (Address[15:4]==12'b000000001010) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd1;
  NumShift = 5'd12;
end
else if (Address[15:4]==12'b000000001001) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd2;
  NumShift = 5'd12;
end
else if (Address[15:5]==11'b00000001000) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd3;
  NumShift = 5'd11;
end
else if (Address[15:3]==13'b0000000001111) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd0;
  NumShift = 5'd13;
end
else if (Address[15:3]==13'b0000000001110) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd1;
  NumShift = 5'd13;
end
else if (Address[15:3]==13'b0000000001101) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd2;
  NumShift = 5'd13;
end
else if (Address[15:4]==12'b000000001100) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd3;
  NumShift = 5'd12;
end
else if (Address[15:3]==13'b0000000001011) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd0;
  NumShift = 5'd13;
end
else if (Address[15:3]==13'b0000000001010) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd1;
  NumShift = 5'd13;
end
else if (Address[15:3]==13'b0000000001001) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd2;
  NumShift = 5'd13;
end
else if (Address[15:3]==13'b0000000001100) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd3;
  NumShift = 5'd13;
end
else if (Address[15:3]==13'b0000000000111) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd0;
  NumShift = 5'd13;
end
else if (Address[15:2]==14'b00000000001011) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd1;
  NumShift = 5'd14;
end
else if (Address[15:3]==13'b0000000000110) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd2;
  NumShift = 5'd13;
end
else if (Address[15:3]==13'b0000000001000) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd3;
  NumShift = 5'd13;
end
else if (Address[15:2]==14'b00000000001001) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd0;
  NumShift = 5'd14;
end
else if (Address[15:2]==14'b00000000001000) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd1;
  NumShift = 5'd14;
end
else if (Address[15:2]==14'b00000000001010) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd2;
  NumShift = 5'd14;
end
else if (Address[15:3]==13'b0000000000001) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd3;
  NumShift = 5'd13;
end
else if (Address[15:2]==14'b00000000000111) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd0;
  NumShift = 5'd14;
end
else if (Address[15:2]==14'b00000000000110) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd1;
  NumShift = 5'd14;
end
else if (Address[15:2]==14'b00000000000101) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd2;
  NumShift = 5'd14;
end
else if (Address[15:2]==14'b00000000000100) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd3;
  NumShift = 5'd14;
end
else begin
  TotalCoeff=5'd31;
  TrailingOnes=2'd0;
  NumShift=5'd0;

end
end
endmodule
