`include "tbConfig.vh"

interface CAVLCIntfc(input bit Clk);
logic        nReset;
logic [15:0] BitstreamData;                 
logic        RdReq;             
logic [12:0] LevelOut;          
logic        WrReq;             
logic        BlockDone;         

clocking cb @(posedge Clk);
input        LevelOut,RdReq,WrReq,BlockDone;
output       nReset,BitstreamData;
endclocking : cb

endinterface

module tbCAVLC;

// Clock generation.
bit        Clk;
always #(`CLK_PERIOD/2) Clk = ~Clk;

// CAVLC Interface.
CAVLCIntfc CAVLCIntfc(Clk);


// DUT instance.
CAVLC uCAVLC (
              .Clk          (Clk),                         // Clock.
              .nReset       (CAVLCIntfc.nReset),           // Async reset.
              .BitstreamData(CAVLCIntfc.BitstreamData),     // Input bitstream data.
              .RdReq        (CAVLCIntfc.RdReq),            // Read from the bistream source.
              .LevelOut     (CAVLCIntfc.LevelOut),         // Decoded level output.
              .WrReq        (CAVLCIntfc.WrReq),            // Write to level buffer/fifo.
              .BlockDone    (CAVLCIntfc.BlockDone)         // Current 4x4 block complere.
              );


initial begin
  #1000 $stop;
end

endmodule