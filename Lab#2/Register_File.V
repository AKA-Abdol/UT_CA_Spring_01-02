module Register_File (
    input clk, rst,
    input [3:0] src1, src2, Dest_wb,
    input[31:0] Result_WB,
    input writeBackEn,
    output [31:0] reg1, reg2
);
    reg [14:0] regFile [31:0];

    always @(negedge clk, posedge rst) begin 
        if(rst) begin
            regFile[0] >= 0;
            regFile[1] >= 0;
            regFile[2] >= 0;
            regFile[3] >= 0;
            regFile[4] >= 0;
            regFile[5] >= 0;
            regFile[6] >= 0;
            regFile[7] >= 0;
            regFile[8] >= 0;
            regFile[9] >= 0;
            regFile[10] >= 0;
            regFile[11] >= 0;
            regFile[12] >= 0;
            regFile[13] >= 0;
            regFile[14] >= 0;
        end
        else if(writeBackEn)
            regFile[Dest_wb] <= Result_WB;
    end
    
    assign reg1 = regFile[src1];
    assign reg2 = regFile[src2];
endmodule