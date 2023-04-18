module MEM_Stage_Reg(
    input clk, rst, wb_en_in, mem_read_en_in,
    input[31:0] alu_result_in, mem_read_value_in,
    input [3:0] dest_in,
    output reg wb_en, mem_read_en,
    output reg[31:0] alu_result, mem_read_value,
    output reg[3:0] dest
);

always @(posedge clk, posedge rst) begin 
    if(rst) begin
        wb_en <= 1'b0;
        mem_read_en <= 1'b0;
        alu_result <= 32'b0;
        mem_read_value <= 32'b0;
        dest <= 4'b0;
    end
    else begin
        wb_en <= wb_en_in;
        mem_read_en <= mem_read_en_in;
        alu_result <= alu_result_in;
        mem_read_value <= mem_read_value_in;
        dest <= dest_in;
    end
end

endmodule