 module TotalZeroTableDCChroma (
                               input [8:0] Bits,
                               input [3:0] TotalCoeff,
                               output reg [3:0] TotalZeroes,
                               output reg [3:0] NumShift
                               );


always @* begin
  case (TotalCoeff)
    4'h1 : begin
      if (Bits[8]) begin
        TotalZeroes = 0;
        NumShift = 1;
      end
      else if (Bits[8:7]=='b01) begin
        TotalZeroes = 1;
        NumShift = 2;
      end
      else if (Bits[8:6]=='b001) begin
        TotalZeroes = 2;
        NumShift = 3;
      end
      else if (Bits[8:6]=='b000) begin
        TotalZeroes = 3;
        NumShift = 3;
      end
      else begin
        TotalZeroes = 0;
        NumShift = 0;
      end
    end
    4'h2 : begin
      if (Bits[8]) begin
        TotalZeroes = 0;
        NumShift = 1;
      end
      else if (Bits[8:7]=='b01) begin
        TotalZeroes = 1;
        NumShift = 2;
      end
      else if (Bits[8:7]=='b00) begin
        TotalZeroes = 2;
        NumShift = 2;
      end
      else begin
        TotalZeroes = 0;
        NumShift = 0;
      end
    end
    4'h3 : begin
      if (Bits[8]) begin
        TotalZeroes = 0;
        NumShift = 1;
      end
      else if (Bits[8]=='b0) begin
        TotalZeroes = 1;
        NumShift = 1;
      end
      else begin
        TotalZeroes = 0;
        NumShift = 0;
      end
    end
    default : begin
        TotalZeroes = 0;
        NumShift = 0;
    end
  endcase
end

endmodule