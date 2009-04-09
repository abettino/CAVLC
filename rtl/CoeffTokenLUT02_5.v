module CoeffTokenLUT02_5 (
                           input [2:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes, 
                           output reg [4:0] NumShift
                           );
always @* begin
  case (Bits)
    3'b011 : begin
      TotalCoeff = 5'd3;
      TrailingOnes = 2'd3;
      NumShift = 5'd5;
    end
    default : begin
      TotalCoeff = 'bx;
      TrailingOnes = 'bx;
      NumShift = 'bx;
    end
  endcase
end

endmodule