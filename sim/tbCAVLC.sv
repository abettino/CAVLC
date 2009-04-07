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
bit [15:0] DataReg;

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
//basic_test test(CAVLCIntfc);
test_100 test(CAVLCIntfc);

endmodule

program test_100(CAVLCIntfc CAVLCIntfc);

BitStreamGenerator b1;
nCGenerator n1;
int        MBCnt;

string     bitstream_filename;
string     level_filename;

initial begin
  b1 = new(CAVLCIntfc);
  b1.Init();
  b1.OutOfReset();
  
  for(MBCnt=0;MBCnt<100;MBCnt++) begin
    if (MBCnt < 10) begin 
      bitstream_filename = $psprintf("../stim/test_data_1/test_data_1_%01d",MBCnt);
      level_filename = $psprintf("../stim/test_data_1/test_data_1_level_%01d",MBCnt);
    end
    else begin
      bitstream_filename = $psprintf("../stim/test_data_1/test_data_1_%02d",MBCnt);
      level_filename = $psprintf("../stim/test_data_1/test_data_1_level_%02d",MBCnt);
    end
    $display("*************");
    $display("MB %02d",MBCnt);
    $display("*************");
    b1.LoadBitstream(bitstream_filename);
    b1.LoadLevels(level_filename);
    b1.Run();
    b1.ResetValues();
    wait(b1.BitStreamDone==1);
  end
                                 
end

endprogram

program basic_test(CAVLCIntfc CAVLCIntfc);

BitStreamGenerator b1;
nCGenerator n1;

initial begin
  b1 = new(CAVLCIntfc);
  b1.Init();
  b1.OutOfReset();

  $display("*************");
  $display("MB 1");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_0");
//  b1.DisplayStream(50);
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_0");
//  b1.DisplayLevels(10);
//  b1.DisplaynC(10);
  b1.Run();
  b1.ResetValues();
  wait(b1.BitStreamDone==1);

  $display("*************");
  $display("MB 2");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_1");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_1");
  b1.Run();
  b1.ResetValues();
  wait(b1.BitStreamDone==1);


  $display("*************");
  $display("MB 3");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_2");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_2");
  b1.Run();
  b1.ResetValues();
  wait(b1.BitStreamDone==1);


 $display("*************");
 $display("MB 4");
 $display("*************");
 b1.LoadBitstream("../stim/test_data_0/test_data_0_3");
 b1.LoadLevels("../stim/test_data_0/test_data_0_level_3");
 b1.Run();
 b1.ResetValues();
 wait(b1.BitStreamDone==1);

  $display("*************");
  $display("MB 5");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_4");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_4");
  b1.Run();
  b1.ResetValues();
  wait(b1.BitStreamDone==1);

  $display("*************");
  $display("MB 6");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_5");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_5");
  b1.Run();
  b1.ResetValues();
  wait(b1.BitStreamDone==1);

  $display("*************");
  $display("MB 7");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_6");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_6");
  b1.Run();
  b1.ResetValues();
  wait(b1.BitStreamDone==1);


  $display("*************");
  $display("MB 8");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_7");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_7");
  b1.Run();
  b1.ResetValues();
  wait(b1.BitStreamDone==1);


  $display("*************");
  $display("MB 9");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_8");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_8");
  b1.Run();
  b1.ResetValues();
  wait(b1.BitStreamDone==1);

  $display("*************");
  $display("MB 10");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_9");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_9");
  b1.Run();
  b1.ResetValues();
  wait(b1.BitStreamDone==1);

  $stop;
  
end

endprogram

