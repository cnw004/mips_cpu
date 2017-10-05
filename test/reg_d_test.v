`include "../src/reg_d.v"

module testbench;

reg clk;
reg enable;
reg clr;
reg [31:0] in1;
reg [31:0] in2;
wire [31:0] out1;
wire [31:0] out2;

always
  begin                     // inline clk generator
    #10; clk = ~clk;
  end

initial
  begin
    clk = 1;
    in1 = 32'h00000999; #20; //initial value
    in2 = 32'h11100000; #20; //initial value
    $monitor("clk is %d, enable is %d, clr is %d, input1 is %x, input2 is %x, output1 is %x, output2 is %x", clk, enable, clr, in1, in2, out1, out2);
    enable = 1; clr = 0; #20; //since enable = 1 and clr = 0, we pass through the values of in1 and in2 to out1 and out2
    enable = 0; clr = 1; #20; //flip the values for enable and clear, the outputs are cleared (have value 00000000)
    in1 = 32'h12345678; #20; //change value of in1
    in2 = 32'h87654321; #20; //change value of in2
    enable = 1; clr = 0; #20; //set enable = 1 and see that out1 = in1 and out2 = in2, with in1 and in2 having their new values from the two lines above
    $finish;
  end

reg_d reg2(clk, enable, clr, in1, in2, out1, out2);

endmodule
