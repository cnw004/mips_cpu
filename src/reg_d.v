/*
module to act as our clk for the decode stage

inputs:
  - enable: wire from hazard unit. decides if we should stall or not (pass in not stalld)
  - instruction_in: our instruction
  - pc_plus_4_in: pc+4


output:
  - pc_out: our instruction, released after rising clk edge
  - pc_plus_4_out: pc+4 after rising clk
*/

module reg_d(
  input wire clk,
  input wire enable,
  input wire clr,
  input wire [31:0] instruction_in,
  input wire [31:0] pc_plus_4_in,
  output reg [31:0] pc_out,
  output reg [31:0] pc_plus_4_out);

  initial begin
    pc_out <= 0;
    pc_plus_4_out <= 0;
  end

  //at posedge clk, pass value through(if enable)
  always @(posedge clk) begin
    if(clr) begin
      pc_out <= 0;
      pc_plus_4_out <= 0;
    end

    if(enable) begin
      pc_out <= instruction_in;
      pc_plus_4_out <= pc_plus_4_in;
    end
  end

endmodule
