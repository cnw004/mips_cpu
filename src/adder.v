/*
Simple adder module.

inputs:
  - in1: argument1 to be added
  - in2: argument2 to be added

output:
  - adder_out: in1 + in2
*/
module adder(
  input wire [31:0] in1,
  input wire [31:0] in2,
  output reg [31:0] adder_out);

  always @(in1)
    begin
      adder_out = in1 + in2;
    end
endmodule
