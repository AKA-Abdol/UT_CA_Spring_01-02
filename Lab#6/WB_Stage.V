module WB_Stage(
    input mem_read_en, wb_en_in,
    input[31:0] alu_result, mem_read_value,
    input[3:0] dest_in,
    
    output wb_en,
    output[31:0] wb_value,
    output[3:0] dest
);

assign wb_en = wb_en_in;
assign dest = dest_in;

Mux2to1 #(32)
    mux_wb(
        .input_0(alu_result),
        .input_1(mem_read_value),
        .sel(mem_read_en),
        .selected_input(wb_value)
    );

endmodule