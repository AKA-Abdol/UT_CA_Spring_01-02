module Status_Register(
    input clk, rst, ld, 
    input [3:0] status_register_in, 
    output reg [3:0] status_register
);

    always @(negedge clk, posedge rst) begin
        if (rst == 1'b1)
            status_register <= 4'b0;
        else begin
            if(ld == 1'b1)
                status_register <= status_register_in;
            else
                status_register <= status_register;
        end
    end

endmodule