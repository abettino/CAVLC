module RunBeforeTable (
                       input [3:0] ZeroesLeft,
                       input [10:0] Bits,
                       output reg [3:0] RunBefore,
                       output reg [3:0] NumShift
                       );


always @* begin
  case (ZeroesLeft)
    1 : begin
      if (Bits[10] == 'b1) RunBefore = 0;
      else RunBefore = 1;
      NumShift = 1;
    end
    2 : begin
      if (Bits[10] == 'b1) begin 
        RunBefore = 0;
        NumShift = 1;
      end
      else if (Bits[10:9]=='b01) begin 
        RunBefore = 1;
        NumShift = 2;           // 
      end
      else begin 
        RunBefore = 2;
        NumShift = 2;           // 
      end
    end
    3 : begin
      if (Bits[10:9] == 'b11) begin 
        RunBefore = 0;
        NumShift = 2;           // 
      end
      else if (Bits[10:9]=='b10) begin 
        RunBefore = 1;
        NumShift = 2;           // 
      end
      else if (Bits[10:9]=='b01) begin 
        RunBefore = 2;
        NumShift = 2;           // 
      end
      else begin 
        RunBefore = 3;
        NumShift = 2;           // 
      end
    end
    4 : begin
      if (Bits[10:9] == 'b11) begin 
        RunBefore = 0;
        NumShift = 2;           // 
      end
      else if (Bits[10:9]=='b10) begin 
        RunBefore = 1;
        NumShift = 2;           // 
      end
      else if (Bits[10:9]=='b01) begin 
        RunBefore = 2;
        NumShift = 2;           // 
      end
      else if (Bits[10:8]=='b001) begin 
        RunBefore = 3;
        NumShift = 3;           // 
      end
      else begin 
        RunBefore = 4;
        NumShift = 3;           // 
      end
    end
    5 : begin
      if (Bits[10:9] == 'b11) begin 
        RunBefore = 0;
        NumShift = 2;           // 
      end
      else if (Bits[10:9]=='b10) begin 
        RunBefore = 1;
        NumShift = 2;           // 
      end
      else if (Bits[10:8]=='b011) begin 
        RunBefore = 2;
        NumShift = 3;           // 
      end
      else if (Bits[10:8]=='b010) begin 
        RunBefore = 3;
        NumShift = 3;           // 
      end
      else if (Bits[10:8]=='b001) begin 
        RunBefore = 4;
        NumShift = 3;           // 
      end
      else begin 
        RunBefore = 5;
        NumShift = 3;           // 
      end
    end
    6 : begin
      if (Bits[10:9] == 'b11) begin 
        RunBefore = 0;
        NumShift = 2;           // 
      end
      else if (Bits[10:8]=='b000) begin 
        RunBefore = 1;
        NumShift = 3;           // 
      end
      else if (Bits[10:8]=='b001) begin 
        RunBefore = 2;
        NumShift = 3;           // 
      end
      else if (Bits[10:8]=='b011) begin 
        RunBefore = 3;
        NumShift = 3;           // 
      end
      else if (Bits[10:8]=='b010) begin 
        RunBefore = 4;
        NumShift = 3;           // 
      end
      else if (Bits[10:8]=='b101) begin 
        RunBefore = 5;
        NumShift = 3;           // 
      end
      else begin 
        RunBefore = 6;
        NumShift = 3;           // 
      end
    end
    7,8,9,10,11,12,13,14,15 : begin
      if (Bits[10:8] == 'b111) begin 
        RunBefore = 0;
        NumShift = 3;           // 
      end
      else if (Bits[10:8]=='b110) begin 
        RunBefore = 1;
        NumShift = 3;           // 
      end
      else if (Bits[10:8]=='b101) begin 
        RunBefore = 2;
        NumShift = 3;           // 
      end
      else if (Bits[10:8]=='b100) begin 
        RunBefore = 3;
        NumShift = 3;           // 
      end
      else if (Bits[10:8]=='b011) begin 
        RunBefore = 4;
        NumShift = 3;           // 
      end
      else if (Bits[10:8]=='b010) begin 
        RunBefore = 5;
        NumShift = 3;           // 
      end
      else if (Bits[10:8]=='b001) begin 
        RunBefore = 6;
        NumShift = 3;           // 
      end
      else if (Bits[10:7]=='b0001) begin 
        RunBefore = 7;
        NumShift = 4;           // 
      end
      else if (Bits[10:6]=='b00001) begin 
        RunBefore = 8;
        NumShift = 5;           // 
      end
      else if (Bits[10:5]=='b000001) begin 
        RunBefore = 9;
        NumShift = 6;           // 
      end
      else if (Bits[10:4]=='b0000001) begin 
        RunBefore = 10;
        NumShift = 7;           // 
      end
      else if (Bits[10:3]=='b00000001) begin 
        RunBefore = 11;
        NumShift = 8;           // 
      end
      else if (Bits[10:2]=='b000000001) begin 
        RunBefore = 12;
        NumShift = 9;           // 
      end
      else if (Bits[10:1]=='b0000000001) begin 
        RunBefore = 13;
        NumShift = 10;          // 
      end
      else begin 
        RunBefore = 14;
        NumShift = 11;          // 
      end
    end
    default : begin
      RunBefore = 0;
      NumShift = 0;
    end
  endcase
end

endmodule
  