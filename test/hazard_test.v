`include "../mips.h"
`include "../src/hazard.v"


module testbench;

//inputs
reg [31:0] instruction1;
reg [31:0] instruction2;
reg [31:0] instruction3;

reg clk;
reg branchD;
reg [4:0] RsD;
reg [4:0] RtD;
reg [4:0] RsE;
reg [4:0] RtE;
reg MemToRegE;
reg RegWriteE;
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
    // set instruction stuff below...

    //add t1 t2 t3
    branchD = 0;
    RsD = `zero;
    RtD = `zero;
    RsE = `t1;
    RtE = `t2;
    MemToRegE = 0;
    RegWriteE = 1;
    WriteRegE = `t4;
    WriteRegM = `t1;
    MemToRegM = 0;
    RegWriteM = 1;
    WriteRegW = `zero;
    RegWriteW = 0;



    //add t4 t1 t2


    // in1 = 32'h00000000; #20;
    // in1 = 32'h00ab4000; #20;
    // in1 = 32'h00001232; #20;
    // in1 = 32'hFFFFAB32; #20;
    $finish;
  end

hazard my_hazard(clk, branchD, RsD, RtD, RsE, RtE, MemToRegE, RegWriteE, WriteRegE, WriteRegM, MemToRegM, RegWriteM, WriteRegW, RegWriteW, StallF, StallD, ForwardAD, ForwardBD, FlushE, ForwardAE, ForwardBE);

endmodule
