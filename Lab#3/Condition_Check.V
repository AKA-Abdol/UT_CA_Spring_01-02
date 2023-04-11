module Condition_Check (
    input [3:0] condition, status_register,
    output reg is_valid
);
reg c, n, v, z;

    always @* begin
        {c, n, v, z} <= status_register;
        case (condition)
            4'b0000 : is_valid <= z; //EQ
            4'b0001 : is_valid <= ~z; //NE
            4'b0010 : is_valid <= c; //CS_HS
            4'b0011 : is_valid <= ~c; //CC_LO
            4'b0100 : is_valid <= n; //MI
            4'b0101 : is_valid <= ~n; //PL
            4'b0110 : is_valid <= v; //VS
            4'b0111 : is_valid <= ~v; //VC
            4'b1000 : is_valid <= c & ~z; //HI
            4'b1001 : is_valid <= ~c | z; //LS
            4'b1010 : is_valid <= (n & v) | (~n & ~v); //GE
            4'b1011 : is_valid <= (n & ~v) | (~n & v); //LT
            4'b1100 : is_valid <= ~z & ((n & v) | (~n & ~v)); //GT
            4'b1010 : is_valid <= z | (n & ~v) | (~n & v); //LE
            default: is_valid <= 1'b1; // no condition
        endcase
    end
endmodule
