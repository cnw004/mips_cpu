`include "mips.h" //various defines

/*
This module handles all control signals in our processor.

inputs:
  - opcode: 6 bits taken from the instruction that represent the opcode
  - funcCode: 6 bits takesn from the instruction that represent the function code

outputs:
  - regDst:
  - jump:
  - branch:
  - memRead:
  - memToReg:
  - aluOp:
  - memWrite:
  - aluSrc:
  - regWrite:
  - syscall:

*/
module control(
  input wire [31:26] opcode,
  input wire [5:0] funcCode,
  output reg regDst,
  output reg jump,
  output reg jal,
  output reg jumpRegister,
  output reg branch,
  output reg memRead,
  output reg memToReg,
  output reg [2:0] aluOp,
  output reg memWrite,
  output reg aluSrc,
  output reg regWrite,
  output reg syscall);

  always @ ( * ) begin

    //regDst
    regDst = (opcode == `SPECIAL); //any R-Type instruction

    //jump
    jump = (opcode == `J || opcode == `JAL || opcode == `JR) ? 1 : 0;

    //jumpAndLink
    jal = (opcode == `JAL) ? 1 : 0;

    //jump - register
    jumpRegister = (opcode == `JR);

    //branch
    branch = (opcode == `BEQ || opcode == `BNE) ? 1 : 0;

    //memRead
    memRead = (opcode == `LW);

    //memToReg
    memToReg = (opcode == `LW);

    //memWrite
    memWrite = (opcode == `SW);

    //aluSrc
    aluSrc = (opcode == `ADDI ||
             opcode == `ADDIU ||
              opcode == `ORI  ||
              opcode == `LW   ||
              opcode == `SW);

    //regWrite
    regWrite = (opcode == `SPECIAL || //any R-Type
                opcode == `ADDI ||
                opcode == `ADDIU ||
                opcode == `ORI ||
                opcode == `LW);

    //syscall
    syscall = ( opcode == 0 && funcCode == 6'hc ) ? 1 : 0;

    // //R typ instructions
    // if (opcode == 0)
    //   case (funcCode)
    //     6'h20: aluOp = 3'b010;
    //     6'h22: aluOp = 3'b110;
    //     6'h24: aluOp = 3'b000;
    //     6'h25: aluOp = 3'b001;
    //     6'h2a: aluOp = 3'b111;
    //     default: aluOp = 3'b000;
    //   endcase
    //
    // else
    //   case (opcode)
    //     6'h09: aluOp = 3'b010;
    //     6'h0d: aluOp = 3'b001;
    //     6'h23 || 6'h2b: aluOp = 3'b010;
    //     6'h04 || 6'h05: aluOp = 3'b110;
    //     default: aluOp = 3'b000;
    //   endcase

    //Logic for ALUop output
    if (opcode == `SPECIAL && funcCode == `AND)
        aluOp = `ALU_AND;
    else if((opcode == `SPECIAL && funcCode == `OR) || opcode == `ORI)
        aluOp = `ALU_OR;
    else if((opcode == `SPECIAL && funcCode == `ADD) || opcode == `ADDI || opcode == `ADDIU || opcode == `LW || opcode == `SW)
        aluOp = `ALU_add;
    else if((opcode == `SPECIAL && funcCode == `SUB) || opcode == `BEQ || opcode == `BNE)
        aluOp = `ALU_sub;
    else
        aluOp = `ALU_slt; //default case
  end

endmodule
