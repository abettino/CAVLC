module CAVLC (
              input  logic        Clk,              // Clock.
              input  logic        nReset,           // Async reset.
              input  logic        Enable,
              input  logic [15:0] Bitstream,    // Input bitstream data.
              output logic        RdReq,            // Read from the bistream source.
              output logic [12:0] LevelOut,         // Decoded level output.
              output logic        WrReq,            // Write to level buffer/fifo.
              output logic        BlockDone         // Current 4x4 block complere.
              );


logic [15:0]                      BitstreamShifted;
logic [4:0]                       TotalCoeff;
logic [1:0]                       TrailingOnes;
logic [4:0]                       NumShift_CoeffTokenDecode;
logic                             ShiftEn;
logic [4:0]                       NumShift;
logic                             BarrelShifterReady;
logic                             CoeffTokenDecodeEnable;
logic                             LevelDecodeEnable;
logic [4:0]                       NumShift_LevelDecode;
logic                             ShiftEn_LevelDecode;
logic                             LevelDecodeDone;
logic                             ShiftEn_ZeroDecoe;
logic [4:0]                       NumShift_ZeroDecode;
logic                             ZeroDecodeEnable;
logic                             ZeroDecodeDone;


CoeffTokenDecode uCoeffTokenDecode (
   .Clk             (Clk),
   .nReset          (nReset),
   .Enable          (CoeffTokenDecodeEnable),                               
   .BitstreamShifted(BitstreamShifted),
   .TotalCoeff      (TotalCoeff),
   .TrailingOnes    (TrailingOnes),
   .NumShift        (NumShift_CoeffTokenDecode)                                
);

BarrelShifter uBarrelShifter (
 .Clk                (Clk),
 .nReset             (nReset),
 .Bitstream          (Bitstream),
 .Enable             (Enable),
 .ShiftEn            (ShiftEn),
 .NumShift           (NumShift),
 .RdReq              (RdReq),
 .BitstreamShifted   (BitstreamShifted),
 .BarrelShifterReady (BarrelShifterReady)
);

CTRLFSM uCTRLFSM (
  .Clk                      (Clk),              
  .nReset                   (nReset),           
  .Enable                   (Enable),
  .BarrelShifterReady       (BarrelShifterReady),
  .NumShift_CoeffTokenDecode(NumShift_CoeffTokenDecode),
  .NumShift_LevelDecode     (NumShift_LevelDecode),               
  .ShiftEn_LevelDecode      (ShiftEn_LevelDecode),                
  .LevelDecodeDone          (LevelDecodeDone),
  .ShiftEn                  (ShiftEn),
  .NumShift                 (NumShift),
  .CoeffTokenDecodeEnable   (CoeffTokenDecodeEnable),                               
  .LevelDecodeEnable        (LevelDecodeEnable),
  .ZeroDecodeEnable         (ZeroDecodeEnable),            
  .NumShift_ZeroDecode      (NumShift_ZeroDecode),
  .ShiftEn_ZeroDecode       (ShiftEn_ZeroDecode),
  .ZeroDecodeDone           (ZeroDecodeDone)
);

LevelDecode uLevelDecode (
  .Clk                      (Clk),
  .nReset                   (nReset),
  .Enable                   (LevelDecodeEnable),
  .BitstreamShifted         (BitstreamShifted),
  .TotalCoeff               (TotalCoeff),
  .TrailingOnes             (TrailingOnes),
  .NumShift                 (NumShift_LevelDecode),
  .ShiftEn                  (ShiftEn_LevelDecode),
  .LevelOut                 (LevelOut),
  .WrReq                    (WrReq),
  .Done                     (LevelDecodeDone)
);

ZeroDecode uZeroDecode (
  .Clk             (Clk),
  .nReset          (nReset),
  .Enable          (ZeroDecodeEnable),
  .BitstreamShifted(BitstreamShifted),
  .TotalCoeff      (TotalCoeff),
  .NumShift        (NumShift_ZeroDecode),
  .ShiftEn         (ShiftEn_ZeroDecode),
  .Done            (ZeroDecodeDone)
);

endmodule