`include "tbConfig.vh"
`include "BitStreamGenerator.sv"

interface CAVLCIntfc(input bit Clk);
logic        nReset;
logic [15:0] Bitstream;
logic        RdReq;             
logic [12:0] LevelOut;          
logic        WrReq;             
logic        BlockDone;         
logic        Enable;
logic [4:0]  nC;
logic [4:0]  TotalCoeffOut;

clocking cb @(posedge Clk);
input        LevelOut,RdReq,WrReq,BlockDone,TotalCoeffOut;
output       nReset,Bitstream, Enable,nC;
endclocking : cb

modport TB (clocking cb);

modport DUT (output      LevelOut,RdReq,WrReq,BlockDone,TotalCoeffOut,
             input       nReset,Bitstream, Enable,nC);

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
              .Enable       (CAVLCIntfc.Enable),           // enable signal.
              .nC           (CAVLCIntfc.nC),
              .Bitstream    (CAVLCIntfc.Bitstream),     // Input bitstream data.
              .RdReq        (CAVLCIntfc.RdReq),            // Read from the bistream source.
              .LevelOut     (CAVLCIntfc.LevelOut),         // Decoded level output.
              .WrReq        (CAVLCIntfc.WrReq),            // Write to level buffer/fifo.
              .BlockDone    (CAVLCIntfc.BlockDone),         // Current 4x4 block complere.
              .TotalCoeffOut (CAVLCIntfc.TotalCoeffOut)
              );

// launch the test
basic_test test(CAVLCIntfc);

endmodule

program basic_test(CAVLCIntfc CAVLCIntfc);

BitStreamGenerator b1;
nCGenerator n1;

initial begin
  b1 = new(CAVLCIntfc);
  n1 = new(CAVLCIntfc);
  n1.Init();
  b1.Init();
  b1.OutOfReset();
  b1.LoadBitstream("../stim/bistream0.dat");
  b1.DisplayStream(30);
  b1.LoadLevels("../stim/levels0.dat");
  b1.DisplayLevels(10);
  b1.Run();
  b1.RunLevelCheck();
  n1.Run();
  
  wait (b1.BlockCnt==`SIM_BLOCKS);
  $stop;
  
end

endprogram

