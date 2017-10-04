/*
 This module wires together everything in the decode stage.
 inputs:
   enable: value of not stallD control signal from the Hazard unit
   clear: value of PCSRC (Whether the PC is coming from a jump/branch or adder
   clk: our clock
   pc_plus_4: the possible next pc if not jump/branch
   instr: the instruction
   write_from_wb: writeback data from wb
   forwardAD: execute to decode rs
   forwardBD: execute to decode rt
 outputs:
  - out1: syscall
  - out2: reg write
  - out3: memToReg
  - out4: alu ctrl (2:0)
  - out5: aluSrc
  - out6: regDst
  - out7: output from register RD1
  - out8: output from register RD2
  - out9: RsD (25:21)
  - out10: RtD (20:16)
  - out11: RdE (15:11)
  - out12: SignImmD (31:0)
  - out13: memWrite
  - out14: if branching, the branch address 
  - out15: pcsrc
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
   input wire 	       clear,
   input wire 	       clk,
   input wire [31:0]   pc_plus_4,
   input wire [31:0]   instr,
   input wire [31:0]   write_from_wb,
   input wire [31:0]   alu_out,
   input wire [31:0]   forwardAD,
   input wire [31:0]   forwardBD,
   output wire 	       out1,
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
   output wire out15);

   // internal wires
   wire [31:0] 	     instrD; // our instr, released from decode register
   wire [31:0] 	     pc_plus_4_decoded; //pc_plus_4 post decode register
   wire [31:0] 	     write_data; // data to be written to the write_register
   wire [31:0] 	     equalD_rs_input; // output from rd1 mux
   wire [31:0] 	     equalD_rt_input; // output from rd2 mux
   wire [31:0] 	     equals_output; // output from the equals module.. branching logic	     
   //CONTROL SIGNALS
   wire 	     jump;
   wire 	     jal;
   wire 	     jumpRegister;
   wire 	     branch;
   wire 	     memRead;
   wire 	     memToReg;
   wire 	     memWrite;
   wire 	     regWrite;
   //from register
   wire [31:0] 	     v0; // the value in register v0 to be used  by syscall module
   wire [31:0] 	     a0; // the value in reg a0 to be used by syscall
   // from adder jal
   wire [31:0] 	     jal_address; // possible branch address
   //instantiating and wiring together modules
   reg_d decodes(clk, enable, clear, instr, pc_plus_4, istrD, pc_plus_4_decoded);
   control controller(instrD[31:26], instrD[5:0], out6, jump, jal, jumpRegister, branch, memRead, out3, out4, out13, out5, out2, out1); 
   registers regs(~clk, jal, out2, instrD[25:21], instrD[20:16], instrD[4:0], write_data, out7, out8, v0, a0);   
   sign_extend signs(instrD[15:0], out12);
   adder add_for_branch(out12 << 2, pc_plus_4_decoded, out14);
   adder add_for_jal(pc_plus_4_decoded, 32'd4, jal_address);
   mux write_mux(jal, write_from_wb, jal_address, write_data);
   mux rd1_mux(forwardAD, out7, aluOut, equalD_rs_input);
   mux rd2_mux(forwardBD, out8, aluOut, equalD_rt_input);
   equals branch_logic(equalD_rs_input, equalD_rt_input, equals_output);
   and_gate branch_and(equals_output, branch, out15);

   //assign remaining  out wires
	      
   assign out9 = instrD[25:21];
   assign out10 = instrD[20:16];
   assign out11 = instrD[15:11];
   
   

endmodule
