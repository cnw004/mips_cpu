/*
module to act as our clk for the execute stage

dont think we need syscall or memread inputs here, those are handled in execute
inputs:
  - clk: our clock
  - in1: reg write
  - in2: mem to reg
  - in3: memwrite
  - in4: aluout [31:0]
  - in5: writeDataE [31:0]
  - in6: writeRegE [4:0]

output:
- out1: reg write
- out2: mem to reg
- out3: memWrite
- out4: aluout [31:0]
- out5: writeDataE [31:0]
- out6: writeRegE [4:0]
*/

module clk_f(input wire clk,
  input wire in1,
  input wire in2,
  input wire in3,
  input wire [31:0] in4,
  input wire [31:0] in5,
  input wire [4:0] in6,
  output reg out1,
  output reg out2,
  output reg out3,
  output reg [31:0] out4,
  output reg [31:0] out5,
  output reg [4:0] out6);

  always @(negedge clk) begin
    out1 = in1;
    out2 = in2;
    out3 = in3;
    out4 = in4;
    out5 = in5;
    out6 = in6;
  end


endmodule
