module ALU (
    input [31:0] val_1, val_2,
    input c_in,
    input [3:0] exe_cmd,
    output [3:0] status_bits,
    output reg [31:0] result
);

    wire N, Z, V;
    reg C;

    wire [32:0] res_1,res_2,res_3,res_4,res_5,res_6,res_7,res_8,res_9; // 1 more bit for carry
    assign res_1 = (val_1 - val_2 - {31'b0, ~c_in});
    assign res_2 = (val_1 + val_2 + c_in);
    assign res_3 = (val_1 + val_2);
    assign res_4 = (val_1 - val_2);
    assign res_5 = (val_1 & val_2);
    assign res_6 = (val_1 | val_2);
    assign res_7 = (val_1 ^ val_2);
    assign res_8 = (~val_2);
    assign res_9 = (val_2);

    always @(exe_cmd, val_1, val_2, c_in) begin
        case(exe_cmd)
            4'b0101: {C, result} <= res_1;    //SBC
            4'b0011: {C, result} <= res_2;    //ADC
            4'b0010: {C, result} <= res_3;    //ADD, LDR, STR
            4'b0100: {C, result} <= res_4;    //SUB, CMP
            4'b0110: {C, result} <= res_5;    //AND, TST
            4'b0111: {C, result} <= res_6;    //ORR
            4'b1000: {C, result} <= res_7;    //EOR
            4'b1001: {C, result} <= res_8;    //MVN
            4'b0001: {C, result} <= res_9;    //MOV
            default: {C, result} <= 33'b0;
        endcase
    end

    assign N = result[31];
    assign V = (  (exe_cmd == 4'b0010 | exe_cmd == 4'b0011)  &  ( ((~val_1[31])&(~val_2[31])&result[31]) | (val_1[31]&val_2[31]&(~result[31])) )  ) ? 1'b1:
               (  (exe_cmd == 4'b0100 | exe_cmd == 4'b0101)  &  ( (val_1[31]&(~val_2[31])&(~result[31])) | ((~val_1[31])&val_2[31]&result[31]) )  ) ? 1'b1:
                1'b0;
    assign Z = (result == 32'b0) ? 1'b1 : 1'b0;
               
    assign status_bits = {C, N, V, Z};
    
endmodule