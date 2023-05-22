module SRAM_Controller (
    input clk, rst,
    input write_en, read_en,
    input [31:0] address, write_data,
    output [31:0] read_data,
    output ready,
    inout [15:0] SRAM_DQ,
    output [17:0] SRAM_ADDR,
    output SRAM_UB_N,
    output SRAM_LB_N,
    output SRAM_WE_N,
    output SRAM_CE_N,
    output SRAM_OE_N
);

    reg [2:0] counter;
    wire count_en;
    wire [31:0] address_low, address_high;

    assign SRAM_UB_N = 1'b0;
    assign SRAM_LB_N = 1'b0;
    assign SRAM_CE_N = 1'b0;
    assign SRAM_OE_N = 1'b0;

    assign count_en = write_en | read_en;

    assign address_low = ((address - 32'd1024) >> 2) << 2;
    assign address_high = address_low + 1;

    assign ready = ~count_en | (count_en & (counter > 4));
    
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            counter <= 3'b0;
        end
        else if (~count_en) begin
            counter <= 3'b0;
        end
        else begin
            if (clk) begin
                if (counter == 3'd5)
                    count <= 3'b0;
                else
                    counter <= counter + 3'b001;
            end
        end
    end

    always @(counter) begin
        if (write_en) begin
            case (counter)
                3'b000 : begin
                    SRAM_ADDR = address_low;
                    SRAM_DQ = write_data[15:0];
                    SRAM_WE_N = 1'b0;
                end
                3'b001 : begin
                    SRAM_ADDR = address_high;
                    SRAM_DQ = write_data[31:16];
                    SRAM_WE_N = 1'b0;
                end
                default : 
                    SRAM_WE_N = 1'b1;
            endcase
        end
        else if (read_en) begin
            case (counter)
                3'b000 : begin
                    SRAM_ADDR = address_low;
                    SRAM_DQ = 16'bz;
                    SRAM_WE_N = 1'b1;
                end
                3'b001 : begin
                    SRAM_ADDR = address_high;
                    read_data[15:0] = SRAM_DQ;
                    SRAM_DQ = 16b'z;
                    SRAM_WE_N = 1'b1;
                end
                default : 
                    SRAM_WE_N = 1'b1;
            endcase
        end
    end

    
endmodule