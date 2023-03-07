module ID_Stage(
    input clk, rst,
    input[31:0] PC_in, Instruction_in,
    input[3:0] status,
    output reg [31:0] PC,
    output S, mem_read_en, mem_write_en, wb_en, B,
    output [3:0] exe_cmd;
);
wire [1:0] mode;
wire [3:0] Op_code;
wire s_in;

wire writeBackEn;
wire [3:0] src1, src2, Dest_wb;
wire [31:0] Result_WB, reg1, reg2;

wire [3:0] Cond;
wire is_valid;

wire [3:0] Rd, Rn;
wire [11:0] shifter_operand;

Control_Unit control_unit(
    input [1:0] mode,
    input [3:0] Op_code,
    input s_in,
    output S,
    output reg mem_read_en, mem_write_en, wb_en, B,
    output reg [3:0] exe_cmd
);

Register_File register_file(
    clk, rst,
    input [3:0] src1, src2, Dest_wb,
    input[31:0] Result_WB,
    input writeBackEn,
    output [31:0] reg1, reg2
);

Condition_Check condition_check(
    input [3:0] Cond, status,
    output reg is_valid
);

assign Rd = Instruction_in[15:12];
assign Rn = Instruction_in[19:16];
assign s_in = Instruction_in[20];

assign Cond = Instruction_in[31:28];
assign mode = Instruction_in[27:26];
assign Op_code = Instruction_in[24:21];

assign Dest_wb = Rd;

assign src1 = Rn;
assign src2 = ;






endmodule