/*
module to act as our clk for the write stage

inputs:
  - clk: our clock
  - in2: reg write
  - in3: mem to reg
  - in4: RD from data mem [31:0]
  - in5: ALUoutM [31:0]
  - in6: writeRegM [4:0]


output:
- out2: reg write
- out3: mem to reg
- out4: ReadDataW
- out5: ALUoutW [31:0]
- out6: writeRegW [4:0]
- out7: RegWriteW to hazard

*/

module reg_w(input wire clk,
  input wire in2,
  input wire in3,
  input wire [31:0] in4,
  input wire [31:0] in5,
  input wire [4:0] in6,
  input wire [31:0] instruction_in,
  input wire syscall_in,
  output reg out2,
  output reg out3,
  output reg [31:0] out4,
  output reg [31:0] out5,
  output reg [4:0] out6,
  output reg out7,
  output reg [31:0] instruction_out,
  output reg syscall_out);

  initial begin
    out2 <= 0;
    out3 <= 0;
    out4 <= 0;
    out5 <= 0;
    out6 <= 0;
    out7 <= 0;
    instruction_out <= 0;
    syscall_out <= 0;
  end

  always @(posedge clk) begin
    out2 <= in2;
    out3 <= in3;
    out4 <= in4;
    out5 <= in5;
    out6 <= in6;
    out7 <= in2;
    instruction_out <= instruction_in;
    syscall_out <= syscall_in;
  end


endmodule
