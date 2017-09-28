/*
parameterized equals module

inputs:
  - input_0: first input to check if equals
  - input_1: second  input to check if equals
outputs:
  - equal_inputs: output depending on input_0 == input_1
*/
module equals(
  input wire [SIZE:0] input_0,
  input wire [SIZE:0] input_1,
  output reg [1:0] equal_inputs);

  //assume size is 31 unless otherwise specified
  parameter SIZE = 31;
  always @(*)
    equal_inputs = (input_0 == input_1);
endmodule
