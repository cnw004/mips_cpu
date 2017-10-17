/*
module to act as instruction memory and set up instruction reads

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
  reg [31:0] memory [32'h100000:32'h401000]; //made this bigger (was 32'h101000)

  //this will hold the word address
  reg [31:0] real_addr;
  // reg set;
  integer i;
  reg [7:0] character = 0;
  reg [31:0] stringIndexUpdate;
  reg [31:0] stringWord;

  // for printing strings
  always @(print_string) begin
    if(print_string == 1) begin
    //   $display("string index: %h", (string_index) >> 2);
      character = 1; //something not zero to get through the while loop first time
      stringIndexUpdate = string_index >> 2; //setup first string index and let it be modified
      while (character != 0) begin //0 is the null terminator
        // $display("character is: %d", character);
        stringWord = memory[stringIndexUpdate];
        // $display("character is: %c", character);
        // $display("Word is: %h", stringIndexUpdate);
        // $display("stringWord: %h", stringWord);
        for (i = 3; i >= 0; i = i - 1) begin
            // $display("i is: %d", i);
            if (i == 0) begin
                character = stringWord[31:24];
            end
            if (i == 1)
                character = stringWord[23:16];
            if (i == 2)
                character = stringWord[15:8];
            if (i == 3)
                character = stringWord[7:0];
            if (character == 0) begin
                // $display("GAME OVER");
            end
            else $write("%c", character); //string should print here
            // $display("character is: %c", character);
        end
        stringIndexUpdate = stringIndexUpdate + 1;
      end
    end
    $write("\n");
  end


  //change into a word address
  always @(addr)
    begin
        if(addr == 32'b0)
          instruction = 0;
        else begin
          real_addr = addr >> 2;
          instruction = memory[real_addr];
        end
        // if (set == 1) begin
        //     instruction <= 0;
        //     set <= 0;
        // end
    end

  //read instructions
  initial
    begin
      for(i = 32'h100000; i < 32'h101000; i = i + 1) begin
        memory[i] = 32'd0; //set all values to 0 initially
      end
      $readmemh("hello.v", memory);
    //   set = 1;
    //   real_addr = addr >> 2;
    //   $display("VALUE OF ADDR: %h", addr);
    //   $display("VALUE OF Real ADDR: %h", addr);
    //   instruction = memory[real_addr];

    end

endmodule
