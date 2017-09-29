/*
 This module wires together everything in the decode stage.
 inputs:
   enable: value of not stallD control signal from the Hazard unit
   clear: value of PCSRC (Whether the PC is coming from a jump/branch or adder
   clk: our clock
   pc_plus_4: the possible next pc if not jump/branch
   instr: the instruction
 outputs:
  - clk: our clock
  - clr: wire from hazard unit. decides if we should flush
  - in1: syscall
  - in2: reg write
  - in3: memToReg
  - in4: alu ctrl (2:0)
  - in5: aluSrc
  - in6: regDst
  - in7: output from register RD1
  - in8: output from register RD2
  - in9: RsD (25:21)
  - in10: RtD (20:16)
  - in11: RdE (15:11)
  - in12: SignImmD (31:0)
  - in13: memWrite
 
 
 modules included:
   registers.v 
   sign_extend.v
   control.v
   adder.v
   mux.v (x2)
   and_gate.v 
   equals.v
 
 
*/

module decode(
   input wire enable,
   input wire clear,
   input wire clk,
   input wire [31:0] pc_plus_4,
   input wire [31:0] instr);
   
   // internal wires
      // TO DO: this

   //instantiating and wiring together modules
       // TO DO: this
   registers regs(clk, ); // still need regwrite control signal or no? 
   
   
    
	      

	      // shift the sign extend before sending it to the adder
