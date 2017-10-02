`include "../src/data_memory.v"

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
