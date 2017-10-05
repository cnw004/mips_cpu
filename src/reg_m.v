/*
module to act as our clk for the mem stage

inputs:
  - clk: our clock
  - in1: syscall
  - in2: reg write
  - in3: mem to reg
  - in4: memwrite
  - in5: aluout [31:0]
  - in6: writeDataE [31:0]
  - in7: writeRegE [4:0]
  - in8: a0
  - in9: v0
  - in10: Instruction

output:
- out1: syscall
- out2: reg write
- out3: mem to reg
- out4: memWrite
- out5: aluout [31:0]
- out6: writeDataE [31:0]
- out7: writeRegE [4:0]
- out8: a0
- out9: v0
- out10: Instruction
- out11: hazard_in_MemtoReg
- out12: hazard_in_RegWriteM
*/

module reg_m(input wire clk,
  input wire in1,
  input wire in2,
  input wire in3,
  input wire in4,
  input wire [31:0] in5,
  input wire [31:0] in6,
  input wire [4:0] in7,
  input wire [31:0] in8, //a0
  input wire [31:0] in9, //v0
  input wire [31:0] in10, //instruction
  output reg out1,
  output reg out2,
  output reg out3,
  output reg out4,
  output reg [31:0] out5,
  output reg [31:0] out6,
  output reg [4:0] out7,
  output reg [31:0] out8, //a0
  output reg [31:0] out9, //v0
  output reg [31:0] out10 //instruction);
  output reg out11,
  output reg out12);

  always @(posedge clk) begin
    out1 <= in1;
    out2 <= in2;
    out3 <= in3;
    out4 <= in4;
    out5 <= in5;
    out6 <= in6;
    out7 <= in7;
    out8 <= in8;
    out9 <= out9;
    out10 <= out10;
    out11 <= in3;
    out12 <= in2;
  end


endmodule
