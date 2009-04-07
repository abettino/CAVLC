////////////////////////////////////////////////////////////////////////////////
//  File : OneFinder.sv
//  Desc : Priority encoder for determininig first one position.
//        also outputs "extra bits" which correspond to the suffx.
////////////////////////////////////////////////////////////////////////////////
module OneFinder (
                  input  logic [15:0] BitstreamShifted,
                  output logic [3:0] OnePos,
                  output logic [4:0] ExtraBit
);

logic [3:0]                          Ones;
logic [3:0]                          OnesOneHot;
logic [3:0]                          Select4Bit;
logic [1:0]                          OneNumber;


assign Ones[3] = |BitstreamShifted[15:12];
assign Ones[2] = |BitstreamShifted[11:8];
assign Ones[1] = |BitstreamShifted[7:4];
assign Ones[0] = |BitstreamShifted[3:0];


assign OnesOneHot[3] = Ones[3];
assign OnesOneHot[2] = Ones[2] & (~|Ones[3]);
assign OnesOneHot[1] = Ones[1] & (~|Ones[3:2]);
assign OnesOneHot[0] = Ones[0] & (~|Ones[3:1]);

/*
always_comb begin
  if (Ones[3])  begin 
    Select4Bit = BitstreamShifted[15:12];
    OneNumber = 0;
  end
  else if (Ones[2]) begin 
    Select4Bit = BitstreamShifted[11:8];
    OneNumber = 1;
  end
  else if (Ones[1]) begin 
    Select4Bit = BitstreamShifted[7:4];
    OneNumber = 2;
  end
  else if (Ones[0]) begin 
    Select4Bit = BitstreamShifted[3:0];
    OneNumber = 3;
  end
  else begin 
    Select4Bit = '0;
    OneNumber = 0;
  end
end
*/
/*
always_comb begin
  case (OnesOneHot)
    4'b1000 : begin 
      Select4Bit = BitstreamShifted[15:12];
      OneNumber = 0;
    end
    4'b0100 : begin 
      Select4Bit = BitstreamShifted[11:8];
      OneNumber = 1;
    end
    4'b0010 : begin 
      Select4Bit = BitstreamShifted[7:4];
      OneNumber = 2;
    end
    4'b0001 : begin 
      Select4Bit = BitstreamShifted[3:0];
      OneNumber = 3;
    end
    default : begin 
      Select4Bit = 'x;
      OneNumber = 'x;
    end
  endcase
end
*/

always_comb begin
  case (Ones)
    4'b1000 : begin 
      Select4Bit = BitstreamShifted[15:12];
      OneNumber = 0;
    end
    4'b1001 : begin 
      Select4Bit = BitstreamShifted[15:12];
      OneNumber = 0;
    end
    4'b1010 : begin 
      Select4Bit = BitstreamShifted[15:12];
      OneNumber = 0;
    end
    4'b1011 : begin 
      Select4Bit = BitstreamShifted[15:12];
      OneNumber = 0;
    end
    4'b1100 : begin 
      Select4Bit = BitstreamShifted[15:12];
      OneNumber = 0;
    end
    4'b1101 : begin 
      Select4Bit = BitstreamShifted[15:12];
      OneNumber = 0;
    end
    4'b1110 : begin 
      Select4Bit = BitstreamShifted[15:12];
      OneNumber = 0;
    end
    4'b1111 : begin 
      Select4Bit = BitstreamShifted[15:12];
      OneNumber = 0;
    end
    4'b0100 : begin 
      Select4Bit = BitstreamShifted[11:8];
      OneNumber = 1;
    end
    4'b0101 : begin 
      Select4Bit = BitstreamShifted[11:8];
      OneNumber = 1;
    end
    4'b0110 : begin 
      Select4Bit = BitstreamShifted[11:8];
      OneNumber = 1;
    end
    4'b0111 : begin 
      Select4Bit = BitstreamShifted[11:8];
      OneNumber = 1;
    end
    4'b0010 : begin 
      Select4Bit = BitstreamShifted[7:4];
      OneNumber = 2;
    end
    4'b0011 : begin 
      Select4Bit = BitstreamShifted[7:4];
      OneNumber = 2;
    end
    4'b0001 : begin 
      Select4Bit = BitstreamShifted[3:0];
      OneNumber = 3;
    end
    default : begin 
      Select4Bit = 0;
      OneNumber = 0;
    end
  endcase
end

always_comb begin
  case (Select4Bit)
    4'b1000 : OnePos = OneNumber*4;
    4'b1001 : OnePos = OneNumber*4;
    4'b1010 : OnePos = OneNumber*4;
    4'b1011 : OnePos = OneNumber*4;
    4'b1100 : OnePos = OneNumber*4;
    4'b1101 : OnePos = OneNumber*4;
    4'b1110 : OnePos = OneNumber*4;
    4'b1111 : OnePos = OneNumber*4;
    4'b0100 : OnePos = 1+OneNumber*4;
    4'b0101 : OnePos = 1+OneNumber*4;
    4'b0110 : OnePos = 1+OneNumber*4;
    4'b0111 : OnePos = 1+OneNumber*4;
    4'b0010 : OnePos = 2+OneNumber*4;
    4'b0011 : OnePos = 2+OneNumber*4;
    4'b0001 : OnePos = 3+OneNumber*4;
    default : OnePos = 0;
  endcase
end

always_comb begin
  case(OnePos)
    0 :  ExtraBit = BitstreamShifted[14:10];
    1 :  ExtraBit = BitstreamShifted[13:9];
    2 :  ExtraBit = BitstreamShifted[12:8];
    3 :  ExtraBit = BitstreamShifted[11:7];
    4 :  ExtraBit = BitstreamShifted[10:6];
    5 :  ExtraBit = BitstreamShifted[9:5];
    6 :  ExtraBit = BitstreamShifted[8:4];
    7 :  ExtraBit = BitstreamShifted[7:3];
    8 :  ExtraBit = BitstreamShifted[6:2];
    9 :  ExtraBit = BitstreamShifted[5:1];
    10 : ExtraBit = BitstreamShifted[4:0];
    11 : ExtraBit = {BitstreamShifted[3:0],1'b0};
    12 : ExtraBit = {BitstreamShifted[2:0],2'b0};
    13 : ExtraBit = {BitstreamShifted[1:0],3'b0};
    14 : ExtraBit = {BitstreamShifted[0],4'b0};
    default :     ExtraBit ='0;
  endcase
end


/*
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
    ExtraBit ='0;
  end
  else                           begin 
    OnePos = '0;
    ExtraBit = '0;
  end
end
*/
endmodule
  