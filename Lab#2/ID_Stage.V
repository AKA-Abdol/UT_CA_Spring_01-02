module ID_Stage(
    input clk, rst,
    input[31:0] Instruction,

    input[31:0] Result_WB,
    input writeBackEn,
    input[3:0] dest_wb,

    input[3:0] status_register,

    output mem_read_en, mem_write_en, wb_en, S, B,
    output[3:0] exe_cmd,
    output[31:0] val_Rn, val_Rm,
    output[11:0] shift_operand,
    output[3:0] dest;
);

wire[3:0] Rm, Rn;
wire can_not_pass;

wire[1:0] mode;
wire[3:0] Op_code;
wire s_in;
wire temp_mem_read_en, temp_mem_write_en, temp_wb_en, temp_S, temp_B;
wire[3:0] temp_exe_cmd;

wire [3:0] src2;
wire [31:0] reg1, reg2;


wire [3:0] condition;
wire is_valid;


assign condition = Instruction[31:28];
assign mode = Instruction[27:26];
assign Op_code = Instruction[24:21];
assign s_in = Instruction[20];
assign Rn = Instruction[19:16];
assign dest = Instruction[15:12]; // dest === Rd
assign shift_operand = Instruction[11:0];
assign Rm = Instruction[3:0];

Mux2to1 #(4)
    mux_src2 (
        .input_0(Rm),
        .input_1(dest),
        .sel(mem_write_en),
        .selected_input(src2)
    );

Register_File register_file(
    .clk(clk), 
    .rst(rst),
    .src1(Rn),
    .src2(src2),
    .dest_wb(dest_wb),
    .Result_WB(Result_WB),
    .writeBackEn(writeBackEn),
    .reg1(val_Rn),
    reg2(val_Rm)
);

Control_Unit control_unit(
    .mode(mode),
    .Op_code(Op_code),
    .s_in(s_in),
    .S(temp_S),
    .mem_read_en(temp_mem_read_en),
    .mem_write_en(temp_mem_write_en),
    .wb_en(temp_wb_en),
    .B(temp_B),
    .exe_cmd(temp_exe_cmd)
);

Condition_Check condition_check(
    .condition(condition),
    .status_register(status_register),
    .is_valid(is_valid)
);

assign can_not_pass = ~is_valid;

Mux2to1 #(9)
    mux_condition (
        .input_0({temp_S, temp_mem_read_en, temp_mem_write_en, temp_wb_en, temp_B, temp_exe_cmd}),
        .input_1(9'b0),
        .sel(can_not_pass),
        .selected_input({S, mem_read_en, mem_write_en, wb_en, B, exe_cmd})
    );

endmodule