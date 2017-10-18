/*
module to act as our clk for the write stage

inputs:
  - clk: our clock
  - regwrite_in: reg write
  - mem_to_reg_in: mem to reg
  - rd_data_mem_in: RD from data mem [31:0]
  - ALU_outM_in: ALUoutM [31:0]
  - write_regM_in: writeRegM [4:0]


output:
- regwrite_out: reg write
- mem_to_reg_out: mem to reg
- read_data_w_out: ReadDataW
- ALU_out_w_out: ALUoutW [31:0]
- write_regW_out: writeRegW [4:0]
- regwrite_hazard_out: RegWriteW to hazard

*/

module reg_w(input wire clk,
  input wire regwrite_in,
  input wire mem_to_reg_in,
  input wire [31:0] rd_data_mem_in,
  input wire [31:0] ALU_outM_in,
  input wire [4:0] write_regM_in,
  input wire [31:0] instruction_in,
  input wire syscall_in,
  output reg regwrite_out,
  output reg mem_to_reg_out,
  output reg [31:0] read_data_w_out,
  output reg [31:0] ALU_out_w_out,
  output reg [4:0] write_regW_out,
  output reg regwrite_hazard_out,
  output reg [31:0] instruction_out,
  output reg syscall_out);

  initial begin
    regwrite_out <= 0;
    mem_to_reg_out <= 0;
    read_data_w_out <= 0;
    ALU_out_w_out <= 0;
    write_regW_out <= 0;
    regwrite_hazard_out <= 0;
    instruction_out <= 0;
    syscall_out <= 0;
  end

  always @(posedge clk) begin
    regwrite_out <= regwrite_in;
    mem_to_reg_out <= mem_to_reg_in;
    read_data_w_out <= rd_data_mem_in;
    ALU_out_w_out <= ALU_outM_in;
    write_regW_out <= write_regM_in;
    regwrite_hazard_out <= regwrite_in;
    instruction_out <= instruction_in;
    syscall_out <= syscall_in;
  end


endmodule
