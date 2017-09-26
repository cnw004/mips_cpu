/*
module to act as instruction memory and set up instruction reads

inputs:
  - addr: the address read in from add_test.v

outputs:
  - instruction: instruction to be executed
*/

module instruction_memory(
  input wire [31:0] addr,
  output reg [31:0] instruction);

  //instantiate the memory
  reg [31:0] memory [32'h100000:32'h101000];

  //this will hold the word address
  reg [31:0] real_addr;

  //change into a word address
  always @(addr)
    begin
        real_addr = addr >> 2;
        instruction = memory[real_addr];
    end

  //read instructions
  initial
    begin
      $readmemh("add_test.v", memory);
    end

endmodule
