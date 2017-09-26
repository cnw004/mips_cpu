/*
module to act as our clk for the execute stage

inputs:
  - clk: our clock
  - clr: wire from hazard unit. decides if we should flush
  - in1: memread
  - in2: syscall
  - in3: reg write
  - in4: memToReg
  - in5: alu ctrl (2:0)
  - in6: aluSrc
  - in7: regDst
  - in8: output from register RD1
  - in9: output from register RD2
  - in10: RsD (25:21)
  - in11: RtD (20:16)
  - in12: RdE (15:11)
  - in13: SignImmD (31:0)

output:
- out1: memread
- out2: syscall
- out3: reg write
- out4: memToReg
- out5: alu ctrl (2:0)
- out6: aluSrc
- out7: regDst
- out8: output from register RD1
- out9: output from register RD2
- out10: RsD (25:21)
- out11: RtD (20:16)
- out12: RdE (15:11)
- out13: SignImmD (31:0)
*/

module clk_f(input wire clk,
  input wire clr,
  input wire in1,
  input wire in2,
  input wire in3,
  input wire in4,
  input wire in5,
  input wire in6,
  input wire in7,
  input wire [31:0] in8,
  input wire [31:0] in9,
  input wire [25:21] in10,
  input wire [20:16] in11,
  input wire [15:11] in12,
  input wire [31:0] in13,
  output reg out1,
  output reg out2,
  output reg out3,
  output reg out4,
  output reg out5,
  output reg out6,
  output reg out7,
  output reg [31:0] out8,
  output reg [31:0] out9,
  output reg [25:21] out10,
  output reg [20:16] out11,
  output reg [15:11] out12,
  output reg [31:0] out13);

  always @(clr, negedge clk) begin
    out1 = in1;
    out2 = in2;
    out3 = in3;
    out4 = in4;
    out5 = in5;
    out6 = in6;
    out7 = in7;
    out8 = in8;
    out9 = in9;
    out10 = in10;
    out11 = in11;
    out12 = in12;
    out13 = in13;
  end


endmodule
