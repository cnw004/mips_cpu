`include "../src/mux3.v"

module testbench;

parameter SIZE = 31; //assume size is 31 unless otherwise specified
reg [1:0] ctrl; //an input
reg [SIZE:0] input_00; //an input
reg [SIZE:0] input_01; //an input
reg [SIZE:0] input_10; //an input
wire [SIZE:0] out; //our output

initial 
  begin
    input_00 = 32'h00054321; 
    input_01 = 32'h000000AC; 
    input_10 = 32'h00000123; 
    $monitor("ctrl is %h, input_00 is %h, input_01 is %h, input_10 is %h, out is %h", ctrl, input_00, input_01 ,input_10, out);
    ctrl = 2'b00; #10; //mux will output input_00 which is 00054321
    ctrl = 2'b01; #10; //mux will output input_01 which is 000000ac
    ctrl = 2'b10; #10; //mux will output input_10 which is 00000123  
  end

mux3 mux(ctrl, input_00, input_01, input_10, out);

endmodule


