module ARMv1(
    input clk, rst
);
wire freeze_IF, freeze_IF_Reg, Branch_taken, flush;
wire [31:0] BranchAddr, PC_IF, PC_IF_Out, Instruction, Instruction_Out;
wire [31:0] PC_ID, PC_ID_Out, PC_EXE, PC_EXE_Out, PC_MEM, PC_MEM_Out, PC;

// Consider that I made a simple mistake and freezes are not setted well
IF_Stage if_stage(clk, rst, freeze, Branch_taken, BranchAddr, PC_IF, Instruction);
IF_Stage_Reg if_stage_reg(clk, rst, freeze, flush, Instruction, PC_IF, PC_IF_Out, Instruction_Out);
ID_Stage id_stage(clk, rst, PC_IF_Out, PC_ID);
ID_Stage_Reg id_stage_reg(clk, rst, PC_ID, PC_ID_Out);
EXE_Stage exe_stage(clk, rst, PC_ID_Out, PC_EXE);
EXE_Stage_Reg exe_stage_reg(clk, rst, PC_EXE, PC_EXE_Out);
MEM_Stage mem_stage(clk, rst, PC_EXE_Out, PC_MEM);
MEM_Stage_Reg meme_stage_reg(clk, rst, PC_MEM, PC_MEM_Out);
WB_Stage wb_stage(clk, rst, PC_MEM_Out, PC);

assign freeze = 0;
assign Branch_taken = 0;
assign BranchAddr = 0;

endmodule