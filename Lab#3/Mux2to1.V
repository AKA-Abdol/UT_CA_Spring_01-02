module Mux2to1 #(parameter N = 4) (
    input[N-1:0] input_0, input_1,
    input sel,
    output[N-1:0] selected_input
);
    assign selected_input = (sel == 1'b1) ? input_1 : input_0;
endmodule