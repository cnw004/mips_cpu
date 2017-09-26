/*
module to perform the sign extend operation

inputs:
  - in: part of address to be extended

outputs:
  - out: the new shifted address
*/

module sign_extend(
  input wire [15:0] in,
  output reg [31:0] out);

//perform an extension
always @(in)
  begin
    out = {{16{in[15]}}, in[15:0]};
  end

endmodule
