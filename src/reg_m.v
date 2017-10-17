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
  - in10: Instruction
  - RsE: register source from the E stage

output:
- out1: syscall
- out2: reg write
- out3: mem to reg
- out4: memWrite
- out5: aluout [31:0]
- out6: writeDataE [31:0]
- out7: writeRegE [4:0]
- out10: Instruction
- out11: hazard_in_MemtoReg
- out12: hazard_in_RegWriteM
- RsM: register source for the M stage
*/

module reg_m(input wire clk,
  input wire in1,
  input wire in2,
  input wire in3,
  input wire in4,
  input wire [31:0] in5,
  input wire [31:0] in6,
  input wire [4:0] in7,
  input wire [31:0] in10,
  input wire [4:0] RtE,
  output reg out1,
  output reg out2,
  output reg out3,
  output reg out4,
  output reg [31:0] out5,
  output reg [31:0] out6,
  output reg [4:0] out7,
  output reg [31:0] out10,
  output reg out11,
  output reg out12,
  output reg [4:0] RtM,
  output reg hazard_in_MemWriteM);


  initial begin
    out1 <= 0;
    out2 <= 0;
    out3 <= 0;
    out4 <= 0;
    out5 <= 0;
    out6 <= 0;
    out7 <= 0;
    out10 <= 0;
    out11 <= 0;
    out12 <= 0;
    RtM <= 0;
    hazard_in_MemWriteM <= 0;
  end

  always @(posedge clk) begin
    out1 <= in1;
    out2 <= in2;
    out3 <= in3;
    out4 <= in4;
    out5 <= in5;
    out6 <= in6;
    out7 <= in7;
    out10 <= in10;
    out11 <= in3;
    out12 <= in2;
    RtM <= RtE;
    hazard_in_MemWriteM <= in4;
  end


endmodule
