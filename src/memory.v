`include "data_memory.v"
/*
 This module wires together everything in the memory stage.

 inputs:
   - RegWriteM: 1 bit from control, do we reg write?
   - MemToRegM: 1 bit from control, do we pull from mem and put in reg?
   - MemWriteM: 1 bit from control, do we write to mem?
   - ALUOutM: 32 bit, output from ALU
   - WriteDataM: 32 bit, data to be written to mem
   - WriteRegM: 5 bit, reg to write to

 outputs:
  - output wire RegWriteW: passing regWrite into the W stage
  - MemtoRegM_out: passing MemToReg to the W stage
  - RD: output from data memory, data read
  - WriteRegM_out: reg to be passed into hazard unit

 modules included:
   data_memory.v
 */
module memory(
  input wire RegWriteM,
  input wire MemToRegM,
  input wire MemWriteM,
  input wire [31:0] ALUOutM,
  input wire [31:0] WriteDataM,
  input wire [4:0] WriteRegM,
  output wire RegWriteW,
  output wire MemtoRegM_out,
  output wire [31:0] RD,
  output wire [4:0] WriteRegM_out
  );

  data_memory my_data_memory(MemWriteM, ALUOutM, WriteDataM, RD);

  assign WriteRegM = WriteRegM_out;
  assign ALUOutW = ALUOutM;
  assign MemToRegM = MemtoRegM_out;


endmodule
