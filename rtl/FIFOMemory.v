module FIFOMemory (

  // Input(s)
  Clk,
  nReset,
  AddrWrite,
  AddrRead,
  DataIn,
  WE,
  OE,
  // Output(s)
  DataOut

);

// Input(s)

// System clock.
input                 Clk;

// System reset.
input                 nReset;

// Address to write to.
input           [2:0] AddrWrite;

// Address to read from.
input           [2:0] AddrRead;

// Data to Write.
input          [15:0] DataIn;

// Write Enable Signal, active high
input                 WE;

// Read Enable Signal, active high
input                 OE;

// Output(s)

// Data Output.
output         [15:0] DataOut;

// Memory.
reg            [15:0] Memory[7:0];

// Registered Data Output.
reg            [15:0] DataOut;

// Main body

// FIFO Memory.
always @(posedge Clk or negedge nReset)
  begin : FIFOMemoryBlock
        if (!nReset) begin
          Memory[0] <= 16'h0000;
          Memory[1] <= 16'h0000;
          Memory[2] <= 16'h0000;
          Memory[3] <= 16'h0000;
          Memory[4] <= 16'h0000;
          Memory[5] <= 16'h0000;
          Memory[6] <= 16'h0000;
          Memory[7] <= 16'h0000;
          DataOut <= 16'h0000;
        end 
        else begin
          if (WE) begin
            case (AddrWrite)
                  3'b000 : Memory[0] <= DataIn;
                  3'b001 : Memory[1] <= DataIn;
                  3'b010 : Memory[2] <= DataIn;
                  3'b011 : Memory[3] <= DataIn;
                  3'b100 : Memory[4] <= DataIn;
                  3'b101 : Memory[5] <= DataIn;
                  3'b110 : Memory[6] <= DataIn;
                  3'b111 : Memory[7] <= DataIn;
            endcase
          end 

        end
  end

always @* begin
  if (OE) begin
    case (AddrRead)
      3'b000 : DataOut = Memory[0];        
      3'b001 : DataOut = Memory[1];
      3'b010 : DataOut = Memory[2];
      3'b011 : DataOut = Memory[3];
      3'b100 : DataOut = Memory[4];        
      3'b101 : DataOut = Memory[5];
      3'b110 : DataOut = Memory[6];
      3'b111 : DataOut = Memory[7];
    endcase 
  end
end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

endmodule  // FIFOMemory