/*
super simple module to act as an and gate

inputs:
  - a: operand1
  - b: operand2

outputs:
  - c: a & b
*/
module and_gate(
  input wire a,
  input wire b,
  output wire c);

  assign c = a & b;

endmodule
