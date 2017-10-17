`include "../src/reg_f.v"

module testbench;

/*
*  We notice that since enable = 1, the value of in1 gets passed
*  to out1 at the positive edge of the clock.
*/

reg clk;
reg enable;
reg [31:0] in1;
wire [31:0] out1;

always
  begin                     // inline clk generator
    #10; clk = ~clk;
  end

initial
  begin
    clk = 0;
    enable = 1; //if enable = 0, we notice that out1 = xxxxxxxx in all cases
    $monitor("clk is %d, enable is %d, input is %x, output is %x", clk, enable, in1, out1);
    in1 = 32'h00000000; #20;
    in1 = 32'h00ab4000; #20;
    in1 = 32'h00001232; #20;
    in1 = 32'hFFFFAB32; #20;
    $finish;
  end

reg_f reg1(clk, enable, in1, out1);

endmodule
