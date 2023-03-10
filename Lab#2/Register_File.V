module Register_File (
    input clk, rst,
    input [3:0] src1, src2, dest_wb,
    input[31:0] Result_WB,
    input writeBackEn,
    output [31:0] reg1, reg2
);
    reg[31:0] regFile[0:14];

    always @(negedge clk, posedge rst) begin 
        if(rst) begin
            regFile[0] <= 32'd0;
            regFile[1] <= 32'd1;
            regFile[2] <= 32'd2;
            regFile[3] <= 32'd3;
            regFile[4] <= 32'd4;
            regFile[5] <= 32'd5;
            regFile[6] <= 32'd6;
            regFile[7] <= 32'd7;
            regFile[8] <= 32'd8;
            regFile[9] <= 32'd9;
            regFile[10] <= 32'd10;
            regFile[11] <= 32'd11;
            regFile[12] <= 32'd12;
            regFile[13] <= 32'd13;
            regFile[14] <= 32'd14;
        end
        else if(writeBackEn)
            regFile[dest_wb] <= Result_WB;
    end

    assign reg1 = regFile[src1];
    assign reg2 = regFile[src2];
endmodule