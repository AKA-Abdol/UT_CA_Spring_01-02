module Val2_Generator (
    input [31:0] val_Rm,
	input [11:0] shift_operand,
	input imm, control_input,
	output reg [31:0] val_2
);
	
	wire [63:0] rotate_wire;
	wire [63:0] immd;
	wire [4:0] rotate_im; // *2 needed
	
	assign immd = {{24{shift_operand[7]}} , shift_operand[7:0] , {24{shift_operand[7]}} , shift_operand[7:0]};
	assign rotate_im = {shift_operand[11:8] , 1'b0};
	assign rotate_wire = {val_Rm , val_Rm};

	always @(shift_operand, imm, val_Rm, control_input) begin
		if (control_input == 1'b1) begin
			val_2 <= {{20{shift_operand[11]}}, shift_operand};
		end
		else if(imm == 1'b0 && shift_operand[4] == 1'b0) begin
			case(shift_operand[6:5])
				2'b00 : val_2 <= (val_Rm << shift_operand[11:7]);
				2'b01 : val_2 <= (val_Rm >> shift_operand[11:7]);
				2'b10 : val_2 <= (val_Rm >>> shift_operand[11:7]); // signed shift
				2'b11 : val_2 <= (rotate_wire >> shift_operand[11:7]);
			endcase
		end
		else if(imm == 1'b1) begin
			val_2 <= (immd >> rotate_im);
		end
	end

endmodule