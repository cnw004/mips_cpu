//`include "../src/data_memory.v"

module test;

   //inputs and outputs for data_mem
   reg mem_write;
   reg [31:0] addr;
   reg [31:0] write_data;
   wire [31:0] read_data;
   
   //Params and clock for testing
   reg 	       clk;
   parameter END_COUNT = 4099; // end of data
   parameter LOWER_ADDR = 32'h7FFF0000;
   parameter UPPER_ADDR = 32'h7FFFFFFC;
   reg [1:0]   count; //counter for test
   
   //instantiating 
   data_memory data_mem(mem_write, addr, write_data, read_data);
   //testing

   always
     begin
	#100;
	count = count + 2'd1;
     end

   initial
     begin
	write_data = 32'd1;
	addr = 32'h7FFF0000;
	clk = 0;
	mem_write = 1;
	count = 0;

	$dumpfile("data_memory_2.vcd");
	$dumpvars(0, test);
	
	//$monitor("count is %4d, address is %x", count, addr);
     end
   
   always @(count)
     begin
	if(count == 2'd0)
	  begin
	     $display("reading from just initialized data memory: %x", read_data); // make sure initialized to zero
	  end
	if(count == 2'd1)
	  begin
	     $display("writing %x, read_data val: %x",  write_data, read_data); // write data to the data_memory 
	     mem_write <= 0;
	  end
	if(count == 2'd2)
	  begin
	     $display("reading %x", read_data);
	     $finish;
	  end
     end
   
endmodule

