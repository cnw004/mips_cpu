`include "mips.h" // various defines

/*
 This module wires together everything in the fetch stage.
 inputs:
   pc - output of the pc-deciding multiplexor
   enable - value of not stallF control signal from the hazard unit
   clk - The clock
 outputs:
   instr- The instruction read from memory - should get wired into reg_d.v
   pc_plus_4 - The PC incremented by 4 (next pc count) - should get wired into the pc generating mux, as well as another adder
 
 modules included:
   adder.v
   reg_f.v
   instruction_memory.v
 */
module fetch(
   input wire [31:0] pc,
   input wire enable,
   input wire clk, 
   output reg [31:0] instr,
   output reg [31:0] pc_plus_4);
   
   //interior wires
   wire [31:0] pc_f; // from reg_f to adder and instruction memory
   wire [31:0] constant_four = 32'b0100; // constant value of 4 for pc + 4
   
   
   //instantiating and wiring together modules
   reg_f so_fetch(clk, enable, pc,pc_f);
   adder plus_4(pc_f, constant_four, pc_plus_4);
   instruction_memory instr_mem(pc_f, instr);
   

   
   
 	     
