`ifndef __BitStreamGenerator__
`define __BitStreamGenerator__

`include "tbConfig.vh"

`define BIT_STREAM_MEM_SIZE 10000

class nCGenerator;
virtual CAVLCIntfc CAVLCIntfc;
logic [3:0] CurrentCoeffBlock [0:3];
logic [3:0] PrevCoeffBlock [0:3];
logic [3:0] PrevCoeffBlock2 [0:3];
logic [3:0] PrevCoeffBlock3 [0:3];

logic [3:0] UpperCoeffBlock[0:3];
logic [3:0] LeftCoeffBlock[0:3];
  
logic [3:0] AllCoeffs[(`HBLOCKS/4)*(`VBLOCKS/4)];


int         TotalCoeffMatrix[`HRES/4][`VRES/4];
  

int         HCount;
int         VCount;
int         HCountSB;
int         VCountSB;
int         SmallBlockCnt;
int         nA, nAAvail;
int         nB, nBAvail;
int         BigBlockCnt; 
int         BlockCnt;
int         XPos,YPos;
int         TotalBigBlocks;
int         TotalBlockCnt;
  

  function new(virtual CAVLCIntfc a);
    CAVLCIntfc = a;
  endfunction

virtual     task Init();
  $display("Init Coeff blocks");
  CAVLCIntfc.nC = 0;
  for (int i=0;i<4;i++) begin
    CurrentCoeffBlock[i] = 4'bx;
    PrevCoeffBlock[i] = 4'bx;
    PrevCoeffBlock2[i] = 4'bx;
    PrevCoeffBlock3[i] = 4'bx;
    LeftCoeffBlock[i] = 4'bx;
    UpperCoeffBlock[i] = 4'bx;
  end
  

endtask

virtual task Run();
  fork
    VCount=0;
    HCount=0;
    CAVLCIntfc.nC = 0;
    SmallBlockCnt = 0;
    BigBlockCnt = 0;
    XPos=0;
    YPos=0;
    TotalBigBlocks = 0;
    
    while (1) begin
      @(CAVLCIntfc.cb);
      
      if (XPos > 0) begin
        nAAvail = 1;
        nA = TotalCoeffMatrix[XPos-1][YPos];
      end
      else begin
        nAAvail = 0;
        nA = 0;
      end
      if (YPos > 0) begin
        nBAvail = 1;
        nB =  TotalCoeffMatrix[XPos][YPos-1];
      end
      else begin
        nBAvail = 0;
        nB =  0;
      end

      if (TotalBlockCnt==16 || TotalBlockCnt==17) begin
        CAVLCIntfc.nC = 5'b11111;
      end
