////////////////////////////////////////////////////////////////////////////////
//  File : BarrelShifter.sv
//  Author : Andrew Bettino (abettino@gmail.com)         
//  Desc : BarrelShifter. Maintains a FIFO and can continusouly shift any number
//   of bits (0-16) on a given clock cycle.
//         
//         
////////////////////////////////////////////////////////////////////////////////
module BarrelShifter (
                      input  logic        Clk,               // Clock.
                      input  logic        nReset,            // async reset.
                      input  logic [15:0] Bitstream,         // data input
                      input  logic        Enable,            // enable the entire module
                      input  logic        ShiftEn,           // instruct the module to shift
                      input  logic [4:0]  NumShift,          // number of bits to shift by (0-16)
                      output logic        RdReq,             // request data from the data source.
                      output logic [15:0] BitstreamShifted,  // shifted input data
                      output logic        BarrelShifterReady // indicates FIFOs are sufficiently full.
                      );
////////////////////////////////////////////////////////////////////////////////
logic                                     RdReqDel;
logic [15:0]                              DataOutFIFO;
logic                                     AlmostFull;
logic                                     ReadFIFO;
logic                                     BarrelShiftEn;
logic [1:0]                               BarrelShiftEnDel;
logic                                     BarrelShiftEnPulse;
logic [15:0]                              BitstreamShiftedInt;
logic [5:0]                               BitPtr; // Bit pointer reg.
logic [5:0]                               BitPtrComb; // Bit pointer comb.
logic [47:0]                              CurrentData;
logic                                     ShiftCond;
logic                                     BitPtrOverRun;
////////////////////////////////////////////////////////////////////////////////
// Barrel shift enable condition. Once enabled and the FIFO
// has sufficient data, we will assume the EMIF will be able to 
// keep the FIFO sufficiently full.
always_ff @(posedge Clk or negedge nReset) 
  if      (!nReset)             BarrelShiftEn <= '0;
  else if (!Enable)             BarrelShiftEn <= '0;
  else if (Enable & AlmostFull) BarrelShiftEn <= '1;
// control the starup of the barrel shifter.
always_ff @(posedge Clk or negedge nReset)
  if (!nReset) begin 
    BarrelShiftEnDel <= '0;
    BarrelShifterReady <= '0;
  end
  else  begin
    BarrelShiftEnDel <= {BarrelShiftEnDel[0],BarrelShiftEnPulse};
    if      (!Enable)          BarrelShifterReady <= 1'b0;
    else if (BarrelShiftEnDel) BarrelShifterReady <= 1'b1;
  end
// Rising edge pulse on enable signal.
PulseGenRising uBarrelShiftEnPulse(.Clk(Clk),.nReset(nReset),.D(BarrelShiftEn),.Pulse(BarrelShiftEnPulse));
// FIFO control.
////////////////////////////////////////////////////////////////////////////////
always_ff @(posedge Clk or negedge nReset)
  if (!nReset) {RdReq,RdReqDel} <= {'0,'0};
  else         {RdReq,RdReqDel} <= {!AlmostFull & Enable,RdReq};
assign ReadFIFO = ShiftCond | BarrelShiftEnPulse | |BarrelShiftEnDel;
// FIFO.
FIFO uFIFO(
  .Clk       (Clk),
  .nReset    (nReset),
  .Enable    (Enable),
//  .DataReady (RdReqDel),
  .DataReady (RdReq),
  .DataIn    (Bitstream),
  .ReadFIFO  (ReadFIFO),
  .DataOut   (DataOutFIFO),
  .Full      (),
  .AlmostFull(AlmostFull),
  .Empty     (),
  .Overflow  (),
  .Underflow ()
);
////////////////////////////////////////////////////////////////////////////////
// Bit pointing control/Data shifting
// combinational control signals.
assign BitPtrOverRun = (BitPtr+NumShift>=16);
assign ShiftCond     = BitPtrOverRun & ShiftEn;
assign BitPtrComb    = ShiftEn ? BitPtr+NumShift : BitPtr;

