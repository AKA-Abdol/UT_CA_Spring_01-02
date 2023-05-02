module ARMv5(
    input clk, rst
);
//wire freeze;
wire[31:0] PC_IF_In, PC_IF, Instruction_IF_In, Instruction_IF;
wire[31:0] PC_ID, PC_EXE_In, PC_EXE, PC_MEM_In, PC_MEM, PC;


wire mem_read_en, mem_write_en, wb_en, S, B, mem_read_en_in, mem_write_en_in, wb_en_in, S_in, B_in;
wire[3:0] exe_cmd, exe_cmd_in;
wire[31:0] val_Rn, val_Rm, val_Rn_in, val_Rm_in;
wire[11:0] shift_operand, shift_operand_in;
wire[3:0] dest_id;
wire [3:0] status_register_id;
wire two_src;
wire imm_id, imm;
wire [23:0] signed_imm_24_id, signed_imm_24;

wire mem_read_en_exe, mem_write_en_exe, wb_en_exe;
wire [31:0] alu_res_exe, br_addr_exe, val_Rm_exe;
wire [3:0] status_bits;
wire [3:0] dest_exe;
wire br_taken;

wire [3:0] status_register;

wire [31:0] alu_res, br_addr, val_Rm_exe_reg;
wire wb_en_exe_reg, mem_read_en_exe_reg, mem_write_en_exe_reg;
wire [3:0] dest_exe_reg;

wire[31:0] mem_result;

wire[3:0] dest_mem;

wire wb_en_mem_reg, mem_read_en_mem_reg;
wire [31:0] alu_result_mem_reg, mem_read_value_mem_reg;
wire [3:0] dest_mem_reg;

wire wb_en_wb;
wire [31:0] wb_value;
wire [3:0] dest;

wire hazard;
wire [3:0] hazard_src1, hazard_src2;

wire [3:0] src1, src2;
wire [1:0] sel_src1, sel_src2;


// assign freeze = 0;
// assign status_register = 4'b0; Defined!


IF_Stage if_stage(
    clk, rst, hazard,
    br_taken, br_addr_exe, PC_IF_In, Instruction_IF_In
);

IF_Stage_Reg if_stage_reg(
    clk, rst, hazard, br_taken,
    Instruction_IF_In, PC_IF_In, PC_IF, Instruction_IF
);

// module ID_Stage(
//     input clk, rst, hazard,
//     input[31:0] Instruction,

//     input[31:0] Result_WB,
//     input writeBackEn,
//     input[3:0] dest_wb,

//     input[3:0] status_register,

//     output mem_read_en, mem_write_en, wb_en, S, B, two_src,
//     output[3:0] exe_cmd,
//     output[31:0] val_Rn, val_Rm,
//     output[11:0] shift_operand,
//     output[3:0] dest,
//     output imm,
//     output[23:0] signed_imm_24,
//     output[3:0] hazard_src1, hazard_src2
// );

ID_Stage id_stage(
    clk, rst, hazard,
    Instruction_IF,
    wb_value, 
    wb_en_wb, 
    dest, 
    status_register, 

    mem_read_en_in, mem_write_en_in, wb_en_in, S_in, B_in, two_src,
    exe_cmd_in,
    val_Rn_in, val_Rm_in,
    shift_operand_in,
    dest_id,
    imm_id,
    signed_imm_24_id,
    hazard_src1, hazard_src2
);

ID_Stage_Reg id_stage_reg(
    clk, rst, br_taken,
    wb_en_in, mem_read_en_in, mem_write_en_in,
    B_in, S_in,
    exe_cmd_in,
    PC_IF,
    val_Rn_in, val_Rm_in,
    shift_operand_in,
    dest_id,
    status_register,
    imm_id,
    signed_imm_24_id,
    hazard_src1, hazard_src2,

    wb_en, mem_read_en, mem_write_en, B, S,
    exe_cmd, 
    PC_ID,
    val_Rn, val_Rm,
    shift_operand,
    dest_exe,
    status_register_id,
    imm,
    signed_imm_24,
    src1, src2
);

EXE_Stage exe_stage(
    clk, B,
    exe_cmd, 
    mem_read_en, mem_write_en, wb_en,
    PC_ID, val_Rn, val_Rm,
    imm, // defined
    shift_operand,
    signed_imm_24, // defined
    status_register_id,
    dest_exe,
    sel_src1, sel_src2,
    alu_res, wb_value,

    mem_read_en_exe, mem_write_en_exe, wb_en_exe, br_taken,
    alu_res_exe, br_addr_exe, val_Rm_exe,
    status_bits,
    dest_exe_reg
);

Status_Register status_register_ins(
    clk, rst, S,
    status_bits,
    status_register
);

EXE_Stage_Reg exe_stage_reg(
    clk, rst, 
    wb_en_exe, mem_read_en_exe, mem_write_en_exe,
    alu_res_exe, br_addr_exe, val_Rm_exe,
    dest_exe_reg,

    wb_en_exe_reg, mem_read_en_exe_reg, mem_write_en_exe_reg,
    alu_res, br_addr, val_Rm_exe_reg,
    dest_mem
);

Memory memory_ins(
    clk, rst, mem_read_en_exe_reg, mem_write_en_exe_reg,
    alu_res, val_Rm_exe_reg,

    mem_result
);

MEM_Stage_Reg mem_stage_reg(
    clk, rst, wb_en_exe_reg, mem_read_en_exe_reg, 
    alu_res, mem_result, 
    dest_mem, 

    wb_en_mem_reg, mem_read_en_mem_reg,
    alu_result_mem_reg, mem_read_value_mem_reg,
    dest_mem_reg
);

// OLD
// module Hazard_Detection_Unit (
//     input clk, rst,
//     input two_src, exe_wb_en, mem_wb_en,
//     input [3:0] src1, src2, exe_dest, mem_dest,
//     output reg hazard
// );

// NEW
// module Hazard_Detection_Unit2 (
//     input clk, rst,
//     input two_src, exe_mem_read_en,
//     input [3:0] src1, src2, exe_dest,
//     output reg hazard
// );
Hazard_Detection_Unit hazard_detection_unit(
    clk, rst,
    two_src, wb_en_exe, mem_read_en_exe,
    hazard_src1, hazard_src2, dest_exe,
    hazard
);

WB_Stage wb_stage(
    mem_read_en_mem_reg, wb_en_mem_reg,
    alu_result_mem_reg, mem_read_value_mem_reg,
    dest_mem_reg,

    wb_en_wb,
    wb_value, 
    dest
);

Forwarding_Unit forwarding_unit(
    clk, rst, 
    wb_en_mem_reg, wb_en_wb,
    src1, src2, 
    dest_mem_reg, dest, 
    sel_src1, sel_src2
);

endmodule