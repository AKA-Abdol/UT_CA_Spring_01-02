// consider Dest is wrong and should be define again!  
module EXE_Stage (
    input clk, B, 
    input [3:0] exe_cmd,
    input mem_read_en_in, mem_write_en_in, wb_en_in,
    input [31:0] PC, val_Rn, val_Rm_in, 
    input imm,
    input [11:0] shift_operand,
    input [23:0] signed_imm_24,
    input [3:0] status_register,
    input [3:0] dest_in,
    input [1:0] sel_src1, sel_src2,
    input [31:0] alu_res_mem, wb_value,

    output mem_read_en, mem_write_en, wb_en, br_taken,
    output [31:0] alu_res, br_addr, val_Rm,
    output [3:0] status_bits,
    output [3:0] dest
);

    wire control_input;
    wire [31:0] val_2;
    wire [31:0] selected_val_Rm, selected_val_Rn;

    Mux4to1 #(32)
        mux_val_Rn(
            .input_0(val_Rn),
            .input_1(alu_res_mem),
            .input_2(wb_value),
            .input_3(),
            .sel(sel_src1),
            .selected_input(selected_val_Rn)
        );

    Mux4to1 #(32)
        mux_val_Rm(
            .input_0(val_Rm_in),
            .input_1(alu_res_mem),
            .input_2(wb_value),
            .input_3(),
            .sel(sel_src2),
            .selected_input(selected_val_Rm)
        );

    Val2_Generator val2_gen (
        .shift_operand(shift_operand),
        .imm(imm),
        .val_Rm(selected_val_Rm),
        .control_input(control_input),
        .val_2(val_2)
    );

    ALU alu (
        .val_1(selected_val_Rn),
        .val_2(val_2),   
        .c_in(status_register[3]), // carry in
        .exe_cmd(exe_cmd),
        .status_bits(status_bits),
        .result(alu_res)
    );

    assign mem_read_en = mem_read_en_in;
    assign mem_write_en = mem_write_en_in;
    assign wb_en = wb_en_in;
    assign br_addr = PC + (({{8{signed_imm_24[23]}}, signed_imm_24}) << 2); // final version
    assign control_input = mem_read_en_in | mem_write_en_in;
    assign val_Rm = selected_val_Rm;
    assign dest = dest_in;
    assign br_taken = B;

endmodule
