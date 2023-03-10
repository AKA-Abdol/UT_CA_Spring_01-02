module IF_Stage_Reg (
    input clk, rst, freeze, flush,
    input [31:0] Instruction_in, PC_in,
    output reg [31:0] PC, Instruction
);

always @(posedge clk, posedge rst) begin
    if(rst)
        PC <= 0;
    else begin
        PC <= PC_in;
        Instruction <= Instruction_in;
    end
end

endmodule