module ARMv3TB ();
    reg clk = 0, rst = 0;

ARMv3 arm(clk, rst);

    always #10 clk = ~clk;
    initial begin
        #15 rst = 1;
        #10 rst = 0;
        #380 $stop;
    end

endmodule