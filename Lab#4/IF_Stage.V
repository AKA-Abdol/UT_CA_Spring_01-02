module IF_Stage (
    input clk, rst, freeze, Branch_taken,
    input[31:0] BranchAddr,
    output reg [31:0] PC, 
	output[31:0] Instruction
);

wire[31:0] mem[0:17];
assign mem[0] = 32'b11100011101000000000000000010100; //MOV R0 ,#20 //R0 = 20
assign mem[1] = 32'b11100011101000000001101000000001; //MOV R1 ,#4096 //R1 = 4096
assign mem[2] = 32'b11100011101000000010000100000011; //MOV R2 ,#0xC0000000 //R2 = -1073741824
assign mem[3] = 32'b11100000100100100011000000000010; //ADDS R3 ,R2,R2 //R3 = -2147483648 
assign mem[4] = 32'b11100000101000000100000000000000; //ADC R4 ,R0,R0 //R4 = 41
assign mem[5] = 32'b11100000010001000101000100000100; //SUB R5 ,R4,R4,LSL #2 //R5 = -123
assign mem[6] = 32'b11100000110000000110000010100000; //SBC R6 ,R0,R0,LSR #1 //R6 = 10
assign mem[7] = 32'b11100001100001010111000101000010; //ORR R7 ,R5,R2,ASR #2 //R7 = -123
assign mem[8] = 32'b11100000000001111000000000000011; //AND R8 ,R7,R3 //R8 = -2147483648
assign mem[9] = 32'b11100001111000001001000000000110; //MVN R9 ,R6 //R9 = -11
assign mem[10] = 32'b11100000001001001010000000000101; //EOR R10,R4,R5 //R10 = -84
assign mem[11] = 32'b11100001010110000000000000000110; //CMP R8 ,R6
assign mem[12] = 32'b00010000100000010001000000000001; //ADDNE R1 ,R1,R1 //R1 = 8192
assign mem[13] = 32'b11100001000110010000000000001000; //TST R9 ,R8
assign mem[14] = 32'b00000000100000100010000000000010; //ADDEQ R2 ,R2,R2 //R2 = -1073741824
assign mem[15] = 32'b11100011101000000000101100000001; //MOV R0 ,#1024 //R0 = 1024
assign mem[16] = 32'b11100100100000000001000000000000; //STR R1 ,[R0],#0 //MEM[1024] = 8192
assign mem[17] = 32'b11100100100100001011000000000000; //LDR

always @(posedge clk, posedge rst) begin
    if(rst) begin
        PC <= 0;
    end
    else if(freeze == 1'b0) begin 
        if (Branch_taken == 32'b0)
            PC <= PC + 4;
        else 
            PC <= BranchAddr;
    end
    else 
        PC <= PC;
end

assign Instruction = mem[PC >> 2];
endmodule