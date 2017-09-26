/*
module to act as our clk for the fetch stage

inputs:
  - in1: our program counter
  - enable: wire from hazard unit. decides if we should stall or not (passing in not stall)

output:
  - out1: our program counter, released after falling clk edge
*/

module clk_f(
  input wire clk,
  input wire enable,
  input wire [31:0] in1,
  output reg [31:0] out1);

  //if negedge clk, pass value through
  always @(negedge clk) begin
    if(enable)
      out1 = in1;
  end

endmodule
