module SRAMTB ();
    reg clk = 0, rst = 0;
    reg write_en = 0, read_en = 0;
    reg [31:0] address, write_data;
    wire [31:0] read_data;
    wire ready, SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N;
    wire SRAM_WE_N;
    wire [17:0] SRAM_ADDR;
    inout [15:0] SRAM_DQ;


    SRAM_Controller sramController(
        clk, rst,
        write_en, read_en,
        address, write_data,
        read_data, 
        ready,
        SRAM_DQ,
        SRAM_ADDR,
        SRAM_UB_N,
        SRAM_LB_N,
        SRAM_WE_N,
        SRAM_CE_N,
        SRAM_OE_N
    );

    always #10 clk = ~clk;
    initial begin
        #15 rst = 1;
        #10 rst = 0;
        #25 write_en = 1; address = 32'd1029; write_data = 32'b00000000000000100000000000000001;
        #120 write_en = 0;
        #25 read_en = 1; address = 32'd1029; write_data = 32'b00000000000000100000000000000001;
        #10 SRAM_DQ = 16'd1;
        #20 SRAM_DQ = 16'd2;
        #90 read_en = 0;
        #50 $stop;
    end
    
endmodule