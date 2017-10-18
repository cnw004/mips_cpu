/*
module to act as our clk for the execute stage

inputs:
  - clk: our clock
  - clr: wire from hazard unit. decides if we should flush
  - syscall_in: syscall
  - regwrite_in: reg write
  - mem_to_reg_in: memToReg
  - alu_ctrl_in: alu ctrl (2:0)
  - alu_src_in: aluSrc
  - reg_dst_in: regDst
  - rd1_in: output from register RD1
  - rd2_in: output from register RD2
  - rsd_in: RsD (25:21)
  - rtd_in: RtD (20:16)
  - rte_in: RdE (15:11)
  - sign_immd_in: SignImmD (31:0)
  - mem_write_in: memWrite
  - instr_in: Instruction



output:
- syscall_out: syscall
- reg_write_out: reg write
- mem_to_reg_out: memToReg
- alu_ctrl_out: alu ctrl (2:0)
- alu_src_out: aluSrc
- reg_dst_out: regDst
- rd1_out: output from register RD1
- rd2_out: output from register RD2
- rse_out: RsE (25:21)
- rte_out: RtE (20:16)
- rde_out: RdE (15:11)
- sign_immd_out: SignImmD (31:0)
- mem_write_out: memWrite
- instr_out: Instruction
- mem_to_reg_hazard_out: hazard_in_MemtoRegE
- reg_write_hazard_out: hazard_in_RegWriteE
*/

module reg_e(input wire clk,
  input wire clr,
  input wire syscall_in,
  input wire regwrite_in,
  input wire mem_to_reg_in,
  input wire [2:0] alu_ctrl_in,
  input wire alu_src_in,
  input wire reg_dst_in,
  input wire [31:0] rd1_in,
  input wire [31:0] rd2_in,
  input wire [25:21] rsd_in,
  input wire [20:16] rtd_in,
  input wire [15:11] rte_in,
  input wire [31:0] sign_immd_in,
  input wire mem_write_in,
  input wire [31:0] instr_in, //instruction
  output reg syscall_out,
  output reg reg_write_out,
  output reg mem_to_reg_out,
  output reg [2:0] alu_ctrl_out,
  output reg alu_src_out,
  output reg reg_dst_out,
  output reg [31:0] rd1_out,
  output reg [31:0] rd2_out,
  output reg [25:21] rse_out,
  output reg [20:16] rte_out,
  output reg [15:11] rde_out,
  output reg [31:0] sign_immd_out,
  output reg mem_write_out,
  output reg [31:0] instr_out,//instruction
  output reg mem_to_reg_hazard_out,
  output reg reg_write_hazard_out
  );


initial begin
  syscall_out <= 0;
  reg_write_out <= 0;
  mem_to_reg_out <= 0;
  alu_ctrl_out <= 0;
  alu_src_out <= 0;
  reg_dst_out <= 0;
  rd1_out <= 0;
  rd2_out <= 0;
  rse_out <= 0;
  rte_out <= 0;
  rde_out <= 0;
  sign_immd_out <= 0;
  mem_write_out <= 0;
  instr_out <= 0;
  mem_to_reg_hazard_out <= 0;
  reg_write_hazard_out <= 0;
end



  always @(posedge clk) begin
    if(clr) begin
      syscall_out <= 0;
      reg_write_out <= 0;
      mem_to_reg_out <= 0;
      alu_ctrl_out <= 0;
      alu_src_out <= 0;
      reg_dst_out <= 0;
      rd1_out <= 0;
      rd2_out <= 0;
      rse_out <= 0;
      rte_out <= 0;
      rde_out <= 0;
      sign_immd_out <= 0;
      mem_write_out <= 0;
      instr_out <= 0;
      mem_to_reg_hazard_out <= 0;
      reg_write_hazard_out <= 0;

    end

    else begin
      syscall_out <= syscall_in;
      reg_write_out <= regwrite_in;
      mem_to_reg_out <= mem_to_reg_in;
      alu_ctrl_out <= alu_ctrl_in;
      alu_src_out <= alu_src_in;
      reg_dst_out <= reg_dst_in;
      rd1_out <= rd1_in;
      rd2_out <= rd2_in;
      rse_out <= rsd_in;
      rte_out <= rtd_in;
      rde_out <= rte_in;
      sign_immd_out <= sign_immd_in;
      mem_write_out <= mem_write_in;
      instr_out <= instr_in;
      mem_to_reg_hazard_out <= mem_to_reg_in;
      reg_write_hazard_out <= regwrite_in;
    end
  end


endmodule
