module CoeffTokenLUT02_7 (
                           input [2:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes, 
                          output reg [4:0] NumShift
                           );
always @* begin
  case (Bits)
    3'b101 : begin
      TotalCoeff = 5'd3;
      TrailingOnes = 2'd2;
      NumShift = 7;
    end
    3'b100 : begin
      TotalCoeff = 5'd5;
      TrailingOnes = 2'd3;
      NumShift = 7;
    end
    3'b110,3'b111 : begin
      TotalCoeff = 5'd4;
      TrailingOnes = 2'd3;
      NumShift = 6;
    end
    default : begin
      TotalCoeff = 'bx;
      TrailingOnes = 'bx;
    end
  endcase
end

endmodule

