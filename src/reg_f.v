/*
module to act as our clk for the fetch stage

inputs:
  - enable: wire from hazard unit. decides if we should stall or not (passing in not stall)
  - pc_in: our program counter

output:
  - pc_out: our program counter, released after rising clk edge
*/

module reg_f(
  input wire clk,
  input wire enable,
  input wire [31:0] pc_in,
  output reg [31:0] pc_out);

  //init the value of the first pc
  initial begin
    pc_out = 32'h00400020;
  end

  //if posedge clk, and enabled, pass value through
  always @(posedge clk) begin
    if(enable)
      pc_out <= pc_in;
  end

endmodule
