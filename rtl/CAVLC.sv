module CAVLC (
              input  logic        Clk,              // Clock.
              input  logic        nReset,           // Async reset.
              input  logic [15:0] BitstreamData,    // Input bitstream data.
              output logic        RdReq,            // Read from the bistream source.
              output logic [12:0] LevelOut,         // Decoded level output.
              output logic        WrReq,            // Write to level buffer/fifo.
              output logic        BlockDone         // Current 4x4 block complere.
              );

endmodule