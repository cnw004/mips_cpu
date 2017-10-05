`include "../src/reg_e.v"

module testbench;

reg clk;
reg clr;
reg in1;
reg in2;
reg in3;
reg in4;
reg in5;
reg in6;
reg [31:0] in7;
reg [31:0] in8;
reg [25:21] in9;
reg [20:16] in10;
reg [15:11] in11;
reg [31:0] in12;
reg in13;
wire out1;
wire out2;
wire out3;
wire out4;
wire out5;
wire out6;
wire [31:0] out7;
wire [31:0] out8;
wire [25:21] out9;
wire [20:16] out10;
wire [15:11] out11;
wire [31:0] out12;
wire out13;

always
  begin                     // inline clk generator
    #10; clk = ~clk;
  end

reg_e reg3(clk, clr, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11,
      in12, in13, out1, out2, out3, out4, out5, out6, out7, out8, out9,
      out10, out11, out12, out13);

initial
  begin
    clk = 0;
    in1 = 1; #20; //initial value
    in2 = 1; #20; //initial value
    in3 = 1; #20; //initial value
    in4 = 1; #20; //initial value
    in5 = 1; #20; //initial value
    in6 = 1; #20; //initial value
    in7 = 32'h0000000F; #20; //initial value
    in8 = 32'h0000000C; #20; //initial value
    in9 = 5'h1f; #20; //initial value
    in10 = 5'h0C; #20; //initial value
    in11 = 5'h0A; #20; //initial value
    in12 = 32'h0000000D; #20; //initial value
    $monitor("clk is %d, clr is %d, input1 is %x, input2 is %x, input3 is %x, input4 is %x, input5 is %x , input6 is %x, input7 is %x, input8 is %x, input9 is %x, input10 is %x, input11 is %x, input12 is %x, output1 is %x, output2 is %x, output3 is %x, output4 is %x, output5 is %x, output6 is %x, output7 is %x, output8 is %x, output9 is %x, output10 is %x, output11 is %x, output12 is %x", clk, clr, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12);
    clr = 0; #20; //since clr = 0, we pass through the values of each input to each output
    clr = 1; #20; //at negedge of the clock set all values to 0
    clr = 0; #20; //let the values flow back through
    $finish;
  end

endmodule
