//`include "data_memory.v"
/*
 This module wires together everything in the memory stage.

 inputs:
   - syscall: 1 bit from control, is it a syscall?
   - RegWriteM: 1 bit from control, do we reg write?
   - MemToRegM: 1 bit from control, do we pull from mem and put in reg?
   - MemWriteM: 1 bit from control, do we write to mem?
   - ALUOutM: 32 bit, output from ALU
   - WriteDataM: 32 bit, data to be written to mem
   - WriteRegM: 5 bit, reg to write to
   - instruction: the raw instruction passed all the way through to handle syscalls
   - v0: the value in the v0 reg passed through to handle syscall
   - a0: the value in the a0 reg passed through to handle syscall

 outputs:
  - output wire RegWriteW: passing regWrite into the W stage
  - MemtoRegM_out: passing MemToReg to the W stage
  - RD: output from data memory, data read
  - WriteRegM_out: reg to be passed into writeback register
  - WriteRegM_out_hazard: reg to be passed into hazard unit
  - ALUOutW: Passes ALUOutput to the W stage
  - ALUOut_forwarded: Passed to exec stage


 modules included:
   data_memory.v
 */
module memory(
  input wire syscall,
  input wire RegWriteM,
  input wire MemToRegM,
  input wire MemWriteM,
  input wire [31:0] instruction,
  input wire [31:0] ALUOutM,
  input wire [31:0] WriteDataM,
  input wire [4:0] WriteRegM,
  input wire ForwardMM,
  input wire [31:0] ResultW,
  output wire RegWriteW,
  output wire MemtoRegM_out,
  output wire [31:0] RD,
  output wire [4:0] WriteRegM_out,
  output wire [4:0] WriteRegM_out_hazard,
  output wire [31:0] ALUOutW,
  output reg [31:0] ALUOut_forwarded,
  output wire [31:0] instruction_out,
  output wire syscall_out
  );

  wire [31:0] WriteDataMuxOut;
  data_memory my_data_memory(MemWriteM, ALUOutM, WriteDataMuxOut, RD);
  mux forwardMM_mux(ForwardMM, WriteDataM, ResultW, WriteDataMuxOut);

  assign WriteRegM_out = WriteRegM ;
  assign WriteRegM_out_hazard = WriteRegM ;
  assign ALUOutW = ALUOutM;
  assign MemtoRegM_out = MemToRegM;
  assign syscall_out = syscall;
  assign RegWriteW = RegWriteM;
  assign instruction_out = instruction;
  assign syscall_out = syscall;

  always @(*)
    ALUOut_forwarded <= ALUOutM;

  initial begin
      ALUOut_forwarded <= 32'b0;
  end


endmodule
