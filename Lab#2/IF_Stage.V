module IF_Stage (
    input clk, rst, freeze, Branch_taken,
    input[31:0] BranchAddr,
    output reg [31:0] PC, 
	output Instruction
);

wire [6:0] mem [31:0];
assign mem[0] = 32'b00000000001000100000000000000000;
assign mem[1] = 32'b00000000011001000000000000000000;
assign mem[2] = 32'b00000000101001100000000000000000;
assign mem[3] = 32'b00000000111010000001000000000000;
assign mem[4] = 32'b00000001001010100001100000000000;
assign mem[5] = 32'b00000001011011000000000000000000;
assign mem[6] = 32'b00000001101011100000000000000000;

always @(posedge clk, posedge rst) begin
    if(rst)
        PC <= 0;
    else
        PC <= PC + 4;
end

assign Instruction = mem[PC >> 2];
endmodule