/*
parameterized 3 input mux module

inputs:
  - ctrl: decides which input to pass to out
  - input_00: this input will be passed out if ctrl is 00
  - input_01: this input will be passed out if ctrl is 01
  - input_10: this input will be passed out if ctrl is 10

outputs:
  - out: either input_00, input_01, input_10 depending on ctrl
*/
module mux3(
  input wire [1:0] ctrl,
  input wire [SIZE:0] input_00,
  input wire [SIZE:0] input_01,
  input wire [SIZE:0] input_10,
  output reg [SIZE:0] out);

  //assume size is 31 unless otherwise specified
  parameter SIZE = 31;

  initial begin
    out <= 0;
  end
  
  always @(*)
    begin
      case (ctrl)
        (2'b00): out = input_00;
        (2'b01): out = input_01;
        (2'b10): out = input_10;
      endcase
    end
endmodule
