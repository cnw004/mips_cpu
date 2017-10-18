/*
module to act as our clk for the mem stage

inputs:
  - clk: our clock
  - syscall_in: syscall
  - regwrite_in: reg write
  - mem_to_reg_in: mem to reg
  - mem_write_in: memwrite
  - alu_output_in: aluout [31:0]
  - write_data_in: writeDataE [31:0]
  - write_reg_in: writeRegE [4:0]
  - instr_in: Instruction
  - RsE: register source from the E stage

output:
- syscall_out: syscall
- regwrite_out: reg write
- mem_to_reg_out: mem to reg
- mem_write_out: memWrite
- alu_output_out: aluout [31:0]
- write_data_out: writeDataE [31:0]
- write_reg_out: writeRegE [4:0]
- instr_out: Instruction
- mem_to_reg_hazard_out: hazard_in_MemtoReg
- regwrite_m_hazard_out: hazard_in_RegWriteM
- RsM: register source for the M stage
*/

module reg_m(input wire clk,
  input wire syscall_in,
  input wire regwrite_in,
  input wire mem_to_reg_in,
  input wire mem_write_in,
  input wire [31:0] alu_output_in,
  input wire [31:0] write_data_in,
  input wire [4:0] write_reg_in,
  input wire [31:0] instr_in,
  input wire [4:0] RtE,
  output reg syscall_out,
  output reg regwrite_out,
  output reg mem_to_reg_out,
  output reg mem_write_out,
  output reg [31:0] alu_output_out,
  output reg [31:0] write_data_out,
  output reg [4:0] write_reg_out,
  output reg [31:0] instr_out,
  output reg mem_to_reg_hazard_out,
  output reg regwrite_m_hazard_out,
  output reg [4:0] RtM,
  output reg hazard_in_MemWriteM);


  initial begin
    syscall_out <= 0;
    regwrite_out <= 0;
    mem_to_reg_out <= 0;
    mem_write_out <= 0;
    alu_output_out <= 0;
    write_data_out <= 0;
    write_reg_out <= 0;
    instr_out <= 0;
    mem_to_reg_hazard_out <= 0;
    regwrite_m_hazard_out <= 0;
    RtM <= 0;
    hazard_in_MemWriteM <= 0;
  end

  always @(posedge clk) begin
    syscall_out <= syscall_in;
    regwrite_out <= regwrite_in;
    mem_to_reg_out <= mem_to_reg_in;
    mem_write_out <= mem_write_in;
    alu_output_out <= alu_output_in;
    write_data_out <= write_data_in;
    write_reg_out <= write_reg_in;
    instr_out <= instr_in;
    mem_to_reg_hazard_out <= mem_to_reg_in;
    regwrite_m_hazard_out <= regwrite_in;
    RtM <= RtE;
    hazard_in_MemWriteM <= mem_write_in;
  end


endmodule
