//`include "mux.v"
/*
 This module wires together everything in the writeback stage.

 inputs:
   - MemToRegW: 1 bit decides whether ALUout or read data gets passed to ResultW
   - ReadDataW: data read from data_memory
   - ALUOutW: value output from the ALU
   - WriteRegW: register to be written to, passed to the hazard unit

 outputs:
   - WriteRegW_out: passing the reg into the hazard unit
   - ResultW: value to be passed and written into the register file

 modules included:
   mux.v
 */
module writeback(
   input wire MemToRegW,
   input wire [31:0] ReadDataW,
   input wire [31:0] ALUOutW,
   input wire [4:0] WriteRegW,
   output wire [4:0] WriteRegW_out,
   output wire [31:0] ResultW
   );

   mux my_mux(MemToRegW, ALUOutW, ReadDataW, ResultW);

   assign WriteRegW_out = WriteRegW;

endmodule
