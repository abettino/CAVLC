`ifndef __BitStreamGenerator__
`define __BitStreamGenerator__

`include "tbConfig.vh"

`define BIT_STREAM_MEM_SIZE 10000

class nCGenerator;
virtual CAVLCIntfc CAVLCIntfc;
logic [3:0] CurrentCoeffBlock [0:3];
logic [3:0] PrevCoeffBlock [0:3];
int         HCount;
int         VCount;
int         SmallBlockCnt;
int         nA, nAAvail;
int         nB, nBAvail;
  

  function new(virtual CAVLCIntfc a);
    CAVLCIntfc = a;
  endfunction

virtual     task Init();
  $display("Init Coeff blocks");
  CAVLCIntfc.nC = 0;
  for (int i=0;i<4;i++) begin
    CurrentCoeffBlock[i] = 4'bx;
    PrevCoeffBlock[i] = 4'bx;
  end


endtask

virtual task Run();
  fork
    VCount=0;
    HCount=0;
    CAVLCIntfc.nC = 0;
    SmallBlockCnt = 0;
    while (1) begin
      @(CAVLCIntfc.cb);

      case (SmallBlockCnt)
        0 : begin
          nB = 0;
          nBAvail = 0;
          if (PrevCoeffBlock[1] !== 'x) begin
            nA = PrevCoeffBlock[1];
            nAAvail =1;
          end
          else begin
            nA = 0;
            nAAvail =0;
          end
        end
        1 : begin
          nB = 0;
          nBAvail = 0;
          nA = CurrentCoeffBlock[0];
          nAAvail = 1;
        end
        2 : begin
          nB = CurrentCoeffBlock[0];
          nBAvail = 1;
          if (PrevCoeffBlock[3] !== 'x) begin
            nA = PrevCoeffBlock[3];
            nAAvail = 1;
          end
          else begin
            nA = 0;           // 
            nAAvail = 0;      // 
          end
        end
        3  : begin
          nA = CurrentCoeffBlock[2];
          nB = CurrentCoeffBlock[1];
          nAAvail = 1;
          nBAvail = 1;
        end
      endcase

      if (nBAvail && nAAvail) begin 
        if ((nA + nB) & 'h1)    CAVLCIntfc.nC = (nA+nB)/2 + 1; // odd number
        else    CAVLCIntfc.nC = (nA+nB)/2;
      end
      else CAVLCIntfc.nC = nA+nB;

      if (CAVLCIntfc.BlockDone) begin
        $display("nA: %d nB: %d SmallBlockCnt: %d",nA,nB,SmallBlockCnt); // 
        CurrentCoeffBlock[SmallBlockCnt] = CAVLCIntfc.TotalCoeffOut;
        if (SmallBlockCnt==3) begin
          if (HCount == `HBLOCKS-1  && VCount==`VBLOCKS-1) begin
            VCount=0;
            HCount=0;
            Init();
          end
          else if (HCount == `HBLOCKS-1) begin
            HCount = 0;
            VCount++;
            Init();
          end
          else begin
            HCount++;
          end
          SmallBlockCnt=0;
          for (int i=0;i<4;i++) begin
            PrevCoeffBlock[i] = CurrentCoeffBlock[i];
            $display("load block: %d",PrevCoeffBlock[i]);
          end
        end else begin
          SmallBlockCnt++;
        end
      end
    end
  join_none

endtask

endclass

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
int  count;

  count = 0;
  
  fork
    while (1) begin
      @(CAVLCIntfc.cb);
      CAVLCIntfc.Bitstream <= BitStreamMem[count];
      if (CAVLCIntfc.RdReq) begin
        count++;
      end
      
    end
  join_none
endtask

virtual function LoadBitstream(input string filename);
int     i;
logic [16*30-1:0] LongStream;
logic [15:0] CurrentWord;
logic [15:0] NextWord;

logic [15:0] Mask;
  
  $readmemh(filename,BitStreamMem);

  // find the size. isn't there a better way for this? readmem should return size or something
  for (i=0;i<`BIT_STREAM_MEM_SIZE;i++) if (BitStreamMem[i] === 32'bx)  break;  
  NumWords = i;


  StreamOffset = BitStreamMem[0];
  
  $display("LoadBitstream: Loading bitstream from file %s",filename);
  
  // display for 20 words

  $display("Bit Stream Mem");
  
  for(i=0;i<30;i++) $display("%x ",BitStreamMem[i]);
  $display("\n");
  
  for(i=1;i<NumWords-1;i++) begin
    Mask = '1;
    
    CurrentWord = BitStreamMem[i];
    NextWord = BitStreamMem[i+1];
    
    if (i<=30) LongStream = {LongStream[16*30-16-1:0],CurrentWord};
    
    
    CurrentWord = CurrentWord << StreamOffset;
    NextWord = NextWord >> (16-StreamOffset);
    CurrentWord = CurrentWord | NextWord;
    
    BitStreamMem[i-1] = CurrentWord;
    
  end

  
  $display("Long Bit Stream Shifted Version");
    LongStream = LongStream << StreamOffset;
  for(i=0;i<30;i++) begin 
    CurrentWord = LongStream[16*30-1:16*30-16];
    if (CurrentWord == BitStreamMem[i])    $display("%x %x ok",CurrentWord,BitStreamMem[i]);
    else    $display("%x %x bad",CurrentWord,BitStreamMem[i]);
    LongStream = LongStream << 16;
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