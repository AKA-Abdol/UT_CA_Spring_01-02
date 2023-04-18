module ARMv4TB ();
    reg clk = 0, rst = 0;

ARMv4 arm(clk, rst);

    always #10 clk = ~clk;
    initial begin
        #15 rst = 1;
        #10 rst = 0;
        #380 $stop; // TB time should be extended for 1 more command
    end

endmodule