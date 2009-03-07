`ifndef __BitStreamGenerator__
`define __BitStreamGenerator__

`include "tbConfig.vh"

`define BIT_STREAM_MEM_SIZE 10000



class BitStreamGenerator;
virtual CAVLCIntfc CAVLCIntfc;
logic [15:0] BitStreamMem[0:`BIT_STREAM_MEM_SIZE];
int          Levels[16][`NUM_BLOCKS];
  
int          NumWords;
int          StreamOffset;  

  function new(virtual CAVLCIntfc a);
    CAVLCIntfc = a;
  endfunction

virtual task Init();
  CAVLCIntfc.nReset <= '0;
  CAVLCIntfc.Bitstream <= '0;
  CAVLCIntfc.Enable <= '0;
  
endtask

virtual task OutOfReset();
  repeat (100) @(CAVLCIntfc.cb);
  CAVLCIntfc.nReset <=  1'b1;
  repeat (10) @(CAVLCIntfc.cb);
  CAVLCIntfc.Enable <=  1'b1;
  repeat (1) @(CAVLCIntfc.cb);
endtask

virtual task Run();
int count;
  
  count = 0;
  
  fork
    while (1) begin
      @(CAVLCIntfc.cb);
      if (CAVLCIntfc.RdReq) begin
        CAVLCIntfc.Bitstream <= BitStreamMem[count];
        count++;
      end
      
    end
  join_none
endtask

virtual function LoadBitstream(input string filename);
int     i;
logic [16:0] CurrentWord;
logic [16:0] NextWord;

logic [16:0] Mask;
  
  $readmemh(filename,BitStreamMem);

  // find the size. isn't there a better way for this? readmem should return size or something
  for (i=0;i<`BIT_STREAM_MEM_SIZE;i++) if (BitStreamMem[i] === 32'bx)  break;  
  NumWords = i;


  StreamOffset = BitStreamMem[0];
  
  $display("LoadBitstream: Loading bitstream from file %s",filename);
  
  for(i=1;i<NumWords-1;i++) begin
    Mask = '1;
    
    CurrentWord = BitStreamMem[i];
    NextWord = BitStreamMem[i+1];
    
    CurrentWord = CurrentWord << StreamOffset;
    NextWord = NextWord >> (16-StreamOffset);
    CurrentWord = CurrentWord | NextWord;
    
    BitStreamMem[i-1] = CurrentWord;
    
  end

endfunction

virtual function LoadLevels(input string filename);
int     file, cnt;
  file = $fopen(filename,"r");
  cnt = 0;
  $display("LoadLevels: Loading levels from file %s",filename);
  if (file)  begin
  while (!$feof(file)) begin
    $fscanf(file,"%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n",
            Levels[0][cnt],Levels[1][cnt],Levels[2][cnt],Levels[3][cnt],
            Levels[4][cnt],Levels[5][cnt],Levels[6][cnt],Levels[7][cnt],
            Levels[8][cnt],Levels[9][cnt],Levels[10][cnt],Levels[11][cnt],
            Levels[12][cnt],Levels[13][cnt],Levels[14][cnt],Levels[15][cnt],
            Levels[16][cnt]);
    cnt++;
    if (cnt == `NUM_BLOCKS) break;

  end
  end
  else begin
    $display("Error loading file %s",filename);
  end
endfunction

virtual function DisplayStream(int num);
  $display("DisplayStream: StreamOffset = %d",StreamOffset);
  for(int i=0;i<num;i++) $display("%x",BitStreamMem[i]);
endfunction

virtual function DisplayLevels(int num);
  $display("DisplayLevels");
  for(int i=0;i<num;i++) begin
    for(int j=0;j<16;j++) begin
      $write("%d ",Levels[j][i]);
    end
    $display("");
  end

endfunction

endclass

`endif