module CoeffTokenLUT02_16 (
                           input [3:0] Bits,
                           output reg [4:0] TotalCoeff, 
                           output reg [1:0] TrailingOnes, 
                           output reg [4:0] NumShift
                           );

always @* begin
  case (Bits)
    4'b1111 : begin
      TotalCoeff = 5'd13;
      TrailingOnes = 2'd0;
      NumShift = 5'd16;
    end
    4'b1011 : begin
      TotalCoeff = 5'd14;
      TrailingOnes = 2'd0;
      NumShift = 5'd16;
    end
    4'b1110 : begin
      TotalCoeff = 5'd14;
      TrailingOnes = 2'd1;
      NumShift = 5'd16;
    end
    4'b1101 : begin
      TotalCoeff = 5'd14;
      TrailingOnes = 2'd2;
      NumShift = 5'd16;
    end
    4'b0111 : begin
      TotalCoeff = 5'd15;
      TrailingOnes = 2'd0;
      NumShift = 5'd16;
    end
    4'b1010 : begin
      TotalCoeff = 5'd15;
      TrailingOnes = 2'd1;
      NumShift = 5'd16;
    end
    4'b1001 : begin
      TotalCoeff = 5'd15;
      TrailingOnes = 2'd2;
      NumShift = 5'd16;
    end
    4'b1100 :begin
      TotalCoeff = 5'd15;
      TrailingOnes = 2'd3;
      NumShift = 5'd16;
    end
    4'b0100 : begin
      TotalCoeff = 5'd16;
      TrailingOnes = 2'd0;
      NumShift = 5'd16;
    end
    4'b0110 : begin
      TotalCoeff = 5'd16;
      TrailingOnes = 2'd1;
      NumShift = 5'd16;
    end
    4'b0101 : begin
      TotalCoeff = 5'd16;
      TrailingOnes = 2'd2;
      NumShift = 5'd16;
    end
    4'b1000 : begin
      TotalCoeff = 5'd16;
      TrailingOnes = 2'd3;
      NumShift = 5'd16;
    end
    default : begin
      TotalCoeff = 'bx;
      TrailingOnes = 'bx;
      NumShift = 'bx;
    end
  endcase
end

endmodule