always_ff @(posedge Clk or negedge nReset)
  if (!nReset) begin 
    BitPtr <= '0;
    CurrentData <= '0;
    BitstreamShifted <= '0;
  end
  else begin
    if (!Enable) begin
      BitPtr <= '0;
      CurrentData <= '0;
      BitstreamShifted <= '0;
    end
    else begin
      // Bit pointer register.
      if      (ShiftEn & BitPtrOverRun) BitPtr <= (BitPtr+NumShift-5'd16);
      else if (ShiftEn) BitPtr <= BitPtrComb;
      // Current Data Loading.
      if      (BarrelShiftEnPulse)   CurrentData[47:32] <= DataOutFIFO;
      else if (BarrelShiftEnDel[0])  CurrentData[31:16] <= DataOutFIFO;
      else if (BarrelShiftEnDel[1])  CurrentData[15:0]  <= DataOutFIFO;
      else if (ShiftCond)            CurrentData        <= {CurrentData[31:0],DataOutFIFO};
      // output control.
      BitstreamShifted <= BitstreamShiftedInt;
    end
  end
// "Barrel" shifting mux.
always_comb begin
  case(BitPtrComb)
    5'd0  : BitstreamShiftedInt = CurrentData[47:32];
    5'd1  : BitstreamShiftedInt = CurrentData[46:31];
    5'd2  : BitstreamShiftedInt = CurrentData[45:30];
    5'd3  : BitstreamShiftedInt = CurrentData[44:29];
    5'd4  : BitstreamShiftedInt = CurrentData[43:28];
    5'd5  : BitstreamShiftedInt = CurrentData[42:27];
    5'd6  : BitstreamShiftedInt = CurrentData[41:26];
    5'd7  : BitstreamShiftedInt = CurrentData[40:25];
    5'd8  : BitstreamShiftedInt = CurrentData[39:24];
    5'd9  : BitstreamShiftedInt = CurrentData[38:23];
    5'd10 : BitstreamShiftedInt = CurrentData[37:22];
    5'd11 : BitstreamShiftedInt = CurrentData[36:21];
    5'd12 : BitstreamShiftedInt = CurrentData[35:20];
    5'd13 : BitstreamShiftedInt = CurrentData[34:19];
    5'd14 : BitstreamShiftedInt = CurrentData[33:18];
    5'd15 : BitstreamShiftedInt = CurrentData[32:17];
    5'd16 : BitstreamShiftedInt = CurrentData[31:16];
    5'd17 : BitstreamShiftedInt = CurrentData[30:15];
    5'd18 : BitstreamShiftedInt = CurrentData[29:14];
    5'd19 : BitstreamShiftedInt = CurrentData[28:13];
    5'd20 : BitstreamShiftedInt = CurrentData[27:12];
    5'd21 : BitstreamShiftedInt = CurrentData[26:11];
    5'd22 : BitstreamShiftedInt = CurrentData[25:10];
    5'd23 : BitstreamShiftedInt = CurrentData[24:9];
    5'd24 : BitstreamShiftedInt = CurrentData[23:8];
    5'd25 : BitstreamShiftedInt = CurrentData[22:7];
    5'd26 : BitstreamShiftedInt = CurrentData[21:6];
    5'd27 : BitstreamShiftedInt = CurrentData[20:5];
    5'd28 : BitstreamShiftedInt = CurrentData[19:4];
    5'd29 : BitstreamShiftedInt = CurrentData[18:3];
    5'd30 : BitstreamShiftedInt = CurrentData[17:2];
    5'd31 : BitstreamShiftedInt = CurrentData[16:1];
    default : BitstreamShiftedInt = 'x;
  endcase
end
endmodule

////////////////////////////////////////////////////////////////////////////////