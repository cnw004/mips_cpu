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
  input wire mem_write,
  input wire [31:0] address,
  input wire [31:0] write_data,
  output reg [31:0] read_data);

  //declare the memory
  reg [31:0] data_mem [32'h7FFF0000:32'h7FFFFFFC]; //not entirely sure this is correct

  //always read / write when channges happen.
  always @(mem_write, address)
    begin
      if(mem_write == 1)
        data_mem[address] = write_data;
      else
        read_data = data_mem[address];
    end

endmodule


module testbench; //need to work on output and see what i can figure out

reg mem_write;
reg [31:0] address;
reg [31:0] write_data;
wire [31:0] read_data; //note: changed output from a reg to a wire in order to compile

reg clk;
parameter END_COUNT = 4099; //can only loop 4096 times until we reach max address, we will break on upper bound of address, if we want to break on count, make END_COUNT = 4095 or less
reg [END_COUNT:0] count;
parameter ADDRESS_UPPER_LIMIT = 32'h7FFFFFFC; //lower limit for address from implementation above
parameter ADDRESS_LOWER_LIMIT = 32'h7FFF0000; //upper limit for address from implementation above

data_memory data_mem(mem_write, address, write_data, read_data);


always
  begin                     // inline clk generator
    #10; clk = ~clk;
  end


initial 
  begin
    clk = 0;
    mem_write = 1; //we are going to do a weire instructions
    address = 32'h7FFF0000;
    count = 0;
    $monitor("count is %4d, address is %x", count, address);
    //$display("about to update things"); 
  end




always @(posedge clk)
  begin 
    count = count + 1;	//update the counter

    address = address + 32'h00000010; //increment the address to see if it is still within the bounds

    if (count > END_COUNT) begin
      $display("count has exceeded its upper bound... ending program\n");
      count = 0;	//reset the counter 
      address = 32'h7FFF0000;	//reset the address
      $finish;
    end

    if (address > ADDRESS_UPPER_LIMIT || address < ADDRESS_LOWER_LIMIT) begin
      $display("resetting values\naddress is %x, has gone out of bounds... ending program\n", address);
      address = 32'h7FFF0000;	//reset the address
      count = 0;	//reset the counter 
      $finish;
    end

  end

endmodule 
