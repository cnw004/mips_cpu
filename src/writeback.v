//`include "mux.v"
/*
 This module wires together everything in the writeback stage.

 inputs:
   - MemToRegW: 1 bit decides whether ALUout or read data gets passed to ResultW
   - ReadDataW: data read from data_memory
   - ALUOutW: value output from the ALU
   - WriteRegW: register to be written to, passed to the hazard unit

 outputs:
   - WriteRegW_out: passing the reg into the hazard unit
   - ResultW: value to be passed and written into the register file

 modules included:
   mux.v
 */
module writeback(
   input wire MemToRegW,
   input wire [31:0] ReadDataW,
   input wire [31:0] ALUOutW,
   input wire [31:0] a0,
   input wire [31:0] v0,
   input wire [31:0] a1,
   input wire [4:0] WriteRegW,
   input wire [31:0] instruction_in,
   input wire syscall_in,
   output wire [4:0] WriteRegW_out,
   output wire [31:0] ResultW,
   output reg [31:0] ResultW_forwarded,
   output reg [4:0] WriteRegW_out_toRegisters,
   output reg [31:0] ResultW_forwardedMM,
   output reg [31:0] string_index,
   output wire print_string
   );

   //Send back to decode: Call to print string out of instruction memory
   assign print_string = (v0 == 4);
   //pass WriteReg_W back out
   assign WriteRegW_out = WriteRegW;
   //syscall declaration
   system_call my_sys_call(syscall_in, instruction_in, v0, a0, a1);
   mux my_mux(MemToRegW, ALUOutW, ReadDataW, ResultW);
 
   always @(*)
        begin
        WriteRegW_out_toRegisters <= WriteRegW;
        ResultW_forwarded <= ResultW;
        ResultW_forwardedMM <= ResultW;
        //a0 passes back through to decode.
        string_index <= a0;
        end
    initial begin
        ResultW_forwarded <= 32'b0;
        WriteRegW_out_toRegisters <= 32'b0;
        string_index <= 0;
    end
endmodule
