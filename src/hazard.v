`include "mips.h" //various defines

/*
parameterized 3 input mux module

inputs:
  - ctrl: decides which input to pass to out
  -

outputs:
  - out: either input_00, input_01, input_10 depending on ctrl
*/
module mux3(
  input wire clk,
  input wire branchD,
  input wire [4:0] RsD,
  input wire [4:0] RtD,
  input wire [4:0] RsE,
  input wire [4:0] RtE,
  input wire MemToRegE,
  input wire RegWriteE,
  input wire [4:0] WriteRegE,
  input wire [4:0] WriteRegM,
  input wire MemToRegM,
  input wire RegWriteM,
  input wire [4:0] WriteRegW,
  input wire RegWriteW,
  output reg StallF,
  output reg StallD,
  output reg ForwardAD,
  output reg ForwardBD,
  output reg FlushE,
  output reg [1:0] ForwardAE,
  output reg [1:0] ForwardBE
  );

wire branchStall;
wire lwStall;

assign branchStall = ((branchD && RegWriteE && (WriteRegE == RsD || WriteRegE == RtD))
                                      ||
              (branchD && MemToRegM && (WriteRegM == RsD || WriteRegM == RtD)));

assign lwStall = ((RsD == RtE) || (RtD == RtE) && MemToRegE);


//should this be posedge or negedge??
always @(posedge clk) begin

//this is for M->E and E->E for the Rs register
  if((RsE != `zero) && (RsE == WriteRegM) && RegWriteM)
    ForwardAE <= 2'b10;
  else if((RsE != `zero) && (RsE == WriteRegW) && RegWriteW)
    ForwardAE <= 2'b01;
  else
    ForwardAE <= 2'b00;


  //this is for M->E and E->E for the Rt register
  if((RtE != `zero) && (RtE == WriteRegM) && RegWriteM)
    ForwardBE <= 2'b10;
  else if((RtE != `zero) && (RtE == WriteRegW) && RegWriteW)
    ForwardBE <= 2'b01;
  else
    ForwardBE <= 2'b00;

  //logic to handle stalling
  StallF <= branchStall || lwStall;
  StallD <= branchStall || lwStall;
  FlushE <= branchStall || lwStall;





end

endmodule
