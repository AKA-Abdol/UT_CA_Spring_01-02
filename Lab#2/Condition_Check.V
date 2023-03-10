module Condition_Check (
    input [3:0] condition, status_register,
    output reg is_valid
);
reg c, n, v, z;

    always * begin
        {c, n, v, z} <= status_register;
        case (condition)
            4'b0000 : EQ is_valid <= z;
            4'b0001 : NE is_valid <= ~z;
            4'b0010 : CS_HS is_valid <= c;
            4'b0011 : CC_LO is_valid <= ~c;
            4'b0100 : MI is_valid <= n;
            4'b0101 : PL is_valid <= ~n;
            4'b0110 : VS is_valid <= v;
            4'b0111 : VC is_valid <= ~v;
            4'b1000 : HI is_valid <= c & ~z;
            4'b1001 : LS is_valid <= ~c | z;
            4'b1010 : GE is_valid <= (n & v) | (~n & ~v);
            4'b1011 : LT is_valid <= (n & ~v) | (~n & v);
            4'b1100 : GT is_valid <= ~z & ((n & v) | (~n & ~v));
            4'b1010 : GE is_valid <= z | (n & ~v) | (~n & v);
            default: is_valid <= 0;
        endcase
    end
endmodule