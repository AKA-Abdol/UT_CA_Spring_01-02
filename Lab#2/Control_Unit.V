module Control_Unit (
    input [1:0] mode,
    input [3:0] Op_code,
    input s_in,
    output S,
    output reg mem_read_en, mem_write_en, wb_en, B,
    output reg [3:0] exe_cmd
);
    always @(mode, Op_code, s_in) begin
        {exe_cmd, mem_read_en, mem_write_en, wb_en, B} <= 9'b0;

        if(mode == 2'b10)
            B <= 1;
        else begin
            case (Op_code)

                4'b1101 : begin //MOV
                    exe_cmd <= 4'b0001;
                    wb_en <= 1;
                end
                4'b1111 : begin //MVN
                    exe_cmd <= 4'b1001;
                    wb_en <= 1;
                end
                4'b0100 : begin //ADD
                    exe_cmd <= 4'b0010;
                    wb_en <= 1;
                end
                4'b0101 : begin //ADC
                    exe_cmd <= 4'b0011;
                    wb_en <= 1;
                end
                4'b0010 : begin //SUB
                    exe_cmd <= 4'b0100;
                    wb_en <= 1;
                end
                4'b0110 : begin //SBC
                    exe_cmd <= 4'b0101;
                    wb_en <= 1;
                end
                4'b0000 : begin //AND
                    exe_cmd <= 4'b0110;
                    wb_en <= 1;
                end
                4'b1100 : begin //ORR
                    exe_cmd <= 4'b0111;
                    wb_en <= 1;
                end
                4'b0001 : begin //EOR
                    exe_cmd <= 4'b1000;
                    wb_en <= 1;
                end
                4'b1010 : begin //CMP
                    exe_cmd <= 4'b0100;
                    wb_en <= 0;
                end
                4'b1000 : begin //TST
                    exe_cmd <= 4'b0110;
                    wb_en <= 0;
                end
                4'b0100 : begin //LDR_STR
                    exe_cmd <= 4'b0010;
                    wb_en <= 0;
                    if(s_in == 1)
                        mem_read_en <= 1;
                    else
                        mem_write_en <= 1;
                end
            endcase
        end
    end
    assign S = s_in;
endmodule