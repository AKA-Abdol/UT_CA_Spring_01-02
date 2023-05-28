module ARMv6TB ();
reg clk = 0, rst = 0;
wire  [15:0] SRAM_DQ;
wire  [17:0] SRAM_ADDR;
wire  SRAM_UB_N;
wire  SRAM_LB_N;
wire  SRAM_WE_N;
wire  SRAM_CE_N;
wire  SRAM_OE_N;

    ARMv6 arm(
        clk, rst,
        SRAM_DQ,
        SRAM_ADDR,
        SRAM_UB_N,
        SRAM_LB_N,
        SRAM_WE_N,
        SRAM_CE_N,
        SRAM_OE_N
    );

    SRAM sram(
        clk, rst,
        SRAM_WE_N,
        SRAM_DQ,
        SRAM_ADDR
    );


    always #10 clk = ~clk;
    initial begin
        #15 rst = 1;
        #10 rst = 0;
        #25000 $stop; // TB time should be extended for 1 more command
    end

endmodule