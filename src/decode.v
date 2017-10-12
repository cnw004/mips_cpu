/*
 This module wires together everything in the decode stage.
 inputs:
   enable: value of not stallD control signal from the Hazard unit
   clk: our clock
   pc_plus_4: the possible next pc if not jump/branch
   instr: the instruction
   write_from_wb: writeback data from wb
   alu_out: from alu_out in memory stage
   forwardAD: execute to decode rs
   forwardBD: execute to decode rt
   regWriteW: // regWrite control signal stemming from wb module
 outputs:
  - out1: syscall
  - out1a: the instruction for syscall
  - out1b: a0
  - out1c: v0
  - out2: reg write
  - out3: memToReg
  - out4: alu ctrl (2:0)
  - out5: aluSrc
  - out6: regDst
  - out7: output from register RD1, as well as jump register's address if JR
  - out8: output from register RD2
  - out9: RsD (25:21)
  - out10: RtD (20:16)
  - out11: RdE (15:11)
  - out12: SignImmD (31:0)
  - out13: memWrite
  - out14: if branching, the branch address
  - out15: pcsrc
  - out16: jump control signal
  - out17: jump register control signal
  - out18: branchD
  - out19: jump register address
  - out20: normal jump address
  - out21: RsD (25:21) output to hazard
  - out22: RtD (20:16) output to hazard


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
   input wire 	       enable,
   input wire 	       clk,
   input wire [31:0]   pc_plus_4_decoded,
   input wire [31:0]   instrD,
   input wire [31:0]   write_from_wb,
   input wire [31:0]   alu_out,
   input wire    forwardAD,
   input wire    forwardBD,
   input wire          regWriteW, // regWrite control signal stemming from wb module
   output wire 	       out1,
   output wire [31:0]  out1a,
   output wire [31:0]  out1b,
   output wire [31:0]  out1c,
   output wire 	       out2,
   output wire 	       out3,
   output wire [2:0]   out4,
   output wire 	       out5,
   output wire 	       out6,
   output wire [31:0]  out7,
   output wire [31:0]  out8,
   output wire [25:21] out9,
   output wire [20:16] out10,
   output wire [15:11] out11,
   output wire [31:0]  out12,
   output wire 	       out13,
   output wire [31:0]  out14,
   output wire 	       out15,
   output wire 	       out16,
   output wire 	       out17,
   output wire         out18,
   output wire [31:0]  out19,
   output wire [31:0]  out20,
   output wire [25:21] out21,
   output wire [20:16] out22
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
   control controller(instrD[31:26], instrD[5:0], out6, out16, jal, out17, out18, memRead, out3, out4, out13, out5, out2, out1);
   registers regs(~clk, jal, regWriteW, instrD[25:21], instrD[20:16], instrD[4:0], write_data, out7, out8, out1c, out1b);
   sign_extend signs(instrD[15:0], out12);
   adder add_for_branch(out12 << 2, pc_plus_4_decoded, out14);
   adder add_for_jal(pc_plus_4_decoded, 32'd4, jal_address);
   mux write_mux(jal, write_from_wb, jal_address, write_data);
   mux rd1_mux(forwardAD, out7, alu_out, equalD_rs_input);
   mux rd2_mux(forwardBD, out8, alu_out, equalD_rt_input);
   equals branch_logic(equalD_rs_input, equalD_rt_input, equals_output);
   and_gate branch_and(equals_output, out18, out15);

   //shift 2
   //assign remaining  out wires

   assign out21 = instrD[25:21];
   assign out9 = instrD[25:21];
   assign out22 = instrD[20:16];
   assign out10 = instrD[20:16];
   assign out11 = instrD[15:11];
   assign out20 = (instrD[25:0] << 2) + pc_plus_4_decoded;
   assign out1a = instrD;



endmodule
