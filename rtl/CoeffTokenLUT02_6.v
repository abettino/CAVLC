module CoeffTokenLUT02_6 (
                           input [2:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes, 
                           output reg [4:0] NumShift
                           );
always @* begin
  case (Bits)
    3'b110,3'b111 : begin
      TotalCoeff = 5'd3;
      TrailingOnes = 2'd3;
    end
    3'b101 : begin
      TotalCoeff = 5'd1;
      TrailingOnes = 2'd0;
    end
    3'b100 : begin
      TotalCoeff = 5'd2;
      TrailingOnes = 2'd1;
    end
    default : begin
      TotalCoeff = 'bx;
      TrailingOnes = 'bx;
    end
  endcase

  if (&Bits[2:1]) NumShift = 5;
  else NumShift = 6;
  
end



endmodule