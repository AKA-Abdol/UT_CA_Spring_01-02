module Control_Unit (
    input [1:0] mode,
    input [3:0] op_code,
    input s_in,
    output S,
    output mem_read_en, mem_write_en,
    output wb_en, B,
    output reg [3:0] exe_cmd
);

assign S = (mode == 2'b01 | mode == 2'b10) ? 1'b0 :
            (op_code == 4'b1010 | op_code == 4'b1000) ? 1'b1 : s_in;

assign mem_read_en = (mode == 2'b01 & s_in == 1'b1) ? 1'b1 : 1'b0;

assign mem_write_en = (mode == 2'b01 & s_in == 1'b0) ? 1'b1 : 1'b0;

assign wb_en = (mode == 2'b10) ? 1'b0:
                (mode == 2'b01 & s_in == 1'b0) ? 1'b0:
                (mode == 1'b00 & (op_code == 4'b1010 | op_code == 4'b1000)) ? 1'b0 : 1'b1;

assign B = (mode == 2'b10) ? 1'b1 : 1'b0; //branch

always @(op_code, mode) begin
    if(mode == 2'b00 || mode == 2'b01) begin
        case(op_code)
            4'b1101: exe_cmd <= 4'b0001; //MOV
            4'b1111: exe_cmd <= 4'b1001; //MVN
            4'b0100: exe_cmd <= 4'b0010; //ADD, LDR, STR
            4'b0101: exe_cmd <= 4'b0011; //ADC
            4'b0010: exe_cmd <= 4'b0100; //SUB
            4'b0110: exe_cmd <= 4'b0101; //SBC
            4'b0000: exe_cmd <= 4'b0110; //AND
            4'b1100: exe_cmd <= 4'b0111; //ORR
            4'b0001: exe_cmd <= 4'b1000; //EOR
            4'b1010: exe_cmd <= 4'b0100; //CMP
            4'b1000: exe_cmd <= 4'b0110; //TST
            default: exe_cmd <= 4'b0000;
        endcase
    end
    else
        exe_cmd = 4'b0000;
end
endmodule