module Memory (
    input clk, rst, mem_read, mem_write,
    input[31:0] address, data, 
    output[31:0] mem_result
);
reg[31:0] memory[63:0];
integer i; // for initialization

assign mem_result = mem_read ? memory[(address - 4'd1024) >> 2] : 32'b0; // not needed the if

always @(posedge clk, posedge rst) begin
    if (rst) begin
       for(i = 0; i < 64; i = i + 1)
            memory[i] = 32'b0; 
    end
    else (mem_write) begin
        memory[(address - 4'd1024) >> 2] <= data;
    end
end
    
endmodule