module FIFO (
  input logic Clk,
  input logic nReset,
  input logic DataReady,
  input logic [15:0] DataIn,
  input logic ReadFIFO,
  output logic [15:0] DataOut,
  output logic Full,
  output logic AlmostFull,           
  output logic Empty,
  output logic Overflow,
  output logic Underflow
);


// Registers for read/write counters.
logic             [2:0] WriteCnt;
logic [2:0]             ReadCnt,ReadCntComb;


// Number of Words in the FIFO
logic             [2:0] NumWords;

// Signals for Incrementing/Decrementing number of words in FIFO.
logic                  IncNumWords;
logic                  DecNumWords;

logic [15:0]           DataOutInt;


assign DataOut = (Overflow | Underflow) ? 16'h0000 : DataOutInt;



// FIFO Memories
FIFOMemory uFIFOMemory (
  .Clk                (Clk),
  .nReset             (nReset),
  .AddrWrite          (WriteCnt),
  .AddrRead           (ReadCnt),
  .DataIn             (DataIn),
  .WE                 (DataReady),
  .OE                 (1'b1),
  .DataOut            (DataOutInt)
);



// Status Bits.
// Full when all bits in NumWords are 1.
assign Full = &NumWords;
assign AlmostFull = (NumWords>=5);



// Empty when all bits in NumWords are 0.
assign Empty = ~|NumWords;

// Overflow when a write attempts and FIFO is full.
always_ff @(posedge Clk or negedge nReset)
  begin : OverUnderFlowCtrl
    if (!nReset) begin
      Overflow <= 1'b0;
      Underflow <= 1'b0;
    end
    else begin
      Overflow <= (Full & DataReady);
      Underflow <= (Empty & ReadFIFO);
    end
  end
      
// WriteCounter. Count 0-7.
always @(posedge Clk or negedge nReset)
  begin : WriteCounter
    if (!nReset) begin
      WriteCnt <= 3'b000;
    end else begin
      if (DataReady & !Full) begin
        WriteCnt <= WriteCnt + 3'b1;
      end
    end
  end

// ReadCounter. Count 0-7.
assign ReadCntComb = ReadCnt + 3'b1;
always @(posedge Clk or negedge nReset)
  begin : ReadCounter
    if (!nReset) begin
      ReadCnt <= 3'b000;
    end 
    else begin
      if (ReadFIFO & !Empty) begin
//        ReadCnt <= ReadCnt + 3'b1;
        ReadCnt <= ReadCntComb;
      end
    end
  end

assign IncNumWords = DataReady & ~&NumWords;
assign DecNumWords = ReadFIFO & |NumWords;

always_ff @(posedge Clk or negedge nReset)
  begin : WordCounter
    if (!nReset) begin 
      NumWords <= 3'b000;
    end
    else begin
      if (DecNumWords & !IncNumWords)      NumWords <= NumWords - 3'b1;
      else if (IncNumWords & !DecNumWords) NumWords <= NumWords + 3'b1;
    end 
  end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
   
endmodule  // FIFO