//      else if (TotalBlockCnt==18 || TotalBlockCnt==19) begin
//        CAVLCIntfc.nC = 5'b11110;
//      end
      else begin
        if (nBAvail && nAAvail) begin 
          if ((nA + nB) & 'h1)    CAVLCIntfc.nC = (nA+nB)/2 + 1; // odd number
          else    CAVLCIntfc.nC = (nA+nB)/2;
        end
        else CAVLCIntfc.nC = nA+nB;
      end

      if (CAVLCIntfc.BlockDone && TotalBlockCnt < 16) begin
        TotalBlockCnt++;
        TotalCoeffMatrix[XPos][YPos] = CAVLCIntfc.TotalCoeffOut;
//        $display("XPos: %d, YPos: %d, SmallBlockCnt %d, BigBlockCnt %d TotalBigBlocks: %d, TotalCoeff: %d", XPos,YPos,SmallBlockCnt,BigBlockCnt,TotalBigBlocks,CAVLCIntfc.TotalCoeffOut);
        
        if (SmallBlockCnt==3) begin 
          SmallBlockCnt = 0;
          if (BigBlockCnt == 3) begin
            BigBlockCnt = 0;
            TotalBigBlocks++;
          end
          else begin
            BigBlockCnt++;
          end
        end
        else begin 
          SmallBlockCnt++;
        end
        
        if (BigBlockCnt == 0 || BigBlockCnt == 1) begin
          if (SmallBlockCnt == 0 || SmallBlockCnt==1)   YPos = 0;
          else           YPos = 1;
        end
        else begin
          if (SmallBlockCnt == 0 || SmallBlockCnt==1)          YPos = 2;
          else            YPos = 3;
        end

        if (BigBlockCnt==0 || BigBlockCnt==2) begin
          if (SmallBlockCnt == 0 || SmallBlockCnt==2)  XPos = 0+4*TotalBigBlocks;
          else            XPos = 1+4*TotalBigBlocks;
        end
        else begin
          if (SmallBlockCnt == 0 || SmallBlockCnt==2)   XPos = 2+4*TotalBigBlocks;
          else            XPos = 3+4*TotalBigBlocks;
        end
//        $display("XPos: %d, YPos: %d, SmallBlockCnt %d, BigBlockCnt %d TotalBigBlocks: %d", XPos,YPos,SmallBlockCnt,BigBlockCnt,TotalBigBlocks);
      end
      else begin
        if (CAVLCIntfc.BlockDone) begin
          if (TotalBlockCnt == 17) begin 
            TotalBlockCnt=0;
          end
          else begin 
            TotalBlockCnt++;
          end
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
int          LevelSim[16];
int          BlockCnt;
int          LevelCnt;
int          NumBlocks;
  
int          NumWords;
int          StreamOffset;  
int          error_cnt;
int          BitStreamDone;
  
logic [4:0]  nCArray[`BIT_STREAM_MEM_SIZE];
  

  function new(virtual CAVLCIntfc a);
    CAVLCIntfc = a;
  endfunction

virtual task Init();
  CAVLCIntfc.nReset <= '0;
  CAVLCIntfc.Bitstream <= '0;
  CAVLCIntfc.Enable <= '0;
  LevelCnt = 0;
  BlockCnt = 0;
  error_cnt = 0;                   
for(int i=0;i<16;i++) LevelSim[i] = 0;
endtask

virtual task ResetValues();
  LevelCnt=0;
  BlockCnt=0;
  
endtask

virtual task OutOfReset();
  repeat (100) @(CAVLCIntfc.cb);
  CAVLCIntfc.nReset <=  1'b1;
  repeat (10) @(CAVLCIntfc.cb);
//  CAVLCIntfc.Enable <=  1'b1;
  repeat (1) @(CAVLCIntfc.cb);
endtask

virtual task RunLevelCheck();
  

//  fork
//    while (1) begin
//    @(CAVLCIntfc.cb);
    if (CAVLCIntfc.WrReq) begin
      LevelSim[LevelCnt] = {{19{CAVLCIntfc.LevelOut[12]}},CAVLCIntfc.LevelOut};
      LevelCnt++;
    end
    if (CAVLCIntfc.BlockDone) begin
      for(int i=0;i<CAVLCIntfc.TotalCoeffOut;i++) begin
        if (LevelSim[i] !== Levels[i][BlockCnt]) begin
          $display("LEVEL CHECK ERROR: Block=%d, i=%d,Got=%d, Expected=%d at time=%d",BlockCnt,i,LevelSim[i],Levels[i][BlockCnt],$time);
          error_cnt++;
          $stop;
        end
      end

      if (error_cnt == 0) begin
        $display("LEVEL CHECKER: Block %d done with no error and %d Coeff",BlockCnt,CAVLCIntfc.TotalCoeffOut);
      end

      for(int i=0;i<16;i++) begin
        LevelSim[i] = 0;
      end
      LevelCnt = 0;
      BlockCnt++;
    end
//    end
//  join_none
endtask

virtual task Run(output int block_cnt_out);
int  count;
int  block_cnt;

  count = 0;
  block_cnt = 0;
  BitStreamDone = 0;

  CAVLCIntfc.nC <= nCArray[0];
  CAVLCIntfc.Bitstream <= BitStreamMem[0];
  
//  repeat (10) @(CAVLCIntfc.cb);
  repeat (1) @(CAVLCIntfc.cb);

  CAVLCIntfc.Enable <= '1;
  $display("Run top!\n");

  
  
//  fork
    while (1) begin
      @(CAVLCIntfc.cb);
      CAVLCIntfc.Bitstream <= BitStreamMem[count];
      RunLevelCheck();
      if (CAVLCIntfc.RdReq) begin
        count++;
      end

//      if (NumBlocks == 1) begin
//        repeat (3) @(CAVLCIntfc.cb);
//        CAVLCIntfc.Enable <= '0;        
//      end

      if (CAVLCIntfc.BlockDone) begin
        block_cnt++;
        CAVLCIntfc.nC <= nCArray[block_cnt];
        $display("block_cnt: %d NumBlocks: %d nC: %d",block_cnt,NumBlocks,nCArray[block_cnt]);
//        if (block_cnt == NumBlocks-1 || block_cnt==NumBlocks) begin
        if (block_cnt == NumBlocks) begin
          CAVLCIntfc.Enable <= '0;        
          if (block_cnt==1) repeat (3) @(CAVLCIntfc.cb);
        end
      end
      if (block_cnt == NumBlocks) begin 
        BitStreamDone = 1;
        break;
      end
      
    end
//  join_none

  block_cnt_out = block_cnt;
  
  
endtask

virtual function int LoadBitstream(input string filename);
int     i;
logic [16*30-1:0] LongStream;
logic [15:0] CurrentWord;
logic [15:0] NextWord;
int          res;
logic [15:0] Mask;
  
  // clear mem.
  for (i=0;i<`BIT_STREAM_MEM_SIZE;i++) BitStreamMem[i] = 32'bx;

  $readmemh(filename,BitStreamMem);
  
  if (BitStreamMem[0] === 'x) begin
    return 0; //bad load.
  end

  // find the size. isn't there a better way for this? readmem should return size or something
  for (i=0;i<`BIT_STREAM_MEM_SIZE;i++) if (BitStreamMem[i] === 32'bx)  break;  
  NumWords = i;


  StreamOffset = BitStreamMem[0];
  
  $display("LoadBitstream: Loading bitstream from file %s",filename);
  
  // display for 20 words

//  $display("Bit Stream Mem");
  
//  for(i=0;i<30;i++) $display("%x ",BitStreamMem[i]);
//  $display("\n");
  
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

  
/*
  $display("Long Bit Stream Shifted Version");
    LongStream = LongStream << StreamOffset;
  for(i=0;i<30;i++) begin 
    CurrentWord = LongStream[16*30-1:16*30-16];
    if (CurrentWord == BitStreamMem[i])    $display("%x %x ok",CurrentWord,BitStreamMem[i]);
    else    $display("%x %x bad",CurrentWord,BitStreamMem[i]);
    LongStream = LongStream << 16;
  end
*/
  return 1; //good load

endfunction

virtual function LoadLevels(input string filename);
int     file, cnt;
  file = $fopen(filename,"r");
  cnt = 0;
  $display("LoadLevels: Loading levels from file %s",filename);
  if (file)  begin
  while (!$feof(file)) begin
    $fscanf(file,"%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d\n",
            nCArray[cnt],Levels[0][cnt],Levels[1][cnt],Levels[2][cnt],Levels[3][cnt],
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
  
  NumBlocks = cnt;
  $fclose(file);
  
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

virtual function DisplaynC(int num);
  $display("DisplaynC");
  for(int i=0;i<num;i++) begin
    $display("%d",nCArray[i]);
  end

endfunction

endclass

`endif