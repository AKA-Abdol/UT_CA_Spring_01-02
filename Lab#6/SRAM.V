module SRAM (
    input clk, rst,
    input SRAM_WE_N,
    inout [15:0] SRAM_DQ,
    input [17:0] SRAM_ADDR
);
    reg[15:0] memory[0:255];
    integer i;

    assign #12 SRAM_DQ = SRAM_WE_N ? memory[SRAM_ADDR] : 16'bz;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            for(i = 0; i < 256; i = i + 1)
                memory[i] = 16'b0; 
        end
        else if (~SRAM_WE_N) begin
            memory[SRAM_ADDR] = SRAM_DQ;
        end
    end
endmodule