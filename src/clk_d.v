/*
module to act as our clk for the decode stage

inputs:
  - in1: our instruction
  - enable: wire from hazard unit. decides if we should stall or not (pass in not stalld)

output:
  - out1: our instruction, released after falling clk edge
*/

module clk_f(
  input wire clk,
  input wire enable,
  input wire clr,
  input wire [31:0] in1,
  output reg [31:0] out1);

  //if clr, just pass it through no matter what
  always @(clr) begin
    if(clr)
      out1 = in1;
  end

  //at negedge clk, pass value through
  always @(negedge clk) begin
    if(enable)
      out1 = in1;
  end

endmodule
