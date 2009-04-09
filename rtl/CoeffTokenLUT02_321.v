module CoeffTokenLUT02_321 (
                           input [2:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes, 
                           output reg [4:0] NumShift
                           );
always @* begin
  case (Bits)
    3'b100,3'b101,3'b110,3'b111 : begin
      TotalCoeff = 5'd0;
      TrailingOnes = 2'd0;
      NumShift = 5'd1;
    end
    3'b010,3'b011 : begin
      TotalCoeff = 5'd1;
      TrailingOnes = 2'd1;
      NumShift = 5'd2;
    end
    3'b001 : begin
      TotalCoeff = 5'd2;
      TrailingOnes = 2'd2;
      NumShift = 5'd3;
    end
    default : begin
      TotalCoeff = 'bx;
      TrailingOnes = 'bx;
      NumShift = 'bx;
    end
  endcase
end

endmodule