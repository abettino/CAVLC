`define NUM_WORDS 20000
`define NUM_CAPTURE 20000
module tbBarrelShifter;

class SingleRandValue;
  rand bit [15:0] Data;
  rand bit [4:0] NumShifts;
  constraint c {
    NumShifts <= 16;
  }
endclass

class BitStream;
   bit [15:0] BitStream[0:`NUM_WORDS-1];
   bit [4:0]  NumShifts[0:`NUM_WORDS-1];

bit [15:0] ShiftedBitStream[0:`NUM_WORDS-1];;
int        ShiftCoverage[17];
  
  function build();
    SingleRandValue sr = new();
    foreach(BitStream[i]) begin
      assert(sr.randomize());
      BitStream[i] = sr.Data;
      NumShifts[i] = sr.NumShifts;
      ShiftCoverage[NumShifts[i]]++;
    end
  endfunction

  function display();
    $display("INPUT");
    for(int i=0;i<20;i++) begin
      $display("%x %x", BitStream[i],NumShifts[i]);
    end
    $display("OUTPUT");
    for(int i=0;i<20;i++) $display("%x",ShiftedBitStream[i]);
    
  endfunction

  function CalcResults();
  bit [16*`NUM_WORDS-1:0] CurrentWord;
    
    foreach(BitStream[i]) begin
      CurrentWord = {CurrentWord[16*`NUM_WORDS-16-1:0],BitStream[i]}; 
    end

    
    foreach(NumShifts[i]) begin
      ShiftedBitStream[i] = CurrentWord[16*`NUM_WORDS-1:16*`NUM_WORDS-16];
      CurrentWord = CurrentWord << NumShifts[i];
    end
  

  endfunction



endclass

bit [15:0] CapturedData[0:`NUM_WORDS-1];
int        capture_count;

bit Clk;
bit [15:0] Bitstream;
bit        Enable;
bit        ShiftEn;
bit [15:0] BitstreamShifted;
bit        BarrelShifterReady;
bit        nReset;

bit [4:0]  NumShift;

always #10 Clk = ~Clk;

BarrelShifter uBarrelShifter (
                              .Clk(Clk),
                              .nReset(nReset),
                              .Bitstream(Bitstream),
                              .Enable(Enable),
                              .ShiftEn(ShiftEn),
                              .NumShift(NumShift),
                              .RdReq(RdReq),
                              .BitstreamShifted(BitstreamShifted),
                              .BarrelShifterReady(BarrelShifterReady)
                              );


BitStream b1;

int        error_cnt;

initial begin
  b1 = new();
  b1.build();
  b1.CalcResults();
  b1.display();
  run_stream();

  
  Enable = 1'b1;
  ShiftEn = 0;
  nReset = 0;
  error_cnt  = 0;
  
  #100 nReset = 1'b1;
  
  wait (BarrelShifterReady==1'b1);
  @(posedge Clk);

  capture_data_task();

  run_shift();
  
  wait(capture_count == `NUM_CAPTURE);

  
  for(int j=0;j<`NUM_CAPTURE;j++) begin
    if (CapturedData[j] !== b1.ShiftedBitStream[j]) begin
      $display("ERROR: Got: %x Expected: %x at sample %d",CapturedData[j],b1.ShiftedBitStream[j],j);
      error_cnt++;
    end
  end



  $display("Sim complete with %d errors and %d shifts",error_cnt,capture_count);
  
  $display("Shift Coverage");
  
  foreach (b1.ShiftCoverage[i]) $display("%d : %d",i,b1.ShiftCoverage[i]);
  
  $stop;
  
  
end

task capture_data_task();
  capture_count = 0;
  
  fork
  while (1) begin
    @(posedge Clk);
    if (ShiftEn===1'b1) begin 
      CapturedData[capture_count] = BitstreamShifted;
      capture_count++;
    end
  end
  join_none
endtask

task run_shift();
int count;
  count = 0;
  


  
  fork
    while (1) begin
      @(posedge Clk);
      ShiftEn <= 1'b1;
      NumShift <= b1.NumShifts[count];
      count++;
    end
  join_none
endtask

task run_stream();
int count; 
  count=0;
//  Bitstream <= b1.BitStream[0];
//  count = 1;
  fork
    while (1) begin
      @(posedge Clk);
      if (RdReq) begin
        Bitstream <= b1.BitStream[count];
        count++;
      end
    end
  join_none
  
endtask

endmodule

