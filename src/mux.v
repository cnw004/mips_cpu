/*
parameterized mux module

inputs:
  - ctrl: decides which input to pass to out
  - input_zero: this input will be passed out if ctrl is 0
  - input_one: this input will be passed out if ctrl is 1

outputs:
  - out: either input_zero or input_one depending on ctrl
*/
module mux(
  input wire ctrl,
  input wire [SIZE:0] input_zero,
  input wire [SIZE:0] input_one,
  output reg [SIZE:0] out);

  //assume size is 31 unless otherwise specified
  parameter SIZE = 31;

  initial begin
    out <= 0;
  end

  always @(*)
    begin
      out <= (ctrl == 0 ? input_zero : input_one);
    end
endmodule
