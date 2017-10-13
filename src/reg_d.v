/*
module to act as our clk for the decode stage

inputs:
  - enable: wire from hazard unit. decides if we should stall or not (pass in not stalld)
  - in1: our instruction
  - in2: pc+4


output:
  - out1: our instruction, released after rising clk edge
  - out2: pc+4 after rising clk
*/

module reg_d(
  input wire clk,
  input wire enable,
  input wire clr,
  input wire [31:0] in1,
  input wire [31:0] in2,
  output reg [31:0] out1,
  output reg [31:0] out2);


  initial begin
    out1 <= 0;
    out2 <= 0;
  end

  //at negedge clk, pass value through
  always @(posedge clk) begin
    if(clr) begin
      out1 <= 0;
      out2 <= 0;
    end
    if(enable) begin
      out1 <= in1;
      out2 <= in2;
    end
  end

endmodule
