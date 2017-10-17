/*
module to act as instruction memory and set up instruction reads

inputs:
  - addr: the address read in from reg_f.v

outputs:
  - instruction: instruction to be executed
*/

module instruction_memory(
  input wire [31:0] addr,
  output reg [31:0] instruction);

  //instantiate the memory
  reg [31:0] memory [32'h100000:32'h401000]; //made this bigger (was 32'h101000)

  //this will hold the word address
  reg [31:0] real_addr;
  reg set;
  integer i;

  //change into a word address
  always @(addr)
    begin
        if(addr == 32'b0)
          instruction <= 0;
        else begin
          real_addr <= addr >> 2;
          instruction <= memory[real_addr];
        end
        if (set == 1) begin
            instruction <= 0;
            set <= 0;
        end
    end

  //read instructions
  initial
    begin
      for(i = 32'h100000; i < 32'h101000; i = i + 1) begin
        memory[i] = 32'd0; //set all values to 0 initially
      end
      $readmemh("hello.v", memory);
      set = 1;

    end

endmodule
