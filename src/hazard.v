`include "mips.h" //various defines

/*
parameterized 3 input mux module

inputs:
  - clk: the clk for our system
  - branchD: 1 bit letting us know if a branch is taken in Decode stage
  - RsD: register Rs in stage D
  - RtD: register Rt in stage D
  - RsE: register Rs in stage E
  - RtE: register Rt in stage E
  - MemToRegE: 1 bit, are we pulling out of mem to a reg in stage E?
  - RegWriteE: 1 bit, are we writing to a reg in E?
  - WriteRegE: the register to be written to in the E stage instr
  - WriteRegM: the register to be written to in the M stage instr
  - MemToRegM: 1 bit, are we pulling out of mem to a reg in stage M?
  - RegWriteM: 1 bit, are we writing to a reg in stage M?
  - WriteRegW: the register to be written to in the W stage instr
  - RegWriteW: 1 bit, are we writing to a reg in stage W instr?

outputs:
  - StallF: do we need to stall in stage F?
  - StallD: do we need to stall in stage D?
  - ForwardAD: E->D forward from register Rs
  - ForwardBD: E->D forward from register Rt
  - FlushE: Do we need to flush the E stage?
  - ForwardAE: M->E & E->E forward for register Rs
  - ForwardBE: M->E & E->E forward for register Rt
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
  if((RtE != `zero) && (RtE == WriteRegM) && RegWriteM) //E->E
    ForwardBE <= 2'b10;
  else if((RtE != `zero) && (RtE == WriteRegW) && RegWriteW) //M->E
    ForwardBE <= 2'b01;
  else
    ForwardBE <= 2'b00;

  //this handles E->D forwards
  ForwardAD <= ((RsD != 0) && (RsD == WriteRegM) && RegWriteM); //E->D for Rs
  ForwardBD <= ((RtD != 0) && (RtD == WriteRegM) && RegWriteM); //E->D for Rt

  //logic to handle stalling
  StallF <= ~(branchStall || lwStall); //inverted to handle the not gate (see drawing)
  StallD <= ~(branchStall || lwStall); //inverted to handle the not gate (see drawing)

  //only happens when we stall, ensures we dont push "bogus information" through the pipeline
  FlushE <= (branchStall || lwStall);





end

endmodule