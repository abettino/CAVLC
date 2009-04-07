module CoeffTokenROM48 (input [15:0] Address, output reg [4:0] TotalCoeff, output reg [1:0] TrailingOnes, output reg [4:0] NumShift);
always @* begin
if (Address[15:12]==4'b1111) begin
  TotalCoeff = 5'd0;
  TrailingOnes = 2'd0;
  NumShift = 5'd4;
end
else if (Address[15:10]==6'b001111) begin
  TotalCoeff = 5'd1;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:12]==4'b1110) begin
  TotalCoeff = 5'd1;
  TrailingOnes = 2'd1;
  NumShift = 5'd4;
end
else if (Address[15:10]==6'b001011) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:11]==5'b01111) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd1;
  NumShift = 5'd5;
end
else if (Address[15:12]==4'b1101) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd2;
  NumShift = 5'd4;
end
else if (Address[15:10]==6'b001000) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:11]==5'b01100) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd1;
  NumShift = 5'd5;
end
else if (Address[15:11]==5'b01110) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd2;
  NumShift = 5'd5;
end
else if (Address[15:12]==4'b1100) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd3;
  NumShift = 5'd4;
end
else if (Address[15:9]==7'b0001111) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd0;
  NumShift = 5'd7;
end
else if (Address[15:11]==5'b01010) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd1;
  NumShift = 5'd5;
end
else if (Address[15:11]==5'b01011) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd2;
  NumShift = 5'd5;
end
else if (Address[15:12]==4'b1011) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd3;
  NumShift = 5'd4;
end
else if (Address[15:9]==7'b0001011) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd0;
  NumShift = 5'd7;
end
else if (Address[15:11]==5'b01000) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd1;
  NumShift = 5'd5;
end
else if (Address[15:11]==5'b01001) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd2;
  NumShift = 5'd5;
end
else if (Address[15:12]==4'b1010) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd3;
  NumShift = 5'd4;
end
else if (Address[15:9]==7'b0001001) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd0;
  NumShift = 5'd7;
end
else if (Address[15:10]==6'b001110) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b001101) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:12]==4'b1001) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd3;
  NumShift = 5'd4;
end
else if (Address[15:9]==7'b0001000) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd0;
  NumShift = 5'd7;
end
else if (Address[15:10]==6'b001010) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b001001) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd2;
  NumShift = 5'd6;
end
else if (Address[15:12]==4'b1000) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd3;
  NumShift = 5'd4;
end
else if (Address[15:8]==8'b00001111) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd0;
  NumShift = 5'd8;
end
else if (Address[15:9]==7'b0001110) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd1;
  NumShift = 5'd7;
end
else if (Address[15:9]==7'b0001101) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd2;
  NumShift = 5'd7;
end
else if (Address[15:11]==5'b01101) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd3;
  NumShift = 5'd5;
end
else if (Address[15:8]==8'b00001011) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd0;
  NumShift = 5'd8;
end
else if (Address[15:8]==8'b00001110) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd1;
  NumShift = 5'd8;
end
else if (Address[15:9]==7'b0001010) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd2;
  NumShift = 5'd7;
end
else if (Address[15:10]==6'b001100) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:7]==9'b000001111) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd0;
  NumShift = 5'd9;
end
else if (Address[15:8]==8'b00001010) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd1;
  NumShift = 5'd8;
end
else if (Address[15:8]==8'b00001101) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd2;
  NumShift = 5'd8;
end
else if (Address[15:9]==7'b0001100) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd3;
  NumShift = 5'd7;
end
else if (Address[15:7]==9'b000001011) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd0;
  NumShift = 5'd9;
end
else if (Address[15:7]==9'b000001110) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd1;
  NumShift = 5'd9;
end
else if (Address[15:8]==8'b00001001) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd2;
  NumShift = 5'd8;
end
else if (Address[15:8]==8'b00001100) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd3;
  NumShift = 5'd8;
end
else if (Address[15:7]==9'b000001000) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd0;
  NumShift = 5'd9;
end
else if (Address[15:7]==9'b000001010) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd1;
  NumShift = 5'd9;
end
else if (Address[15:7]==9'b000001101) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd2;
  NumShift = 5'd9;
end
else if (Address[15:8]==8'b00001000) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd3;
  NumShift = 5'd8;
end
else if (Address[15:6]==10'b0000001101) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd0;
  NumShift = 5'd10;
end
else if (Address[15:7]==9'b000000111) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd1;
  NumShift = 5'd9;
end
else if (Address[15:7]==9'b000001001) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd2;
  NumShift = 5'd9;
end
else if (Address[15:7]==9'b000001100) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd3;
  NumShift = 5'd9;
end
else if (Address[15:6]==10'b0000001001) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd0;
  NumShift = 5'd10;
end
else if (Address[15:6]==10'b0000001100) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd1;
  NumShift = 5'd10;
end
else if (Address[15:6]==10'b0000001011) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd2;
  NumShift = 5'd10;
end
else if (Address[15:6]==10'b0000001010) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd3;
  NumShift = 5'd10;
end
else if (Address[15:6]==10'b0000000101) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd0;
  NumShift = 5'd10;
end
else if (Address[15:6]==10'b0000001000) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd1;
  NumShift = 5'd10;
end
else if (Address[15:6]==10'b0000000111) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd2;
  NumShift = 5'd10;
end
else if (Address[15:6]==10'b0000000110) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd3;
  NumShift = 5'd10;
end
else if (Address[15:6]==10'b0000000001) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd0;
  NumShift = 5'd10;
end
else if (Address[15:6]==10'b0000000100) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd1;
  NumShift = 5'd10;
end
else if (Address[15:6]==10'b0000000011) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd2;
  NumShift = 5'd10;
end
else if (Address[15:6]==10'b0000000010) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd3;
  NumShift = 5'd10;
end
else begin
  TotalCoeff=5'd31;
  TrailingOnes=2'd0;
  NumShift=5'd0;

end
end
endmodule
