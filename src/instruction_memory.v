/*
module to act as instruction memory and set up instruction reads

module also handles printing strings from memory

inputs:
  - addr: the address read in from reg_f.v
  - string_index: if we are to print a string, this is the index to start at
  - print_string: should we print a string?

outputs:
  - instruction: instruction to be executed
*/

module instruction_memory(
  input wire [31:0] addr,
  input wire [31:0] string_index,
  input wire print_string,
  output reg [31:0] instruction);

  //instantiate the memory
  reg [31:0] memory [32'h100000:32'h401000];

  //this will hold the word address
  reg [31:0] real_addr;

  integer i;
  reg [7:0] character = 0;
  reg [31:0] stringIndexUpdate;
  reg [31:0] stringWord;

  // for printing strings
  always @(print_string) begin
    if(print_string == 1) begin
      character = 1; //something not zero to get through the while loop first time
      stringIndexUpdate = string_index >> 2; //setup first string index and let it be modified
      while (character != 0) begin //0 is the null terminator
        stringWord = memory[stringIndexUpdate];
        for (i = 3; i >= 0; i = i - 1) begin
          case(i)
            0: character = stringWord[31:24];
            1: character = stringWord[23:16];
            2: character = stringWord[15:8];
            3: character = stringWord[7:0];
            endcase
            if (character != 0)
                $write("%c", character); //string should print here
        end
        stringIndexUpdate = stringIndexUpdate + 1;
      end
    end
    $write("\n");
  end


  //retrieve instruction from memory
  always @(addr)
    begin
        if(addr == 32'b0)
          instruction = 0;
        else begin
          real_addr = addr >> 2;
          instruction = memory[real_addr];
        end
    end

  //read instructions
  initial
    begin
      for(i = 32'h100000; i < 32'h101000; i = i + 1) begin
        memory[i] = 32'd0; //set all values to 0 initially
      end
      $readmemh("hello.v", memory);
    end

endmodule
