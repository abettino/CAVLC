module CoeffTokenLUT02_14 (
                           input [3:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes 
                           );
always @* begin
  case (Bits)
    4'b1111 : begin
      TotalCoeff = 5'd9;
      TrailingOnes = 2'd0;
    end
    4'b1110 : begin
      TotalCoeff = 5'd9;
      TrailingOnes = 2'd1;
    end
    4'b1011 : begin
      TotalCoeff = 5'd10;
      TrailingOnes = 2'd0;
    end
    4'b1010 : begin
      TotalCoeff = 5'd10;
      TrailingOnes = 2'd1;
    end
    4'b1101 : begin
      TotalCoeff = 5'd10;
      TrailingOnes = 2'd2;
    end
    4'b1001 : begin
      TotalCoeff = 5'd11;
      TrailingOnes = 2'd2;
    end
    4'b1100 : begin
      TotalCoeff = 5'd11;
      TrailingOnes = 2'd3;
    end
    4'b1000 : begin
      TotalCoeff = 5'd12;
      TrailingOnes = 2'd3;
    end
    default : begin
      TotalCoeff = 'bx;
      TrailingOnes = 'bx;
    end
  endcase
end

endmodule