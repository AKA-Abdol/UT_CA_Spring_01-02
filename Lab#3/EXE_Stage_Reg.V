module EXE_Stage_Reg (
    input clk, rst,
    input wb_en_in, mem_read_en_in, mem_write_en_in,
    input [31:0] alu_res_in, br_addr_in, val_Rm_in,
    output reg wb_en, mem_read_in, mem_write_en,
    output reg[31:0] alu_res, br_addr, val_Rm
);

always @(posedge clk, posedge rst) begin
        if (rst == 1'b1) begin
            mem_read_en <= 1'b0;
            mem_write_en <= 1'b0;
            wb_en <= 1'b0;
            alu_res <= 32'b0;
            val_rm <= 32'b0;
            val_Rm <= 32'b0;
            //dest <= 4'b0;
        end
        else begin
            mem_read_en <= mem_read_en_in;
            mem_write_en <= mem_write_en_in;
            wb_en <= wb_en_in;
            alu_res <= alu_res_in;
            val_rm <= val_rm_in;
            val_Rm <= val_Rm_in;
            //dest <= dest_in;
        end
    end

endmodule