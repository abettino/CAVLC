module BarrelShifter (
                      input  logic        Clk,
                      input  logic        nReset,
                      input  logic [15:0] Bitstream,
                      input  logic        Enable,
                      input  logic        ShiftEn,
                      input  logic [4:0]  NumShift,
                      output logic        RdReq,
                      output logic [15:0] BitstreamShifted,
                      output logic        BarrelShifterReady
                      );

logic                                     RdReqDel;
logic [15:0]                              DataOutFIFO;
logic                                     AlmostFull;
logic                                     ReadFIFO;
logic                                     BarrelShiftEn;
logic                                     BarrelShiftEnDel;
logic                                     BarrelShiftEnPulse;
logic [4:0]                               NumShiftInt;
logic [15:0]                              BitstreamShiftedInt;
logic [15:0]                              DataFIFOShifted;
logic [15:0]                              DataFIFOShiftedInt;





// Barrel shift enable condition. Once enabled and the FIFO
// has sufficient data, we will assume the EMIF will be able to 
// keep the FIFO sufficiently full.
always_ff @(posedge Clk or negedge nReset) 
  if      (!nReset)             BarrelShiftEn <= '0;
  else if (!Enable)             BarrelShiftEn <= '0;
  else if (Enable & AlmostFull) BarrelShiftEn <= '1;


always_ff @(posedge Clk or negedge nReset)
  if (!nReset) begin 
    BarrelShiftEnDel <= '0;
    BarrelShifterReady <= '0;
  end
  else  begin
    BarrelShiftEnDel <= BarrelShiftEnPulse;
    if (!Enable) BarrelShifterReady <= 1'b0;
    else if (BarrelShiftEnDel) BarrelShifterReady <= 1'b1;
  end

PulseGenRising uBarrelShiftEnPulse(.Clk(Clk),.nReset(nReset),.D(BarrelShiftEn),.Pulse(BarrelShiftEnPulse));

always_ff @(posedge Clk or negedge nReset)
  if (!nReset) {DataFIFOShifted,BitstreamShifted} <= {'0,'0};
  else if (BarrelShiftEnPulse) BitstreamShifted <= DataOutFIFO;
  else if (BarrelShiftEnDel)   DataFIFOShifted <= DataOutFIFO;
  else if (ShiftEn) {DataFIFOShifted,BitstreamShifted} <= {DataFIFOShiftedInt,BitstreamShiftedInt};


// FIFO control.
always_ff @(posedge Clk or negedge nReset)
  if (!nReset) {ReadFIFO,RdReq,RdReqDel} <= {'0,'0,'0};
  else         {ReadFIFO,RdReq,RdReqDel} <= {(ShiftEn & |NumShift) | BarrelShiftEnPulse ,!AlmostFull & Enable,RdReq};

FIFO uFIFO(
  .Clk      (Clk),
  .nReset   (nReset),
  .DataReady(RdReqDel),
  .DataIn   (Bitstream),
  .ReadFIFO (ReadFIFO),
  .DataOut  (DataOutFIFO),
  .Full     (),
  .AlmostFull (AlmostFull),
  .Empty    (Empty),
  .Overflow (Overflow),
  .Underflow(Underflow)
);


always_comb begin
  case (NumShift)
    5'd0 :  begin 
      BitstreamShiftedInt = BitstreamShifted;
      DataFIFOShiftedInt = DataFIFOShifted;
    end
    5'd1 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[14:0],DataFIFOShifted[15:15]};
      DataFIFOShiftedInt     = {DataFIFOShifted[14:0],DataOutFIFO[15:15]};
    end
    5'd2 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[13:0],DataFIFOShifted[15:14]};
      DataFIFOShiftedInt     = {DataFIFOShifted[13:0],DataOutFIFO[15:14]};
    end
    5'd3 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[12:0],DataFIFOShifted[15:13]};
      DataFIFOShiftedInt     = {DataFIFOShifted[12:0],DataOutFIFO[15:13]};
    end
    5'd4 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[11:0],DataFIFOShifted[15:12]};
      DataFIFOShiftedInt     = {DataFIFOShifted[11:0],DataOutFIFO[15:12]};
    end
    5'd5 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[10:0],DataFIFOShifted[15:11]};
      DataFIFOShiftedInt     = {DataFIFOShifted[10:0],DataOutFIFO[15:11]};
    end
    5'd6 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[9:0],DataFIFOShifted[15:10]};
      DataFIFOShiftedInt     = {DataFIFOShifted[9:0],DataOutFIFO[15:10]};
    end
    5'd7 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[8:0],DataFIFOShifted[15:9]};
      DataFIFOShiftedInt     = {DataFIFOShifted[8:0],DataOutFIFO[15:9]};
    end
    5'd8 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[7:0],DataFIFOShifted[15:8]};
      DataFIFOShiftedInt     = {DataFIFOShifted[7:0],DataOutFIFO[15:8]};
    end
    5'd9 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[6:0],DataFIFOShifted[15:7]};
      DataFIFOShiftedInt     = {DataFIFOShifted[6:0],DataOutFIFO[15:7]};
    end
    5'd10 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[5:0],DataFIFOShifted[15:6]};
      DataFIFOShiftedInt     = {DataFIFOShifted[5:0],DataOutFIFO[15:6]};
    end
    5'd11 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[4:0],DataFIFOShifted[15:5]};
      DataFIFOShiftedInt     = {DataFIFOShifted[4:0],DataOutFIFO[15:5]};
    end
    5'd12 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[3:0],DataFIFOShifted[15:4]};
      DataFIFOShiftedInt     = {DataFIFOShifted[3:0],DataOutFIFO[15:4]};
    end
    5'd13 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[2:0],DataFIFOShifted[15:3]};
      DataFIFOShiftedInt     = {DataFIFOShifted[2:0],DataOutFIFO[15:3]};
    end
    5'd14 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[1:0],DataFIFOShifted[15:2]};
      DataFIFOShiftedInt     = {DataFIFOShifted[1:0],DataOutFIFO[15:2]};
    end
    5'd15 :  begin 
      BitstreamShiftedInt = {BitstreamShifted[0:0],DataFIFOShifted[15:1]};
      DataFIFOShiftedInt     = {DataFIFOShifted[0:0],DataOutFIFO[15:1]};
    end
    5'd16 :  begin 
      BitstreamShiftedInt = {DataFIFOShifted[15:0]};
      DataFIFOShiftedInt     = {DataFIFOShifted[14:0],DataOutFIFO[0:0]};
    end
    default :  begin 
      BitstreamShiftedInt = BitstreamShifted;
      DataFIFOShiftedInt = DataFIFOShifted;
    end
  endcase
end

endmodule