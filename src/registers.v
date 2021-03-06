`include "mips.h" //various defines


/*
simple module to act as our registers

inputs:
  - jal: flag to indicate that a jal instruction is occuring.
  - reg_write: 1 or 0, decides if we are to write_reg
  - reg1: first register to work with
  - reg2: second register to work with
  - write_reg: register to be written to if reg_write is 1
  - write_data: data to write to the reg if reg_write is 1
  - jal_address: data to write into jal if jal is 1

outputs:
  - read1: data read from register1
  - read2: data read from register2
  - v0: the value in register v0 to be used by syscall module
  - a0: the value in register a0 to be used by syscall module
*/

module registers(input wire clk, //assume passing in negation of the rest of the clock.
  input wire jal,
  input wire reg_write,
  input wire [25:21] reg1,
  input wire [20:16] reg2,
  input wire [4:0] write_reg,
  input wire [31:0] write_data,
  input wire [31:0] jal_address,
  output reg [31:0] read1,
  output reg [31:0] read2,
  output reg [31:0] v0,
  output reg [31:0] a0,
  output reg [31:0] a1);

  //instantiate register memory
  reg [31:0] reg_mem [31:0];
  integer i;

  //init values to 0
  initial begin
    read1 = 32'd0;
    read2 = 32'd0;
    a0 = 32'd0;
    v0 = 32'd0;
    a1 = 32'd0;
    for(i = 0; i < 32; i = i + 1) begin
      reg_mem[i] = 32'd0; //set all values to 0 initially
    end
    reg_mem[`sp] = 32'h7FFFFFFC;
  end

always @(*) begin
    #5;
    //WRITE
    if(jal == 1) begin
      reg_mem[`ra] <= jal_address;
    end
    //set $ra value appropriately
     if(reg_write == 1) begin
        reg_mem[write_reg] <= write_data;
      end

    //READ
    read1 <= reg_mem[reg1];
    read2 <= reg_mem[reg2];
    v0 <= reg_mem[`v0];
    a0 <= reg_mem[`a0];
    a1 <= reg_mem[`a1];

    //Testing output of registers
    //$display("a1 value: %d\ta0 value: %d\tv0 value: %d\t\n", reg_mem[`a1], reg_mem[`a0], reg_mem[`v0]);
end
endmodule
