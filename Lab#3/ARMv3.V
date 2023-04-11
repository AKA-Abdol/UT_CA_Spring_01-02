module ARMv3(
    input clk, rst
);
wire freeze, Branch_taken, flush;
wire[31:0] BranchAddr, PC_IF_In, PC_IF, Instruction_IF_In, Instruction_IF;
wire[31:0] PC_ID, PC_EXE_In, PC_EXE, PC_MEM_In, PC_MEM, PC;

wire[31:0] Result_WB;
wire writeBackEn;
wire[3:0] dest_wb;
wire mem_read_en, mem_write_en, wb_en, S, B, mem_read_en_in, mem_write_en_in, wb_en_in, S_in, B_in;
wire[3:0] exe_cmd, exe_cmd_in;
wire[31:0] val_Rn, val_Rm, val_Rn_in, val_Rm_in;
wire[11:0] shift_operand, shift_operand_in;
wire[3:0] dest, dest_in;
wire [3:0] status_register_id;

wire mem_read_en_exe, mem_write_en_exe, wb_en_exe;
wire [31:0] alu_res_exe, br_addr_exe, val_Rm_exe;
wire [3:0] status_bits;

wire [3:0] status_register;

wire [31:0] alu_res, br_addr, val_Rm_exe_reg;
wire wb_en_exe_reg, mem_read_en_exe_reg, mem_write_en_exe_reg;



assign freeze = 0;
assign flush = 0; 
assign Branch_taken = 0;
assign BranchAddr = 0;
assign Result_WB = 32'b0;
assign writeBackEn = 0;
assign dest_wb = 4'b0;
// assign status_register = 4'b0; Defined!


IF_Stage if_stage(clk, rst, freeze, Branch_taken, BranchAddr, PC_IF_In, Instruction_IF_In);

IF_Stage_Reg if_stage_reg(clk, rst, freeze, flush, Instruction_IF_In, PC_IF_In, PC_IF, Instruction_IF);

wire imm_id, imm;
wire [23:0] signed_imm_24_id, signed_imm_24;

ID_Stage id_stage(
    clk, rst,
    Instruction_IF,
    Result_WB, 
    writeBackEn, 
    dest_wb, 
    status_register, 

    mem_read_en_in, mem_write_en_in, wb_en_in, S_in, B_in,
    exe_cmd_in,
    val_Rn_in, val_Rm_in,
    shift_operand_in,
    dest_in,
    imm_id,
    signed_imm_24_id
);

ID_Stage_Reg id_stage_reg(
    clk, rst, flush,
    wb_en_in, mem_read_en_in, mem_write_en_in,
    B_in, S_in,
    exe_cmd_in,
    PC_IF,
    val_Rn_in, val_Rm_in,
    shift_operand_in,
    dest_in,
    status_register,
    imm_id,
    signed_imm_24_id,

    wb_en, mem_read_en, mem_write_en, B, S,
    exe_cmd, 
    PC_ID,
    val_Rn, val_Rm,
    shift_operand,
    dest,
    status_register_id,
    imm,
    signed_imm_24
);

EXE_Stage exe_stage(
    clk,
    exe_cmd, 
    mem_read_en, mem_write_en, wb_en,
    PC_ID, val_Rn, val_Rm,
    imm, // defined
    shift_operand,
    signed_imm_24, // defined
    status_register_id,
    mem_read_en_exe, mem_write_en_exe, wb_en_exe,
    alu_res_exe, br_addr_exe, val_Rm_exe,
    status_bits
);

Status_Register status_register(
    clk, rst, S,
    status_bits,
    status_register
);

EXE_Stage_Reg exe_stage_reg(
    clk, rst, 
    wb_en_exe, mem_read_en_exe, mem_write_en_exe,
    alu_res_exe, br_addr_exe, val_Rm_exe,
    wb_en_exe_reg, mem_read_en_exe_reg, mem_write_en_exe_reg,
    alu_res, br_addr, val_Rm_exe_reg
);


MEM_Stage mem_stage(clk, rst, PC_EXE, PC_MEM_In);

MEM_Stage_Reg meme_stage_reg(clk, rst, PC_MEM_In, PC_MEM);


WB_Stage wb_stage(clk, rst, PC_MEM, PC);

endmodule