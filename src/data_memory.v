/*
module to act as data memory for our processor

inputs:
  - mem_write: comes out of control, decides if we should write or not
  - address: where in data memory should we write to
  - write_data: data to be written to memory

outputs:
  - read_data: data read from memory
*/

module data_memory(
  input wire 	    mem_write,
  input wire [31:0] address,
  input wire [31:0] write_data,
  output reg [31:0] read_data);

  integer i;

  initial begin
    read_data <= 0;
    for(i = 32'h7FFF0000; i < 32'h7FFFFFFC; i = i + 1) begin
      data_mem[i] <= 0; //set all values to 0 initially

    end
  end

  //declare the memory
  reg [31:0] data_mem [32'h7FFF0000:32'h7FFFFFFC]; //general memory range

  //always read / write when channges happen.
  always @(mem_write, address, read_data) begin
       if(mem_write == 1)
	 begin
	    data_mem[address] <= write_data;
	 end
       if(mem_write == 0)
	 begin
	    if(address < 32'h70000000)
	      read_data <= 0;
	    else
	      read_data <= data_mem[address];
	 end
  end

endmodule
