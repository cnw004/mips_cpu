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

  //initialize
  initial begin
    regDst <= 0;
    jump <= 0;
    jal <= 0;
    jumpRegister <= 0;
    branch <= 0;
    memRead <= 0;
    memToReg <= 0;
    aluOp <= 0;
    memWrite <= 0;
    aluSrc <= 0;
    regWrite <= 0;
    syscall <= 0;
  end

  always @ ( * ) begin

    //regDst
    regDst <= (opcode == `SPECIAL); //any R-Type instruction

    //jump
    jump <= (opcode == `J || opcode == `JAL  || opcode == `SPECIAL && funcCode == `JR) ? 1 : 0;

    //jumpAndLink
    jal <= (opcode == `JAL ) ? 1 : 0;

    //jump - register
    jumpRegister <= (opcode == `SPECIAL && funcCode == `JR);

    //branch
    branch <= (opcode == `BEQ || opcode == `BNE) ? 1 : 0;

    //memRead
    memRead <= (opcode == `LW);

    //memToReg
    memToReg <= (opcode == `LW);

    //memWrite
    memWrite <= (opcode == `SW);

    //aluSrc
    aluSrc <= (opcode == `ADDI ||
             opcode == `ADDIU ||
              opcode == `ORI  ||
              opcode == `LW   ||
              opcode == `SW   ||
              opcode == `LUI);

    //regWrite
    regWrite <= (opcode == `SPECIAL || //any R-Type
                opcode == `ADDI ||
                opcode == `ADDIU ||
                opcode == `ORI ||
                opcode == `LW ||
                opcode == `LUI);

    //syscall
    syscall <= ( opcode == 0 && funcCode == 6'hc ) ? 1 : 0;

    //Logic for ALUop output
    if (opcode == `SPECIAL && funcCode == `AND)
        aluOp <= `ALU_AND;
    else if((opcode == `SPECIAL && funcCode == `OR) || opcode == `ORI)
        aluOp <= `ALU_OR;
    else if((opcode == `SPECIAL && funcCode == `ADD) || opcode == `ADDI || opcode == `ADDIU || opcode == `LW || opcode == `SW)
        aluOp <= `ALU_add;
    else if((opcode == `SPECIAL && funcCode == `SUB) || opcode == `BEQ || opcode == `BNE)
        aluOp <= `ALU_sub;
    else if(opcode == `LUI)
        aluOp <= 3;
    else
        aluOp <= `ALU_slt; //default case
  end

endmodule
