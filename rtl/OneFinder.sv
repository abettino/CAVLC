// Priority encoder for determininig first one position. and sign bit.
module OneFinder (
                  input  logic [15:0] BitstreamShifted,
                  output logic [3:0] OnePos,
                  output logic [4:0] ExtraBit
);

always_comb begin
  if      (BitstreamShifted[15]) begin 
    OnePos = 4'h0;
    ExtraBit = BitstreamShifted[14:10];
  end
  else if (BitstreamShifted[14]) begin 
    OnePos = 4'h1;
    ExtraBit = BitstreamShifted[13:9];
  end
  else if (BitstreamShifted[13]) begin 
    OnePos = 4'h2;
    ExtraBit = BitstreamShifted[12:8];
  end
  else if (BitstreamShifted[12]) begin 
    OnePos = 4'h3;
    ExtraBit = BitstreamShifted[11:7];
  end
  else if (BitstreamShifted[11]) begin 
    OnePos = 4'h4;
    ExtraBit = BitstreamShifted[10:6];
  end
  else if (BitstreamShifted[10]) begin 
    OnePos = 4'h5;
    ExtraBit = BitstreamShifted[9:5];
  end
  else if (BitstreamShifted[9])  begin 
    OnePos = 4'h6;
    ExtraBit = BitstreamShifted[8:4];
  end
  else if (BitstreamShifted[8])  begin 
    OnePos = 4'h7;
    ExtraBit = BitstreamShifted[7:3];
  end
  else if (BitstreamShifted[7])  begin 
    OnePos = 4'h8;
    ExtraBit = BitstreamShifted[6:2];
  end
  else if (BitstreamShifted[6])  begin 
    OnePos = 4'h9;
    ExtraBit = BitstreamShifted[5:1];
  end
  else if (BitstreamShifted[5])  begin 
    OnePos = 4'hA;
    ExtraBit = BitstreamShifted[4:0];
  end
  else if (BitstreamShifted[4])  begin 
    OnePos = 4'hB;
    ExtraBit = {BitstreamShifted[3:0],1'b0};
  end
  else if (BitstreamShifted[3])  begin 
    OnePos = 4'hC;
    ExtraBit = {BitstreamShifted[2:0],2'b0};
  end
  else if (BitstreamShifted[2])  begin 
    OnePos = 4'hD;
    ExtraBit = {BitstreamShifted[1:0],3'b0};
  end
  else if (BitstreamShifted[1])  begin 
    OnePos = 4'hE;
    ExtraBit = {BitstreamShifted[0],4'b0};
  end
  else if (BitstreamShifted[0])  begin 
    OnePos = 4'hF;
  end
  else                           begin 
    OnePos = '0;
    ExtraBit = '0;
  end
end

endmodule
  