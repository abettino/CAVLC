



module CoeffTokenLUT02_00 (
                           input [1:0] Bits,
                           output  [4:0] TotalCoeff, 
                           output  [1:0] TrailingOnes 
                           );

assign TotalCoeff = 5'd0;
assign TrailingOnes = 3'd0;


endmodule

module CoeffTokenLUT02_01 (
                           input [1:0] Bits,
                           output  [4:0] TotalCoeff, 
                           output  [1:0] TrailingOnes 
                           );

assign TotalCoeff = 5'd1;
assign TrailingOnes = 3'd1;


endmodule

module CoeffTokenLUT02_02 (
                           input [1:0] Bits,
                           output  [4:0] TotalCoeff, 
                           output  [1:0] TrailingOnes 
                           );

assign TotalCoeff = 5'd2;
assign TrailingOnes = 3'd2;


endmodule


module CoeffTokenLUT02_03 (
                           input [1:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes 
                           );

always @* begin
  case (Bits)
    2'b01  : TotalCoeff = 5'd1;
    2'b00    : TotalCoeff = 5'd2;
    2'b10,2'b11    : TotalCoeff = 5'd3;
  endcase

  TrailingOnes = {Bits[1],(Bits[1] | ~Bits[0])};
  
end

endmodule


module CoeffTokenLUT02_04 (
                           input [1:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes 
                           );

always @* begin
  case (Bits)
    2'b11,2'b10  : TotalCoeff = 5'd4;
    2'b01    : TotalCoeff = 5'd3;
    2'b00    : TotalCoeff = 5'd5;
  endcase

  TrailingOnes = {1'b1,(Bits[1] | ~Bits[0])};
  
end

endmodule


module CoeffTokenLUT02_05 (
                           input [1:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes 
                           );

always @* begin
  case (Bits)
    2'b11    : TotalCoeff = 5'd2;
    2'b10    : TotalCoeff = 5'd3;
    2'b01    : TotalCoeff = 5'd4;
    2'b00    : TotalCoeff = 5'd6;
  endcase

  TrailingOnes = ~Bits[1:0];
  
end

endmodule


module CoeffTokenLUT02_06 (
                           input [1:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes 
                           );

always @* begin
  case (Bits)
    2'b11    : TotalCoeff = 5'd3;
    2'b10    : TotalCoeff = 5'd4;
    2'b01    : TotalCoeff = 5'd5;
    2'b00    : TotalCoeff = 5'd7;
  endcase

  TrailingOnes = ~Bits[1:0];
  
end

endmodule


module CoeffTokenLUT02_07 (
                           input [1:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes 
                           );

always @* begin
  case (Bits)
    2'b11    : TotalCoeff = 5'd4;
    2'b10    : TotalCoeff = 5'd5;
    2'b01    : TotalCoeff = 5'd6;
    2'b00    : TotalCoeff = 5'd8;
  endcase

  TrailingOnes = ~Bits[1:0];
  
end

endmodule


module CoeffTokenLUT02_08 (
                           input [1:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes 
                           );

always @* begin
  case (Bits)
    2'b11    : TotalCoeff = 5'd5;
    2'b10    : TotalCoeff = 5'd6;
    2'b01    : TotalCoeff = 5'd7;
    2'b00    : TotalCoeff = 5'd9;
  endcase

  TrailingOnes = ~Bits[1:0];
  
  
end

endmodule

module CoeffTokenLUT02_09 (
                           input [2:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes 
                           );

always @* begin
  case (Bits)
    3'b100    : TotalCoeff = 5'd10;
    3'b111    : TotalCoeff = 5'd6;
    3'b011,3'b110                  : TotalCoeff = 5'd7;
    3'b000,3'b010,3'b101           : TotalCoeff = 5'd8;
    3'b001           : TotalCoeff = 5'd9;
  endcase

  // lets fix this!
  TrailingOnes = ~Bits[1:0] & {|Bits[2:0],|Bits[2:0]};
  
  
end


endmodule

module CoeffTokenLUT02_10 (
                           input [2:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes 
                           );

always @* begin
  case (Bits)
    3'b011,3'b010,3'b101    : TotalCoeff = 5'd10;
    3'b001,3'b100           : TotalCoeff = 5'd11;
    3'b000                  : TotalCoeff = 5'd12;
    3'b111,3'b110           : TotalCoeff = 5'd9;
  endcase

  TrailingOnes = ~Bits[1:0];
  
end


endmodule

module CoeffTokenLUT02_11 (
                           input [2:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes 
                           );

always @* begin
  case (Bits)
    3'b111,3'b110           : TotalCoeff = 5'd11;
    3'b011,3'b010,3'b101    : TotalCoeff = 5'd12;
    3'b001,3'b100           : TotalCoeff = 5'd13;
    3'b000                  : TotalCoeff = 5'd14;
  endcase

  TrailingOnes = ~Bits[1:0];
  
end


endmodule


module CoeffTokenLUT02_12 (
                           input [2:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes 
                           );

always @* begin
  case (Bits)
    3'b111               : TotalCoeff = 5'd13;
    3'b011,3'b110,3'b101 : TotalCoeff = 5'd14;
    3'b010,3'b001,3'b100 : TotalCoeff = 5'd15;
    3'b000               : TotalCoeff = 5'd16;
  endcase

  TrailingOnes = ~Bits[1:0];
  
end


endmodule


module CoeffTokenLUT02_13 (
                           input [1:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes 
                           );


always @* begin
  case (Bits)
    2'b00,2'b01,2'b10 : TotalCoeff = 16;
    2'b11             : TotalCoeff = 15;
  endcase

  TrailingOnes = {(~Bits[1] & Bits[0]),(Bits[1] & ~Bits[0])};
  
end


endmodule


module CoeffTokenLUT02_14 (
                           input Bits,
                           output  [4:0] TotalCoeff, 
                           output  [1:0] TrailingOnes 
                           );


assign TotalCoeff = 5'd13;
assign TrailingOnes = 1;


endmodule





