module ID_Stage_Reg(
    input clk, rst, flush,
    input wb_en_in, mem_read_en_in, mem_write_en_in,
    input B_in, S_in,
    input[3:0] exe_cmd_in,
    input[31:0] PC_in,
    input[31:0] val_Rn_in, val_Rm_in,
    input[11:0] shift_operand_in,
    input[3:0] dest_in,
    input[3:0] status_register,
    input imm_in,
    input[23:0] signed_imm_24_in,
    input[3:0] src1_in, src2_in,
    input freeze,

    output reg wb_en, mem_read_en, mem_write_en, B, S,
    output reg[3:0] exe_cmd,
    output reg[31:0] PC, 
    output reg[31:0] val_Rn, val_Rm,
    output reg[11:0] shift_operand,
    output reg[3:0] dest,
    output reg[3:0] status_register_id,
    output reg imm,
    output reg[23:0] signed_imm_24,
    output reg[3:0] src1, src2
);

always @(posedge clk, posedge rst) begin 
    if(rst) begin
        {wb_en, mem_read_en, mem_write_en, B, S, exe_cmd} <= 9'b0;
        PC <= 32'b0;
        val_Rn <= 32'b0;
        val_Rm <= 32'b0;
        shift_operand <= 12'b0;
        dest <= 4'b0;
        status_register_id <= 4'b0;
        imm <= 1'b0;
        signed_imm_24 <= 24'b0;
        src1 <= 4'b0;
        src2 <= 4'b0;
    end
    else if (flush) begin
        {wb_en, mem_read_en, mem_write_en, B, S, exe_cmd} <= 9'b0;
        PC <= 32'b0;
        val_Rn <= 32'b0;
        val_Rm <= 32'b0;
        shift_operand <= 12'b0;
        dest <= 4'b0;
        status_register_id <= 4'b0;
        imm <= 1'b0;
        signed_imm_24 <= 24'b0;
        src1 <= 4'b0;
        src2 <= 4'b0;
    end
    else begin
        if (freeze) begin
            wb_en <= wb_en;
            mem_read_en <= mem_read_en;
            mem_write_en <= mem_write_en;
            B <= B;
            S <= S;
            exe_cmd <= exe_cmd;
            PC <= PC;
            val_Rn <= val_Rn;
            val_Rm <= val_Rm;
            shift_operand <= shift_operand;
            dest <= dest;
            status_register_id <= status_register_id;
            imm <= imm;
            signed_imm_24 <= signed_imm_24;
            src1 <= src1;
            src2 <= src2;
        end
        else begin
            wb_en <= wb_en_in;
            mem_read_en <= mem_read_en_in;
            mem_write_en <= mem_write_en_in;
            B <= B_in;
            S <= S_in;
            exe_cmd <= exe_cmd_in;
            PC <= PC_in;
            val_Rn <= val_Rn_in;
            val_Rm <= val_Rm_in;
            shift_operand <= shift_operand_in;
            dest <= dest_in;
            status_register_id <= status_register;
            imm <= imm_in;
            signed_imm_24 <= signed_imm_24_in;
            src1 <= src1_in;
            src2 <= src2_in;
        end
    end
end

endmodule