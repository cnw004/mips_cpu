// `include "fetch.v"
// `include "reg_d.v"
// `include "decode.v"
module pipeline_overview();

  //Clock that keeps rest of modules timed properly
  reg clock = 0;


  //inputs for fetch module
  wire fetch_in_jump;
  wire fetch_in_jump_reg;
  wire fetch_in_branch;
  wire [31:0] fetch_in_branch_addr;
  wire [31:0] fetch_in_jump_reg_adddr;
  wire [31:0] fetch_in_jump_addr;
  wire fetch_in_enable; // stallF
  wire [31:0] fetch_in_string_index;
  wire fetch_in_print_string;

  //inputs for decode register
  wire [31:0] decode_reg_in_instr; //in1
  wire [31:0] decode_reg_in_pc_plus_4; //in2
  wire decode_reg_in_clr; //StallD
  wire decode_reg_in_enable; //from hazard


  //inputs for decode module
  wire [31:0] decode_in_instrD;
  wire [31:0] decode_in_pc_plus_4;
  wire decode_in_clear; // value of PCSRC
  wire [31:0] decode_in_write_from_wb; // writeback value from WB module
  wire [31:0] decode_in_alu_out; // alu_out from memory stage
  wire decode_in_forwardAD;
  wire decode_in_forwardBD;
  wire decode_in_regWriteW; // regwrite control signal from write back
  wire [4:0] decode_in_write_register;

  //inputs for execute register
  wire execute_reg_in_syscall;
  wire [31:0] execute_reg_in_instruction;
  wire execute_reg_in_reg_write;
  wire execute_reg_in_mem_to_reg;
  wire [2:0] execute_reg_in_alu_ctrl;
  wire execute_reg_in_alu_src;
  wire execute_reg_in_reg_dst;
  wire [31:0] execute_reg_in_rd1; //from reg
  wire [31:0] execute_reg_in_rd2;  // from reg
  wire [4:0] execute_reg_in_rsD;
  wire [4:0] execute_reg_in_rtD;
  wire [4:0] execute_reg_in_rdE;
  wire [31:0] execute_reg_in_sign_immediate;
  wire execute_reg_in_mem_write;
  wire execute_reg_in_clr; //from hazard

  //inputs for execute module
  wire [2:0] execute_in_ALUControlE;
  wire execute_in_ALUSrcE;
  wire execute_in_RegDstE;
  wire [31:0] execute_in_reg1;
  wire [31:0] execute_in_reg2;
  wire [4:0] execute_in_RsE;
  wire [4:0] execute_in_RtE;
  wire [4:0] execute_in_RdE;
  wire [31:0] execute_in_SignImmE;
  wire [1:0] execute_in_ForwardAE;
  wire [1:0] execute_in_ForwardBE;
  wire [31:0] execute_in_ForwardMemVal;
  wire [31:0] execute_in_ForwardExecVal;

  //inputs for memory register
  wire memory_reg_in_syscall;
  wire memory_reg_in_reg_write;
  wire memory_reg_in_mem_to_reg;
  wire memory_reg_in_mem_write;
  wire [31:0] memory_reg_in_instruction;
  wire [31:0] memory_reg_in_ALUOutput;
  wire [31:0] memory_reg_in_WriteDataE;
  wire [4:0] memory_reg_in_WriteRegE;

  //inputs for memory module
  wire memory_in_syscall;
  wire memory_in_RegWriteM;
  wire memory_in_MemToRegM;
  wire memory_in_MemWriteM;
  wire memory_in_ForwardMM;
  wire [31:0] memory_in_instruction;
  //wire aluout is declared in decode
  wire [31:0] memory_in_WritedataM;
  wire [4:0] memory_in_WriteRegM;
  wire [31:0] memory_in_resultW;

  //inputs for writeback register module
  wire wb_reg_in_RegWriteW;
  wire wb_reg_in_MemtoRegM_out;
  wire [31:0] wb_reg_in_RD;
  wire [31:0] wb_reg_in_ALUOut;
  wire [4:0] wb_reg_in_WriteRegM_out;
  wire [31:0] wb_reg_in_instruction;
  wire wb_reg_in_syscall;

  //inputs for writeback module
  //ALSO wire decode_in_regWriteW; // regwrite control signal from write back
  //ALSO wire decode_in_write_from_wb // register write back
  wire wb_in_MemToRegW;
  wire [31:0] wb_in_ReadDataW;
  wire [31:0] wb_in_ALUOutW;
  wire [4:0] wb_in_WriteRegW;
  wire [31:0] wb_in_instruction;
  wire wb_in_syscall;
  wire [31:0] wb_in_a0;
  wire [31:0] wb_in_v0;
  wire [31:0] wb_in_a1;


  //inputs for hazard module
  wire hazard_in_branchD; //from branch
  wire [4:0] hazard_in_RsD; //from decode
  wire [4:0] hazard_in_RtD; //from decode
  wire hazard_in_MemtoRegE; //from execute register
  wire hazard_in_RegWriteE; //from execute register
  wire [4:0] hazard_in_RsE; //from execute
  wire [4:0] hazard_in_RtE; //from execute
  wire [4:0] hazard_in_WriteRegE; //from execute
  wire hazard_in_MemtoRegM; //from memory register
  wire hazard_in_RegWriteM; //from memory register
  wire [4:0] hazard_in_WriteRegM; // from memory
  wire hazard_in_RegWriteW; //from writeback register
  wire [4:0] hazard_in_WriteRegW; //from writeback
  wire [4:0] hazard_in_RtM;
  wire hazard_in_MemWriteM;

  // fetch declaration
  fetch fetch_module(.jump(fetch_in_jump), .jump_reg(fetch_in_jump_reg),
  .branch(fetch_in_branch),
  .branch_addr(fetch_in_branch_addr), .jump_reg_addr(fetch_in_jump_reg_adddr),
  .jump_addr(fetch_in_jump_addr),
  .enable(fetch_in_enable), .clk(clock), .string_index(fetch_in_string_index), .print_string(fetch_in_print_string),
  .instr(decode_reg_in_instr),
  .pc_plus_4(decode_reg_in_pc_plus_4));

  //decode register declaration\
  reg_d reg_d_module(.clk(clock), .enable(decode_reg_in_enable), .clr(decode_reg_in_clr),
  .instruction_in(decode_reg_in_instr), .pc_plus_4_in(decode_reg_in_pc_plus_4), .pc_out(decode_in_instrD), .pc_plus_4_out(decode_in_pc_plus_4));

  //decode declaration
  decode decode_module(.clk(clock),
  .pc_plus_4_decoded(decode_in_pc_plus_4), .instrD(decode_in_instrD), .write_from_wb(decode_in_write_from_wb),
  .alu_out(decode_in_alu_out), .forwardAD(decode_in_forwardAD), .forwardBD(decode_in_forwardBD), .regWriteW(decode_in_regWriteW), .write_register(decode_in_write_register),
  .syscall_out(execute_reg_in_syscall), .syscall_instr_out(execute_reg_in_instruction), .a0_out(wb_in_a0), .v0_out(wb_in_v0),
  .a1_out(wb_in_a1), .regWrite_out(execute_reg_in_reg_write), .mem_to_reg_out(execute_reg_in_mem_to_reg), .alu_ctrl_out(execute_reg_in_alu_ctrl),
  .alu_src_out(execute_reg_in_alu_src), .reg_dst_out(execute_reg_in_reg_dst), .rd1_out(execute_reg_in_rd1), .rd2_out(execute_reg_in_rd2),
  .rsd_out(execute_reg_in_rsD), .rtd_out(execute_reg_in_rtD), .rde_out(execute_reg_in_rdE), .sign_immd_out(execute_reg_in_sign_immediate),
  .mem_write_out(execute_reg_in_mem_write), .branch_addr_out(fetch_in_branch_addr), .pc_src_out(fetch_in_branch), .pc_src_to_decode_out(decode_reg_in_clr), .jump_control_out(fetch_in_jump),
  .jr_control_out(fetch_in_jump_reg), .branch_d_out(hazard_in_branchD), .jump_reg_addr_out(fetch_in_jump_reg_adddr), .jump_addr_out(fetch_in_jump_addr),
  .rsd_hazard_out(hazard_in_RsD), .rtd_hazard_out(hazard_in_RtD));

  //execute register declaration
  reg_e reg_e_module(.clk(clock), .clr(execute_reg_in_clr), .syscall_in(execute_reg_in_syscall), .regwrite_in(execute_reg_in_reg_write),
  .mem_to_reg_in(execute_reg_in_mem_to_reg), .alu_ctrl_in(execute_reg_in_alu_ctrl), .alu_src_in(execute_reg_in_alu_src), .reg_dst_in(execute_reg_in_reg_dst),
  .rd1_in(execute_reg_in_rd1), .rd2_in(execute_reg_in_rd2), .rsd_in(execute_reg_in_rsD), .rtd_in(execute_reg_in_rtD), .rte_in(execute_reg_in_rdE),
  .sign_immd_in(execute_reg_in_sign_immediate), .mem_write_in(execute_reg_in_mem_write), .instr_in(execute_reg_in_instruction), .syscall_out(memory_reg_in_syscall), .reg_write_out(memory_reg_in_reg_write), .mem_to_reg_out(memory_reg_in_mem_to_reg),
  .alu_ctrl_out(execute_in_ALUControlE), .alu_src_out(execute_in_ALUSrcE), .reg_dst_out(execute_in_RegDstE), .rd1_out(execute_in_reg1), .rd2_out(execute_in_reg2),
  .rse_out(execute_in_RsE), .rte_out(execute_in_RtE), .rde_out(execute_in_RdE), .sign_immd_out(execute_in_SignImmE), .mem_write_out(memory_reg_in_mem_write),
  .instr_out(memory_reg_in_instruction), .mem_to_reg_hazard_out(hazard_in_MemtoRegE), .reg_write_hazard_out(hazard_in_RegWriteE));

  //execute register declaration
  execute execute_module(.ALUControlE(execute_in_ALUControlE), .ALUSrcE(execute_in_ALUSrcE), .RegDstE(execute_in_RegDstE),
  .reg1(execute_in_reg1), .reg2(execute_in_reg2), .RsE(execute_in_RsE), .RtE(execute_in_RtE), .RdE(execute_in_RdE),
  .SignImmE(execute_in_SignImmE), .ForwardAE(execute_in_ForwardAE), .ForwardBE(execute_in_ForwardBE), .ForwardMemVal(execute_in_ForwardMemVal),
  .ForwardExecVal(execute_in_ForwardExecVal), .RsEHazard(hazard_in_RsE), .RtEHazard(hazard_in_RtE), .ALUOutput(memory_reg_in_ALUOutput),
  .WriteDataE(memory_reg_in_WriteDataE), .WriteRegE(memory_reg_in_WriteRegE), .Hazard_WriteRegE(hazard_in_WriteRegE));

  //memory register module declaration
  reg_m reg_m_module(.clk(clock), .syscall_in(memory_reg_in_syscall), .regwrite_in(memory_reg_in_reg_write),
  .mem_to_reg_in(memory_reg_in_mem_to_reg), .mem_write_in(memory_reg_in_mem_write), .alu_output_in(memory_reg_in_ALUOutput),
  .write_data_in(memory_reg_in_WriteDataE), .write_reg_in(memory_reg_in_WriteRegE),
  .instr_in(memory_reg_in_instruction), .RtE(execute_in_RtE), .syscall_out(memory_in_syscall), .regwrite_out(memory_in_RegWriteM), .mem_to_reg_out(memory_in_MemToRegM),
  .mem_write_out(memory_in_MemWriteM), .alu_output_out(decode_in_alu_out), .write_data_out(memory_in_WritedataM), .write_reg_out(memory_in_WriteRegM),
  .instr_out(memory_in_instruction), .mem_to_reg_hazard_out(hazard_in_MemtoRegM), .regwrite_m_hazard_out(hazard_in_RegWriteM), .RtM(hazard_in_RtM), .hazard_in_MemWriteM(hazard_in_MemWriteM));

  //memory module declaration
  memory memory_module(.syscall(memory_in_syscall), .RegWriteM(memory_in_RegWriteM), .MemToRegM(memory_in_MemToRegM),
  .MemWriteM(memory_in_MemWriteM), .instruction(memory_in_instruction), .ALUOutM(decode_in_alu_out),
  .WriteDataM(memory_in_WritedataM), .WriteRegM(memory_in_WriteRegM), .ForwardMM(memory_in_ForwardMM), .ResultW(memory_in_resultW), .RegWriteW(wb_reg_in_RegWriteW), .MemtoRegM_out(wb_reg_in_MemtoRegM_out),
  .RD(wb_reg_in_RD), .WriteRegM_out(wb_reg_in_WriteRegM_out), .WriteRegM_out_hazard(hazard_in_WriteRegM), .ALUOutW(wb_reg_in_ALUOut),
  .ALUOut_forwarded(execute_in_ForwardExecVal), .instruction_out(wb_reg_in_instruction), .syscall_out(wb_reg_in_syscall));

  //writeback register module declaration
  reg_w reg_w_module(.clk(clock), .regwrite_in(wb_reg_in_RegWriteW), .mem_to_reg_in(wb_reg_in_MemtoRegM_out), .rd_data_mem_in(wb_reg_in_RD),
  .ALU_outM_in(wb_reg_in_ALUOut), .write_regM_in(wb_reg_in_WriteRegM_out), .instruction_in(wb_reg_in_instruction), .syscall_in(wb_reg_in_syscall),
   .regwrite_out(decode_in_regWriteW), .mem_to_reg_out(wb_in_MemToRegW), .read_data_w_out(wb_in_ReadDataW),
  .ALU_out_w_out(wb_in_ALUOutW), .write_regW_out(wb_in_WriteRegW), .regwrite_hazard_out(hazard_in_RegWriteW), .instruction_out(wb_in_instruction),
  .syscall_out(wb_in_syscall));

  //writeback module declaration
  writeback wb_module(.MemToRegW(wb_in_MemToRegW), .ReadDataW(wb_in_ReadDataW), .ALUOutW(wb_in_ALUOutW),
  .WriteRegW(wb_in_WriteRegW), .instruction_in(wb_in_instruction), .syscall_in(wb_in_syscall),
  .a0(wb_in_a0), .v0(wb_in_v0), .a1(wb_in_a1), .WriteRegW_out(hazard_in_WriteRegW), .ResultW(decode_in_write_from_wb), .WriteRegW_out_toRegisters(decode_in_write_register),
  .ResultW_forwarded(execute_in_ForwardMemVal), .ResultW_forwardedMM(memory_in_resultW),
  .string_index(fetch_in_string_index), .print_string(fetch_in_print_string));

  //hazard module declaration
  hazard hazard_module(.clk(clock), .branchD(hazard_in_branchD), .RsD(hazard_in_RsD), .RtD(hazard_in_RtD),
  .RsE(hazard_in_RsE), .RtE(hazard_in_RtE), .RtM(hazard_in_RtM), .MemToRegE(hazard_in_MemtoRegE), .RegWriteE(hazard_in_RegWriteE),
  .WriteRegE(hazard_in_WriteRegE), .WriteRegM(hazard_in_WriteRegM), .MemToRegM(hazard_in_MemtoRegM),
  .RegWriteM(hazard_in_RegWriteM), .WriteRegW(hazard_in_WriteRegW), .RegWriteW(hazard_in_RegWriteW), .MemWriteM(hazard_in_MemWriteM),
  .StallF(fetch_in_enable), .StallD(decode_reg_in_enable), .ForwardAD(decode_in_forwardAD), .ForwardBD(decode_in_forwardBD),
  .FlushE(execute_reg_in_clr), .ForwardAE(execute_in_ForwardAE), .ForwardBE(execute_in_ForwardBE), .ForwardMM(memory_in_ForwardMM));

    //clock logic
  always
    begin
      #10; clock = ~clock; // inline clock generator that the rest of the mips uses
    end

  //set up some nice gtkwave stuff
  initial begin
    $dumpfile("pipeline_overview.vcd");
    $dumpvars(0, pipeline_overview);
  end

endmodule
