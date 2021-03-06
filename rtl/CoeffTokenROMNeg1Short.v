module CoeffTokenROMNeg1 (input [15:0] Address, output reg [4:0] TotalCoeff, output reg [1:0] TrailingOnes, output reg [4:0] NumShift);
always @* begin
if (Address[15:14]==2'b01) begin
  TotalCoeff = 5'd0;
  TrailingOnes = 2'd0;
  NumShift = 5'd2;
end
else if (Address[15:10]==6'b000111) begin
  TotalCoeff = 5'd1;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:15]==1'b1) begin
  TotalCoeff = 5'd1;
  TrailingOnes = 2'd1;
  NumShift = 5'd1;
end
else if (Address[15:10]==6'b000100) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b000110) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
end
else if (Address[15:13]==3'b001) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd2;
  NumShift = 5'd3;
end
else if (Address[15:10]==6'b000011) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:9]==7'b0000011) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd1;
  NumShift = 5'd7;
end
else if (Address[15:9]==7'b0000010) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd2;
  NumShift = 5'd7;
end
else if (Address[15:10]==6'b000101) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
end
else if (Address[15:10]==6'b000010) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
end
else if (Address[15:8]==8'b00000011) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd1;
  NumShift = 5'd8;
end
else if (Address[15:8]==8'b00000010) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd2;
  NumShift = 5'd8;
end
else if (Address[15:9]==7'b0000000) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd3;
  NumShift = 5'd7;
end
else begin
  TotalCoeff=5'd31;
  TrailingOnes=2'd0;
  NumShift=5'd0;

end
end
endmodule
