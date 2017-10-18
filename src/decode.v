/*
 This module wires together everything in the decode stage.
 inputs:
   clk: our clock
   pc_plus_4: the possible next pc if not jump/branch
   instr: the instruction
   write_from_wb: writeback data from wb
   alu_out: from alu_out in memory stage
   forwardAD: execute to decode rs
   forwardBD: execute to decode rt
   regWriteW: // regWrite control signal stemming from wb module
 outputs:
  - syscall_out: syscall
  - syscall_instr_out: the instruction for syscall
  - a0_out: a0
  - v0_out: v0
  - a1_out: a1
  - regWrite_out: reg write
  - mem_to_reg_out: memToReg
  - alu_ctrl_out: alu ctrl (2:0)
  - alu_src_out: aluSrc
  - reg_dst_out: regDst
  - rd1_out: output from register RD1, as well as jump register's address if JR
  - rd2_out: output from register RD2
  - rsd_out: RsD (25:21)
  - rtd_out: RtD (20:16)
  - rde_out: RdE (15:11)
  - sign_immd_out: SignImmD (31:0)
  - mem_write_out: memWrite
  - branch_addr_out: if branching, the branch address
  - pc_src_out: pcsrc
  - pc_src_to_decode_out: pcsrc to decode register
  - jump_control_out: jump control signal
  - jr_control_out: jump register control signal
  - branch_d_out: branchD
  - jump_reg_addr_out: jump register address
  - jump_addr_out: normal jump address
  - rsd_hazard_out: RsD (25:21) output to hazard
  - rtd_hazard_out: RtD (20:16) output to hazard


 modules included:
   registers.v
   sign_extend.v
   control.v
   adder.v (x2)
   mux.v (x3)
   and_gate.v
   equals.v


*/

module decode(
   input wire 	       clk,
   input wire [31:0]   pc_plus_4_decoded,
   input wire [31:0]   instrD,
   input wire [31:0]   write_from_wb,
   input wire [31:0]   alu_out,
   input wire [4:0]    write_register,
   input wire    forwardAD,
   input wire    forwardBD,
   input wire          regWriteW, // regWrite control signal stemming from wb module
   output wire 	       syscall_out,
   output wire [31:0]  syscall_instr_out,
   output wire [31:0]  a0_out,
   output wire [31:0]  v0_out,
   output wire [31:0]  a1_out,
   output wire 	       regWrite_out,
   output wire 	       mem_to_reg_out,
   output wire [2:0]   alu_ctrl_out,
   output wire 	       alu_src_out,
   output wire 	       reg_dst_out,
   output wire [31:0]  rd1_out,
   output wire [31:0]  rd2_out,
   output wire [25:21] rsd_out,
   output wire [20:16] rtd_out,
   output wire [15:11] rde_out,
   output wire [31:0]  sign_immd_out,
   output wire 	       mem_write_out,
   output wire [31:0]  branch_addr_out,
   output wire 	       pc_src_out,
   output wire           pc_src_to_decode_out,
   output wire 	       jump_control_out,
   output wire 	       jr_control_out,
   output wire         branch_d_out,
   output wire [31:0]  jump_reg_addr_out,
   output wire [31:0]  jump_addr_out,
   output wire [25:21] rsd_hazard_out,
   output wire [20:16] rtd_hazard_out
);

   // internal wires
   wire [31:0] 	     write_data; // data to be written to the write_register
   wire [31:0] 	     equalD_rs_input; // output from rd1 mux
   wire [31:0] 	     equalD_rt_input; // output from rd2 mux
   wire  	     equals_output; // output from the equals module.. branching logic

   //CONTROL SIGNALS
   wire 	     memRead;
   wire        jal;

   //from register
   wire [31:0] 	     v0; // the value in register v0 to be used  by syscall module
   wire [31:0] 	     a0; // the value in reg a0 to be used by syscall

   // from adder jal
   wire [31:0] 	     jal_address; // possible branch address

   //instantiating and wiring together modules
   control controller(instrD[31:26], instrD[5:0], reg_dst_out, jump_control_out, jal, jr_control_out, branch_d_out, memRead, mem_to_reg_out, alu_ctrl_out, mem_write_out, alu_src_out, regWrite_out, syscall_out);
   registers regs(~clk, jal, regWriteW, instrD[25:21], instrD[20:16], write_register, write_from_wb, jal_address, rd1_out, rd2_out, v0_out, a0_out, a1_out);
   sign_extend signs(instrD[15:0], sign_immd_out);
   adder add_for_branch(sign_immd_out << 2, pc_plus_4_decoded, branch_addr_out);
   adder add_for_jal(pc_plus_4_decoded, 32'd4, jal_address);

   //simply passing another value into registers to handle jal writeback
   // mux write_mux(jal, write_from_wb, jal_address, write_data);
   mux rd1_mux(forwardAD, rd1_out, alu_out, equalD_rs_input);
   mux rd2_mux(forwardBD, rd2_out, alu_out, equalD_rt_input);
   equals branch_logic(equalD_rs_input, equalD_rt_input, equals_output);
   and_gate branch_and(equals_output, branch_d_out, pc_src_out);

   //assign remaining  out wires

   assign rsd_hazard_out = instrD[25:21];
   assign rsd_out = instrD[25:21];
   assign rtd_hazard_out = instrD[20:16];
   assign rtd_out = instrD[20:16];
   assign rde_out = instrD[15:11];
   assign jump_addr_out = {pc_plus_4_decoded[31:28], (instrD[25:0]), 2'h0};
   assign syscall_instr_out = instrD;
   assign jump_reg_addr_out = regs.reg_mem[rd1_out]; //rd1_out = JR address
   assign pc_src_to_decode_out = pc_src_out;



endmodule
