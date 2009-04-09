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
bit [9:0]  WDCnt;
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
//test_100 test(CAVLCIntfc);
test_1000 test(CAVLCIntfc);

always @(posedge Clk) begin
  if (CAVLCIntfc.BlockDone) WDCnt <= 0;
  else WDCnt <= WDCnt + 1;
  if (WDCnt == 1000) begin
    $display("ERROR: Watch dog expired");
    $stop;
  end    

end

endmodule

program test_100(CAVLCIntfc CAVLCIntfc);

BitStreamGenerator b1;
nCGenerator n1;
int        MBCnt;
int        block_cnt;

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
    b1.Run(block_cnt);
    b1.ResetValues();
    wait(b1.BitStreamDone==1);
  end
                                 
end

endprogram

program test_1000(CAVLCIntfc CAVLCIntfc);

BitStreamGenerator b1;
nCGenerator n1;
int        MBCnt;

string     bitstream_filename;
string     level_filename;
int        res;
int        TotalMBCnt;
int        num_clocks;
int        block_cnt;
int        block_array[50];
string     base;

initial begin
  b1 = new(CAVLCIntfc);
  b1.Init();
  b1.OutOfReset();
  TotalMBCnt = 0;
  base = `BASE;
  
  for (int i=0;i<50;i++) block_array[i]=0;
  
  for(MBCnt=0;MBCnt<1000;MBCnt++) begin
    if (MBCnt < 10) begin 
      bitstream_filename = $psprintf("%s%01d",base,MBCnt);
      level_filename = $psprintf("%slevel_%01d",base,MBCnt);
    end
    else if (MBCnt < 100) begin
      bitstream_filename = $psprintf("%s%02d",base,MBCnt);
      level_filename = $psprintf("%slevel_%02d",base,MBCnt);
    end
    else begin
      bitstream_filename = $psprintf("%s%03d",base,MBCnt);
      level_filename = $psprintf("%slevel_%03d",base,MBCnt);
    end

    $display("*************");
    $display("MB %03d",MBCnt);
    $display("*************");
res =    b1.LoadBitstream(bitstream_filename);

    // skip if there is a bad load.
    if (res == 0) begin
      $display("Skipping number %d, no file",MBCnt);
      continue;
    end
    else begin
      TotalMBCnt++;
    end

    b1.LoadLevels(level_filename);
    b1.Run(block_cnt);
    block_array[block_cnt]++;
    b1.ResetValues();
    wait(b1.BitStreamDone==1);
  end
                                 
  $display("Simulation complete: %d MBs in %d ps",TotalMBCnt,$time);
  num_clocks = $time/10;
  $display("Number of clocks: %d\nNumber clocks/MB: %d",num_clocks,num_clocks/TotalMBCnt);
  $display("Required frequency (clocks/second) for 1920x1088 video at 30 fps: %d Mhz", (1920*1088*30/256*(num_clocks/TotalMBCnt))/1000000);

  $display("Number of 4x4/2x2 per MB coverage");
  for(int i=0;i<50;i++) begin
    if (block_array[i] > 0) $display("%d: %d",i,block_array[i]);
  end

  $stop;
  

end

endprogram

program basic_test(CAVLCIntfc CAVLCIntfc);

BitStreamGenerator b1;
nCGenerator n1;
int block_cnt;

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
  b1.Run(block_cnt);
  b1.ResetValues();
  wait(b1.BitStreamDone==1);

  $display("*************");
  $display("MB 2");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_1");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_1");
  b1.Run(block_cnt);
  b1.ResetValues();
  wait(b1.BitStreamDone==1);


  $display("*************");
  $display("MB 3");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_2");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_2");
  b1.Run(block_cnt);
  b1.ResetValues();
  wait(b1.BitStreamDone==1);


 $display("*************");
 $display("MB 4");
 $display("*************");
 b1.LoadBitstream("../stim/test_data_0/test_data_0_3");
 b1.LoadLevels("../stim/test_data_0/test_data_0_level_3");
 b1.Run(block_cnt);
 b1.ResetValues();
 wait(b1.BitStreamDone==1);

  $display("*************");
  $display("MB 5");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_4");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_4");
  b1.Run(block_cnt);
  b1.ResetValues();
  wait(b1.BitStreamDone==1);

  $display("*************");
  $display("MB 6");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_5");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_5");
  b1.Run(block_cnt);
  b1.ResetValues();
  wait(b1.BitStreamDone==1);

  $display("*************");
  $display("MB 7");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_6");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_6");
  b1.Run(block_cnt);
  b1.ResetValues();
  wait(b1.BitStreamDone==1);


  $display("*************");
  $display("MB 8");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_7");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_7");
  b1.Run(block_cnt);
  b1.ResetValues();
  wait(b1.BitStreamDone==1);


  $display("*************");
  $display("MB 9");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_8");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_8");
  b1.Run(block_cnt);
  b1.ResetValues();
  wait(b1.BitStreamDone==1);

  $display("*************");
  $display("MB 10");
  $display("*************");
  b1.LoadBitstream("../stim/test_data_0/test_data_0_9");
  b1.LoadLevels("../stim/test_data_0/test_data_0_level_9");
  b1.Run(block_cnt);
  b1.ResetValues();
  wait(b1.BitStreamDone==1);

  $stop;
  
end

endprogram

