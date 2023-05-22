module ARMv6TB ();
    reg clk = 0, rst = 0;

ARMv6 arm(clk, rst);

    always #10 clk = ~clk;
    initial begin
        #15 rst = 1;
        #10 rst = 0;
        #25000 $stop; // TB time should be extended for 1 more command
    end

endmodule