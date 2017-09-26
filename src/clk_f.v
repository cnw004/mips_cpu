/*
module to act as our clk for the fetch stage

inputs:
  - pc: our program counter
  - stall_f: wire from hazard unit. decides if we should stall or not

output:
  - pc_f: our program counter, released after falling clk edge
*/

module clk_f(input wire clk, input wire stall_f, input wire [31:0] pc, output reg pc_f);

  always @(negedge clk) begin
    if(!stall_f)
      pc_f = pc;
  end

endmodule
