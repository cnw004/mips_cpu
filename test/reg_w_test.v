`include "../src/reg_w.v"

module testbench;

reg clk;
reg in1;
reg in2;
reg in3;
reg [31:0] in4;
reg [31:0] in5;
reg [4:0] in6;

wire out1;
wire out2;
wire out3;
wire [31:0] out4;
wire [31:0] out5;
wire [4:0] out6;

always
  begin                     // inline clk generator
    #10; clk = ~clk;
  end

//TODO: this worked before, needs to be updated!!
reg_w reg5(clk, in1, in2, in3, in4, in5, in6,
           out1, out2, out3, out4, out5, out6);

always @(posedge clk) //only looking at the positive edge of the clock
  begin
   $strobe($time, " is the time, clk is %d, input1 is %x, input2 is %x, input3 is %x, input4 is %x, input5 is %x , input6 is %x, output1 is %x, output2 is %x, output3 is %x, output4 is %x, output5 is %x, output6 is %x", clk, in1, in2, in3, in4, in5, in6, out1, out2, out3, out4, out5, out6);
  end

initial
 begin
   //$monitor($time, "clk is %d, input1 is %x, input2 is %x, input3 is %x, input4 is %x, input5 is %x , input6 is %x, output1 is %x, output2 is %x, output3 is %x, output4 is %x, output5 is %x, output6 is %x", clk, in1, in2, in3, in4, in5, in6, out1, out2, out3, out4, out5, out6);
   clk = 0;
   in1 = 1; #10; //initial value
   in2 = 1; #10; //initial value
   in3 = 1; #10; //initial value
   in4 = 32'h0000000F; #10; //initial value
   in5 = 32'h0000000C; #10; //initial value
   in6 = 5'h0A; #10; //initial value
   in1 = 1; #10; //new value
   in2 = 0; #10; //new value
   in3 = 1; #10; //new value
   in4 = 32'h02340000; #10; //new value
   in5 = 32'h00006790; #10; //new value
   in6 = 5'h11; #34; //new value that we delay even more to see the change on a different upward clock tick
   $finish;
 end

endmodule
