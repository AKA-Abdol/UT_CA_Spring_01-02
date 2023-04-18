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

    output mem_read_en, mem_write_en, wb_en, br_taken,
    output [31:0] alu_res, br_addr, val_Rm,
    output [3:0] status_bits,
    output [3:0] dest
);

    wire control_input;
    wire [31:0] val_2;

    Val2_Generator val2_gen (
        .shift_operand(shift_operand),
        .imm(imm),
        .val_Rm(val_Rm_in),
        .control_input(control_input),
        .val_2(val_2)
    );

    ALU alu (
        .val_1(val_Rn),
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
    assign val_Rm = val_Rm_in;
    assign dest = dest_in;
    assign br_taken = B;

endmodule
