/*
 This module wires together everything in the fetch stage, as well as jump/branch multiplexors.
 inputs:
   jump: jump control signal
   jump_reg: jump register control signal
   branch: branch control signal
   branch_addr: the address to branch to
   jump_reg_addr: the address to jump to if jr
   jump_addr: the address if j or jal
   enable: value of not stallF control signal from the hazard unit
   clk:  The clock
 outputs:
   instr: The instruction read from memory - should get wired into reg_d.v
   pc_plus_4:  The PC incremented by 4 (next pc count) - should get wired into the pc generating mux, as well as another adder
 modules included:
   adder.v
   reg_f.v
   instruction_memory.v
 */
module fetch(
   input wire 	     jump,
   input wire 	     jump_reg,
   input wire 	     branch,
   input wire [31:0] branch_addr,
   input wire [31:0] jump_reg_addr,
   input wire [31:0] jump_addr,
   input wire 	     enable,
   input wire 	     clk,
   input wire [31:0] string_index,
   input wire print_string,
   output wire [31:0] instr,
   output reg [31:0] pc_plus_4); // also gets used by jump_mux

   //interior wires
   wire [31:0] pc_f; // from reg_f to adder and instruction memory

   wire [31:0] constant_four = 32'd4; // constant value of 4 for pc + 4
   wire [31:0] if_jump; // address to jump to if jumping
   wire [31:0] jump_or_not; // jump address or pc+4
   wire [31:0] pc; // address result of jump/branch muxes
   // wire [31:0] instr_internal;
   wire [31:0] pc_plus_4_internal;

   initial begin
      //instr <= 0;
      // pc <= 32'h00400020;
      pc_plus_4 <= 32'h0040002;
   end


   always @(*) begin
      pc_plus_4 <= pc_plus_4_internal;
    //   instr <= instr_internal;
   end

   //instantiating and wiring together modules
   adder_four plus_4(pc_f, constant_four, pc_plus_4_internal);
   mux jump_reg_mux(jump_reg, jump_addr, jump_reg_addr, if_jump);
   mux jump_mux(jump, pc_plus_4_internal, if_jump, jump_or_not);
   mux next_pc(branch, jump_or_not, branch_addr, pc);
   reg_f so_fetch(clk, enable, pc,pc_f);

   instruction_memory instr_mem(pc_f, string_index, print_string, instr);

endmodule
