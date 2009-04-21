module LUT02Stage1 (input [5:0] Address, output reg [4:0] TotalCoeff, output reg [1:0] TrailingOnes, output reg [4:0] NumShift, output reg Match);
always @* begin
if (Address[5:5]==1'b1) begin
  TotalCoeff = 5'd0;
  TrailingOnes = 2'd0;
  NumShift = 5'd1;
  Match = 1'b1;
end
else if (Address[5:0]==6'b000101) begin
  TotalCoeff = 5'd1;
  TrailingOnes = 2'd0;
  NumShift = 5'd6;
  Match = 1'b1;
end
else if (Address[5:4]==2'b01) begin
  TotalCoeff = 5'd1;
  TrailingOnes = 2'd1;
  NumShift = 5'd2;
  Match = 1'b1;
end
else if (Address[5:0]==6'b000100) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd1;
  NumShift = 5'd6;
  Match = 1'b1;
end
else if (Address[5:3]==3'b001) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd2;
  NumShift = 5'd3;
  Match = 1'b1;
end
else if (Address[5:1]==5'b00011) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd3;
  NumShift = 5'd5;
  Match = 1'b1;
end
else begin
  TotalCoeff='bx;                
  TrailingOnes='bx;
  NumShift='bx;
  Match=1'b0;
end
end
endmodule

module LUT02Stage2 (input [5:0] Address, output reg [4:0] TotalCoeff, output reg [1:0] TrailingOnes, output reg [4:0] NumShift, output reg Match);
always @* begin
if (Address[5:2]==4'b0111) begin
  TotalCoeff = 5'd2;
  TrailingOnes = 2'd0;
  NumShift = 5'd8;
  Match = 1'b1;
end
else if (Address[5:1]==5'b00111) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd0;
  NumShift = 5'd9;
  Match = 1'b1;
end
else if (Address[5:2]==4'b0110) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd1;
  NumShift = 5'd8;
  Match = 1'b1;
end
else if (Address[5:3]==3'b101) begin
  TotalCoeff = 5'd3;
  TrailingOnes = 2'd2;
  NumShift = 5'd7;
  Match = 1'b1;
end
else if (Address[5:0]==6'b000111) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd0;
  NumShift = 5'd10;
  Match = 1'b1;
end
else if (Address[5:1]==5'b00110) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd1;
  NumShift = 5'd9;
  Match = 1'b1;
end
else if (Address[5:2]==4'b0101) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd2;
  NumShift = 5'd8;
  Match = 1'b1;
end
else if (Address[5:4]==2'b11) begin
  TotalCoeff = 5'd4;
  TrailingOnes = 2'd3;
  NumShift = 5'd6;
  Match = 1'b1;
end
else if (Address[5:0]==6'b000110) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd1;
  NumShift = 5'd10;
  Match = 1'b1;
end
else if (Address[5:1]==5'b00101) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd2;
  NumShift = 5'd9;
  Match = 1'b1;
end
else if (Address[5:3]==3'b100) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd3;
  NumShift = 5'd7;
  Match = 1'b1;
end
else if (Address[5:0]==6'b000101) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd2;
  NumShift = 5'd10;
  Match = 1'b1;
end
else if (Address[5:2]==4'b0100) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd3;
  NumShift = 5'd8;
  Match = 1'b1;
end
else if (Address[5:1]==5'b00100) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd3;
  NumShift = 5'd9;
  Match = 1'b1;
end
else if (Address[5:0]==6'b000100) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd3;
  NumShift = 5'd10;
  Match = 1'b1;
end
else begin
  TotalCoeff=5'd31;
  TrailingOnes=2'd0;
  NumShift=5'd0;
  Match=1'b0;
end
end
endmodule


module LUT02Stage3 (input [6:0] Address, output reg [4:0] TotalCoeff, output reg [1:0] TrailingOnes, output reg [4:0] NumShift, output reg Match);
always @* begin
if (Address[6:4]==3'b111) begin
  TotalCoeff = 5'd5;
  TrailingOnes = 2'd0;
  NumShift = 5'd11;
  Match = 1'b1;
end
else if (Address[6:2]==5'b01111) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd0;
  NumShift = 5'd13;
  Match = 1'b1;
end
else if (Address[6:4]==3'b110) begin
  TotalCoeff = 5'd6;
  TrailingOnes = 2'd1;
  NumShift = 5'd11;
  Match = 1'b1;
end
else if (Address[6:2]==5'b01011) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd0;
  NumShift = 5'd13;
  Match = 1'b1;
end
else if (Address[6:2]==5'b01110) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd1;
  NumShift = 5'd13;
  Match = 1'b1;
end
else if (Address[6:4]==3'b101) begin
  TotalCoeff = 5'd7;
  TrailingOnes = 2'd2;
  NumShift = 5'd11;
  Match = 1'b1;
end
else if (Address[6:2]==5'b01000) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd0;
  NumShift = 5'd13;
  Match = 1'b1;
end
else if (Address[6:2]==5'b01010) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd1;
  NumShift = 5'd13;
  Match = 1'b1;
end
else if (Address[6:2]==5'b01101) begin
  TotalCoeff = 5'd8;
  TrailingOnes = 2'd2;
  NumShift = 5'd13;
  Match = 1'b1;
end
else if (Address[6:1]==6'b001111) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd0;
  NumShift = 5'd14;
  Match = 1'b1;
end
else if (Address[6:1]==6'b001110) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd1;
  NumShift = 5'd14;
  Match = 1'b1;
end
else if (Address[6:2]==5'b01001) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd2;
  NumShift = 5'd13;
  Match = 1'b1;
end
else if (Address[6:4]==3'b100) begin
  TotalCoeff = 5'd9;
  TrailingOnes = 2'd3;
  NumShift = 5'd11;
  Match = 1'b1;
end
else if (Address[6:1]==6'b001011) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd0;
  NumShift = 5'd14;
  Match = 1'b1;
end
else if (Address[6:1]==6'b001010) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd1;
  NumShift = 5'd14;
  Match = 1'b1;
end
else if (Address[6:1]==6'b001101) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd2;
  NumShift = 5'd14;
  Match = 1'b1;
end
else if (Address[6:2]==5'b01100) begin
  TotalCoeff = 5'd10;
  TrailingOnes = 2'd3;
  NumShift = 5'd13;
  Match = 1'b1;
end
else if (Address[6:0]==7'b0001111) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd0;
  NumShift = 5'd15;
  Match = 1'b1;
end
else if (Address[6:0]==7'b0001110) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd1;
  NumShift = 5'd15;
  Match = 1'b1;
end
else if (Address[6:1]==6'b001001) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd2;
  NumShift = 5'd14;
  Match = 1'b1;
end
else if (Address[6:1]==6'b001100) begin
  TotalCoeff = 5'd11;
  TrailingOnes = 2'd3;
  NumShift = 5'd14;
  Match = 1'b1;
end
else if (Address[6:0]==7'b0001011) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd0;
  NumShift = 5'd15;
  Match = 1'b1;
end
else if (Address[6:0]==7'b0001010) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd1;
  NumShift = 5'd15;
  Match = 1'b1;
end
else if (Address[6:0]==7'b0001101) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd2;
  NumShift = 5'd15;
  Match = 1'b1;
end
else if (Address[6:1]==6'b001000) begin
  TotalCoeff = 5'd12;
  TrailingOnes = 2'd3;
  NumShift = 5'd14;
  Match = 1'b1;
end
else if (Address[6:0]==7'b0001001) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd2;
  NumShift = 5'd15;
  Match = 1'b1;
end
else if (Address[6:0]==7'b0001100) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd3;
  NumShift = 5'd15;
  Match = 1'b1;
end
else if (Address[6:0]==7'b0001000) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd3;
  NumShift = 5'd15;
  Match = 1'b1;
end
else begin
  TotalCoeff=5'd31;
  TrailingOnes=2'd0;
  NumShift=5'd0;
  Match=1'b0;
end
end
endmodule

module LUT02Stage4 (input [3:0] Address, output reg [4:0] TotalCoeff, output reg [1:0] TrailingOnes, output reg [4:0] NumShift, output reg Match);
always @* begin
if (Address[3:0]==4'b1111) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd0;
  NumShift = 5'd16;
  Match = 1'b1;
end
else if (Address[3:1]==3'b001) begin
  TotalCoeff = 5'd13;
  TrailingOnes = 2'd1;
  NumShift = 5'd15;
  Match = 1'b1;
end
else if (Address[3:0]==4'b1011) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd0;
  NumShift = 5'd16;
  Match = 1'b1;
end
else if (Address[3:0]==4'b1110) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd1;
  NumShift = 5'd16;
  Match = 1'b1;
end
else if (Address[3:0]==4'b1101) begin
  TotalCoeff = 5'd14;
  TrailingOnes = 2'd2;
  NumShift = 5'd16;
  Match = 1'b1;
end
else if (Address[3:0]==4'b0111) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd0;
  NumShift = 5'd16;
  Match = 1'b1;
end
else if (Address[3:0]==4'b1010) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd1;
  NumShift = 5'd16;
  Match = 1'b1;
end
else if (Address[3:0]==4'b1001) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd2;
  NumShift = 5'd16;
  Match = 1'b1;
end
else if (Address[3:0]==4'b1100) begin
  TotalCoeff = 5'd15;
  TrailingOnes = 2'd3;
  NumShift = 5'd16;
  Match = 1'b1;
end
else if (Address[3:0]==4'b0100) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd0;
  NumShift = 5'd16;
  Match = 1'b1;
end
else if (Address[3:0]==4'b0110) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd1;
  NumShift = 5'd16;
  Match = 1'b1;
end
else if (Address[3:0]==4'b0101) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd2;
  NumShift = 5'd16;
  Match = 1'b1;
end
else if (Address[3:0]==4'b1000) begin
  TotalCoeff = 5'd16;
  TrailingOnes = 2'd3;
  NumShift = 5'd16;
  Match = 1'b1;
end
else begin
  TotalCoeff=5'd31;
  TrailingOnes=2'd0;
  NumShift=5'd0;
  Match=1'b0;
end
end
endmodule

