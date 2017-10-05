`include "../src/hazard.v"
`include "../mips.h"

module testbench;

//inputs
reg clk;
reg branchD;
reg [4:0] RsD;
reg [4:0] RtD;
reg [4:0] RsE;
reg [4:0] RtE;
reg MemToRegE;
reg MemToRegM;
reg [4:0] WriteRegE;
reg [4:0] WriteRegM;
reg MemToRegM;
reg RegWriteM;
reg [4:0] WriteRegW;
reg RegWriteW;

//outputs
wire StallF;
wire StallD;
wire ForwardAD;
wire ForwardBD;
wire FlushE;
wire [1:0] ForwardAE;
wire [1:0] ForwardBE;

always
  begin                     // inline clk generator
    #10; clk = ~clk;
  end

initial
  begin
    clk = 1;

    $monitor("StallF is %d, StallD is %d, ForwardAD is %d, ForwardBD is %d, FlushE is %d, ForwardAE is %d, ForwardBE is %d", StallF, StallD, ForwardAD, ForwardBD, FlushE, ForwardAE, ForwardBE);
    // in1 = 32'h00000000; #20;
    // in1 = 32'h00ab4000; #20;
    // in1 = 32'h00001232; #20;
    // in1 = 32'hFFFFAB32; #20;
    $finish;
  end

hazard my_hazard();

endmodule
