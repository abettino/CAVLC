module TotalZeroTable_1 (
                         input  [8:0] Bits,
                         input  [3:0] TotalCoeff,
                         output reg [3:0]  TotalZeroes,
                         output reg [3:0] NumShift
                         );


always @* begin

  case(TotalCoeff)
    4'h1 : begin
      if      (Bits[8])               begin
        TotalZeroes = 0;
        NumShift = 1;            
      end
      else if (Bits[8:6]=='b011)         begin
        TotalZeroes = 1;
        NumShift = 3;            
      end
      else if (Bits[8:6]=='b010)         begin
        TotalZeroes = 2;
        NumShift = 3;            
      end
      else if (Bits[8:5]=='b0011)        begin
        TotalZeroes = 3;
        NumShift = 4;            
      end
      else if (Bits[8:5]=='b0010)        begin
        TotalZeroes = 4;
        NumShift = 4;            
      end
      else if (Bits[8:4]=='b0001_1)      begin
        TotalZeroes = 5;
        NumShift = 5;            
      end
      else if (Bits[8:4]=='b0001_0)      begin
        TotalZeroes = 6;
        NumShift = 5;            
      end
      else if (Bits[8:3]=='b0000_11)     begin
        TotalZeroes = 7;
        NumShift = 6;           // 
      end
      else if (Bits[8:3]=='b0000_10)     begin
        TotalZeroes = 8;
        NumShift = 6;           // 
      end
      else if (Bits[8:2]=='b0000_011)    begin
        TotalZeroes = 9;
        NumShift = 7;           // 
      end
      else if (Bits[8:2]=='b0000_010)    begin
        TotalZeroes = 10;
        NumShift = 7;           // 
      end
      else if (Bits[8:1]=='b0000_0011)   begin
        TotalZeroes = 11;
        NumShift = 8;           // 
      end
      else if (Bits[8:1]=='b0000_0010)   begin
        TotalZeroes = 12;
        NumShift = 8;           // 
      end
      else if (Bits[8:0]=='b0000_0001_1) begin
        TotalZeroes = 13;
        NumShift = 9;           // 
      end
      else if (Bits[8:0]=='b0000_0001_0) begin
        TotalZeroes = 14;
        NumShift = 9;           // 
      end
      else if (Bits[8:0]=='b0000_0000_1) begin
        TotalZeroes = 15;
        NumShift = 9;           // 
      end
      else begin 
        TotalZeroes = 'x;
        NumShift = 0;
        
      end
    end
    4'h2 : begin
      if      (Bits[8:6]=='b111    )     begin
        TotalZeroes = 0;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b110    )     begin
        TotalZeroes = 1;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b101    )     begin
        TotalZeroes = 2;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b100    )     begin
        TotalZeroes = 3;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b011    )     begin
        TotalZeroes = 4;
        NumShift = 3;           // 
      end
      else if (Bits[8:5]=='b0101   )     begin
        TotalZeroes = 5;
        NumShift = 4;           // 
      end
      else if (Bits[8:5]=='b0100   )     begin
        TotalZeroes = 6;
        NumShift = 4;           // 
      end
      else if (Bits[8:5]=='b0011   )     begin
        TotalZeroes = 7;
        NumShift = 4;           // 
      end
      else if (Bits[8:5]=='b0010   )     begin
        TotalZeroes = 8;
        NumShift = 4;           // 
      end
      else if (Bits[8:4]=='b0001_1 )     begin
        TotalZeroes = 9;
        NumShift = 5;           // 
      end
      else if (Bits[8:4]=='b0001_0 )     begin
        TotalZeroes = 10;
        NumShift = 5;           // 
      end
      else if (Bits[8:3]=='b0000_11)     begin
        TotalZeroes = 11;
        NumShift = 6;           // 
      end
      else if (Bits[8:3]=='b0000_10)     begin
        TotalZeroes = 12;
        NumShift = 6;           // 
      end
      else if (Bits[8:3]=='b0000_01)     begin
        TotalZeroes = 13;
        NumShift = 6;           // 
      end
      else if (Bits[8:3]=='b0000_00)     begin
        TotalZeroes = 14;
        NumShift = 6;           // 
      end
      else begin 
        TotalZeroes = 'x;
        NumShift = 0;
      end
    end
    4'h3 : begin
      if      (Bits[8:5]=='b0101   )     begin
        TotalZeroes = 0;
        NumShift = 4;           // 
      end
      else if (Bits[8:6]=='b111    )     begin
        TotalZeroes = 1;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b110    )     begin
        TotalZeroes = 2;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b101    )     begin
        TotalZeroes = 3;
        NumShift = 3;           // 
      end
      else if (Bits[8:5]=='b0100   )     begin
        TotalZeroes = 4;
        NumShift = 4;           // 
      end
      else if (Bits[8:5]=='b0011   )     begin
        TotalZeroes = 5;
        NumShift = 4;           // 
      end
      else if (Bits[8:6]=='b100    )     begin
        TotalZeroes = 6;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b011    )     begin
        TotalZeroes = 7;
        NumShift = 3;           // 
      end
      else if (Bits[8:5]=='b0010   )     begin
        TotalZeroes = 8;
        NumShift = 4;           // 
      end
      else if (Bits[8:4]=='b0001_1 )     begin
        TotalZeroes = 9;
        NumShift = 5;           // 
      end
      else if (Bits[8:4]=='b0001_0 )     begin
        TotalZeroes = 10;
        NumShift = 5;           // 
      end
      else if (Bits[8:3]=='b0000_01)     begin
        TotalZeroes = 11;
        NumShift = 6;           // 
      end
      else if (Bits[8:4]=='b0000_1 )     begin
        TotalZeroes = 12;
        NumShift = 5;           // 
      end
      else if (Bits[8:3]=='b0000_00)     begin
        TotalZeroes = 13;
        NumShift = 6;           // 
      end
      else begin 
        TotalZeroes = 'x;
        NumShift= 0;            // 
      end
    end
    4'h4 : begin
      if      (Bits[8:4]=='b0001_1)     begin
        TotalZeroes = 0;
        NumShift = 5;           // 
      end
      else if (Bits[8:6]=='b111   )     begin
        TotalZeroes = 1;
        NumShift = 3;           // 
      end
      else if (Bits[8:5]=='b0101  )     begin
        TotalZeroes = 2;
        NumShift = 4;           // 
      end
      else if (Bits[8:5]=='b0100  )     begin
        TotalZeroes = 3;
        NumShift = 4;           // 
      end
      else if (Bits[8:6]=='b110   )     begin
        TotalZeroes = 4;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b101   )     begin
        TotalZeroes = 5;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b100   )     begin
        TotalZeroes = 6;
        NumShift = 3;           // 
      end
      else if (Bits[8:5]=='b0011  )     begin
        TotalZeroes = 7;
        NumShift = 4;           // 
      end
      else if (Bits[8:6]=='b011   )     begin
        TotalZeroes = 8;
        NumShift = 3;           // 
      end
      else if (Bits[8:5]=='b0010  )     begin
        TotalZeroes = 9;
        NumShift = 4;           // 
      end
      else if (Bits[8:4]=='b0001_0)     begin
        TotalZeroes = 10;
        NumShift = 5;           // 
      end
      else if (Bits[8:4]=='b0000_1)     begin
        TotalZeroes = 11;
        NumShift = 5;           // 
      end
      else if (Bits[8:4]=='b0000_0)     begin
        TotalZeroes = 12;
        NumShift = 5;           // 
      end
      else begin 
        TotalZeroes = 'x;
        NumShift = 0;
      end
    end
    4'h5 : begin
      if      (Bits[8:5]=='b0101  )     begin
        TotalZeroes = 0;
        NumShift = 4;           // 
      end
      else if (Bits[8:5]=='b0100  )     begin
        TotalZeroes = 1;
        NumShift = 4;           // 
      end
      else if (Bits[8:5]=='b0011  )     begin
        TotalZeroes = 2;
        NumShift = 4;           // 
      end
      else if (Bits[8:6]=='b111   )     begin
        TotalZeroes = 3;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b110   )     begin
        TotalZeroes = 4;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b101   )     begin
        TotalZeroes = 5;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b100   )     begin
        TotalZeroes = 6;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b011   )     begin
        TotalZeroes = 7;
        NumShift = 3;           // 
      end
      else if (Bits[8:5]=='b0010  )     begin
        TotalZeroes = 8;
        NumShift = 4;           // 
      end
      else if (Bits[8:4]=='b0000_1)     begin
        TotalZeroes = 9;
        NumShift = 5;           // 
      end
      else if (Bits[8:5]=='b0001  )     begin
        TotalZeroes = 10;
        NumShift = 4;           // 
      end
      else if (Bits[8:4]=='b0000_0 )     begin
        TotalZeroes = 11;
        NumShift = 5;           // 
      end
      else begin 
        TotalZeroes = 'x;
        NumShift = 0;           // 
      end
    end
    4'h6 : begin
      if      (Bits[8:3]=='b0000_01 )     begin
        TotalZeroes = 0;
        NumShift = 6;           // 
      end
      else if (Bits[8:4]=='b0000_1  )     begin
        TotalZeroes = 1;
        NumShift = 5;           // 
      end
      else if (Bits[8:6]=='b111     )     begin
        TotalZeroes = 2;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b110     )     begin
        TotalZeroes = 3;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b101     )     begin
        TotalZeroes = 4;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b100     )     begin
        TotalZeroes = 5;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b011     )     begin
        TotalZeroes = 6;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b010     )     begin
        TotalZeroes = 7;
        NumShift = 3;           // 
      end
      else if (Bits[8:5]=='b0001    )     begin
        TotalZeroes = 8;
        NumShift = 4;           // 
      end
      else if (Bits[8:6]=='b001     )     begin
        TotalZeroes = 9;
        NumShift = 3;           // 
      end
      else if (Bits[8:3]=='b0000_00 )     begin
        TotalZeroes = 10;
        NumShift = 6;           // 
      end
      else begin 
        TotalZeroes = 'x;
        NumShift = 0;
      end
    end
    4'h7 : begin
      if      (Bits[8:3]=='b0000_01 )     begin
        TotalZeroes = 0;
        NumShift = 6;           // 
      end
      else if (Bits[8:4]=='b0000_1  )     begin
        TotalZeroes = 1;
        NumShift = 5;           // 
      end
      else if (Bits[8:6]=='b101     )     begin
        TotalZeroes = 2;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b100     )     begin
        TotalZeroes = 3;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b011     )     begin
        TotalZeroes = 4;
        NumShift = 3;           // 
      end
      else if (Bits[8:7]=='b11      )     begin
        TotalZeroes = 5;
        NumShift = 2;           // 
      end
      else if (Bits[8:6]=='b010     )     begin
        TotalZeroes = 6;
        NumShift = 3;           // 
      end
      else if (Bits[8:5]=='b0001    )     begin
        TotalZeroes = 7;
        NumShift = 4;           // 
      end
      else if (Bits[8:6]=='b001     )     begin
        TotalZeroes = 8;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b0000_00 )     begin
        TotalZeroes = 9;
        NumShift = 6;           // 
      end
      else begin 
        TotalZeroes = 'x;
        NumShift = 0;           // 
      end
    end
    4'h8 : begin
      if      (Bits[8:3]=='b0000_01 )     begin
        TotalZeroes = 0;
        NumShift = 6;           // 
      end
      else if (Bits[8:5]=='b0001    )     begin
        TotalZeroes = 1;
        NumShift = 4;           // 
      end
      else if (Bits[8:4]=='b0000_1  )     begin
        TotalZeroes = 2;
        NumShift = 5;           // 
      end
      else if (Bits[8:6]=='b011     )     begin
        TotalZeroes = 3;
        NumShift = 3;           // 
      end
      else if (Bits[8:7]=='b11      )     begin
        TotalZeroes = 4;
        NumShift = 2;           // 
      end
      else if (Bits[8:7]=='b10      )     begin
        TotalZeroes = 5;
        NumShift = 2;           // 
      end
      else if (Bits[8:6]=='b010     )     begin
        TotalZeroes = 6;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b001     )     begin
        TotalZeroes = 7;
        NumShift = 3;           // 
      end
      else if (Bits[8:3]=='b0000_00 )     begin
        TotalZeroes = 8;
        NumShift = 6;           // 
      end
      else begin 
        TotalZeroes = 'x;
        NumShift = 0;           // 
      end
    end
    4'h9 : begin
      if      (Bits[8:3]=='b0000_01  )     begin
        TotalZeroes = 0;
        NumShift = 6;           // 
      end
      else if (Bits[8:3]=='b0000_00  )     begin
        TotalZeroes = 1;
        NumShift = 6;           // 
      end
      else if (Bits[8:5]=='b0001     )     begin
        TotalZeroes = 2;
        NumShift = 4;           // 
      end
      else if (Bits[8:7]=='b11       )     begin
        TotalZeroes = 3;
        NumShift = 2;           // 
      end
      else if (Bits[8:7]=='b10       )     begin
        TotalZeroes = 4;
        NumShift = 2;           // 
      end
      else if (Bits[8:6]=='b001      )     begin
        TotalZeroes = 5;
        NumShift = 3;           // 
      end
      else if (Bits[8:7]=='b01       )     begin
        TotalZeroes = 6;
        NumShift = 2;           // 
      end
      else if (Bits[8:4]=='b0000_1   )     begin
        TotalZeroes = 7;
        NumShift = 5;           // 
      end
      else begin 
        TotalZeroes = 'x;
        NumShift = 0;           // 
      end
    end
    4'hA : begin
      if      (Bits[8:4]=='b0000_1   )     begin
        TotalZeroes = 0;
        NumShift = 5;           // 
      end
      else if (Bits[8:4]=='b0000_0   )     begin
        TotalZeroes = 1;
        NumShift = 5;           // 
      end
      else if (Bits[8:6]=='b001      )     begin
        TotalZeroes = 2;
        NumShift = 3;           // 
      end
      else if (Bits[8:7]=='b11       )     begin
        TotalZeroes = 3;
        NumShift = 2;           // 
      end
      else if (Bits[8:7]=='b10       )     begin
        TotalZeroes = 4;
        NumShift = 2;           // 
      end
      else if (Bits[8:7]=='b01       )     begin
        TotalZeroes = 5;
        NumShift = 2;           // 
      end
      else if (Bits[8:5]=='b0001     )     begin
        TotalZeroes = 6;
        NumShift = 4;           // 
      end
      else begin 
        TotalZeroes = 'x;
        NumShift = 0;           // 
      end
    end
    4'hB : begin
      if      (Bits[8:5]=='b0000   )     begin
        TotalZeroes = 0;
        NumShift = 4;           // 
      end
      else if (Bits[8:5]=='b0001   )     begin
        TotalZeroes = 1;
        NumShift = 4;           // 
      end
      else if (Bits[8:6]=='b001    )     begin
        TotalZeroes = 2;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b010    )     begin
        TotalZeroes = 3;
        NumShift = 3;           // 
      end
      else if (Bits[8]=='b1        )     begin
        TotalZeroes = 4;
        NumShift = 1;           // 
      end
      else if (Bits[8:6]=='b011    )     begin
        TotalZeroes = 5;
        NumShift = 3;           // 
      end
      else TotalZeroes = 'x;
    end
    4'hC : begin
      if      (Bits[8:5]=='b0000    )     begin
        TotalZeroes = 0;
        NumShift = 4;           // 
      end
      else if (Bits[8:5]=='b0001    )     begin
        TotalZeroes = 1;
        NumShift = 4;           // 
      end
      else if (Bits[8:7]=='b01      )     begin
        TotalZeroes = 2;
        NumShift = 2;           // 
      end
      else if (Bits[8]  =='b1       )     begin
        TotalZeroes = 3;
        NumShift = 2;           // 
      end
      else if (Bits[8:6]=='b001     )     begin
        TotalZeroes = 4;
        NumShift = 3;           // 
      end
      else begin 
        TotalZeroes = 'x;
        NumShift = 0;           // 
      end
    end
    4'hD : begin
      if      (Bits[8:6]=='b000    )     begin
        TotalZeroes = 0;
        NumShift = 3;           // 
      end
      else if (Bits[8:6]=='b001    )     begin
        TotalZeroes = 1;
        NumShift = 3;           // 
      end
      else if (Bits[8]  =='b1      )     begin
        TotalZeroes = 2;
        NumShift = 1;           // 
      end
      else if (Bits[8:7]=='b01     )     begin
        TotalZeroes = 3;
        NumShift = 2;           // 
      end
      else begin
        TotalZeroes = 'x;
        NumShift = 0;
      end
    end
    4'hE : begin
      if      (Bits[8:7]=='b00    )     begin
        TotalZeroes = 0;
        NumShift = 2;           // 
      end
      else if (Bits[8:7]=='b01    )     begin
        TotalZeroes = 1;
        NumShift = 2;           // 
      end
      else if (Bits[8]  =='b1     )     begin
        TotalZeroes = 2;
        NumShift = 1;           // 
      end
      else begin 
        TotalZeroes = 'x;
        NumShift = 0;           // 
      end
    end
    4'hF : begin
      if      (Bits[8]=='b0  )     begin
        TotalZeroes = 0;
        NumShift = 1;           // 
        end
      else if (Bits[8]=='b1  )     begin
        TotalZeroes = 1;
        NumShift = 1;           // 
        end
      else begin 
        TotalZeroes = 'x;
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




  