module CoeffTokenLUT02_13 (
                           input [3:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes, 
                           output reg [4:0] NumShift
                           );
always @* begin
  case (Bits)
    4'b1111 : begin
      TotalCoeff = 5'd6;
      TrailingOnes = 2'd0;
      NumShift = 5'd13;
    end
    4'b1011 : begin
      TotalCoeff = 5'd7;
      TrailingOnes = 2'd0;
      NumShift = 5'd13;
    end
    4'b1110 : begin
      TotalCoeff = 5'd7;
      TrailingOnes = 2'd1;
      NumShift = 5'd13;
    end
    4'b1000 : begin
      TotalCoeff = 5'd8;
      TrailingOnes = 2'd0;
      NumShift = 5'd13;
    end
    4'b1010 : begin
      TotalCoeff = 5'd8;
      TrailingOnes = 2'd1;
      NumShift = 5'd13;
    end
    4'b1101 : begin
      TotalCoeff = 5'd8;
      TrailingOnes = 2'd2;
      NumShift = 5'd13;
    end
    4'b1001 : begin
      TotalCoeff = 5'd9;
      TrailingOnes = 2'd2;
      NumShift = 5'd13;
    end
    4'b1100 : begin
      TotalCoeff = 5'd10;
      TrailingOnes = 2'd3;
      NumShift = 5'd13;
    end
    default : begin
      TotalCoeff = 'bx;
      TrailingOnes = 'bx;
      NumShift = 'bx;
    end
  endcase
end

endmodule