/*
module to perform all ALU operations

inputs:
  - read_data1: operand1
  - read_data2: operand2
  - aluOp: operator

outputs:
  - result: operand1 operator operand2
  - zero: this is 0 if it is not a valid alu op
*/
module alu(
  input wire [31:0] read_data1,
  input wire [31:0] read_data2,
  input wire [2:0] aluop,
  output reg [31:0] result);

  // assign zero = (result == 0);
  always @(*) begin
    case(aluop)
      //and
      3'b000: result <= read_data1 & read_data2;
      //or
      3'b001: result <= read_data1 | read_data2;
      //add
      3'b010: result <= read_data1 + read_data2;
      //sub
      3'b110: result <= read_data1 - read_data2;
      //shift left
      3'b111: result <= read_data1 < read_data2 ? 1:0;
      default: result <= 0;
    endcase
  end

endmodule
