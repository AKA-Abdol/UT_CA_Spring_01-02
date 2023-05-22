module Mux4to1 #(parameter N = 32) (
    input[N-1:0] input_0, input_1, input_2, input_3,
    input[1:0] sel,
    output[N-1:0] selected_input
);

assign selected_input = (sel == 2'b00) ? input_0 : 
                        (sel == 2'b01) ? input_1 :
                        (sel == 2'b10) ? input_2 :
                        input_3;
    
endmodule