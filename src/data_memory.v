/*
module to act as data memory for our processor

inputs:
  - clk: clk to read and write on opposite edges
  - mem_read: comes out of control, decides if we should read or not
  - mem_write: comes out of control, decides if we should write or not
  - address: where in data memory should we write to
  - write_data: data to be written to memory

outputs:
  - read_data: data read from memory
*/

module data_memory(
  input wire clk,
  input wire mem_read,
  input wire mem_write,
  input wire [31:0] address,
  input wire [31:0] write_data,
  output reg [31:0] read_data);

  //declare the memory
  reg [31:0] data_mem [255:0]; //not entirely sure this is correct

  //write on the posedge
  always @(posedge clk)
    begin
      if(mem_write == 1)
        data_mem[address] = write_data;
    end

  //read on the negedge
  always @(negedge clk)
    begin
      if(mem_read == 1)
        read_data = data_mem[address];
    end
endmodule
