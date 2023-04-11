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

    output reg wb_en, mem_read_en, mem_write_en, B, S,
    output reg[3:0] exe_cmd,
    output reg[31:0] PC, 
    output reg[31:0] val_Rn, val_Rm,
    output reg[11:0] shift_operand,
    output reg[3:0] dest,
    output reg[3:0] status_register_id,
);

always @(posedge clk, posedge rst) begin 
    if(rst || flush) begin
        {wb_en, mem_read_en, mem_write_en, B, S, exe_cmd} <= 9'b0;
        PC <= 32'b0;
        val_Rn <= 32'b0;
        val_Rm <= 32'b0;
        shift_operand <= 12'b0;
        dest <= 4'b0;
        status_register_id <= 4'b0;
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
    end
end

endmodule