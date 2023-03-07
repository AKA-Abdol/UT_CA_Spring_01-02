module Register_File (
    input clk, rst,
    input [3:0] src1, src2, Dest_wb,
    input[31:0] Result_WB,
    input writeBackEn,
    output [31:0] reg1, reg2
);
    reg [14:0] regFile [31:0];

    always @(posedge rst) begin 
        if(rst) begin
            reg1 = 0;
            reg2 = 0;
        end
    end

    always @(negedge clk) begin
        if(writeBackEn)
            regFile[Dest_wb] <= Result_WB;
    end

    assign reg1 = regFile[src1];
    assign reg2 = regFile[src2];
endmodule