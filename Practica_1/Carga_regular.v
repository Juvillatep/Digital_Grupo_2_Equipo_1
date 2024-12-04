module CARGA_REGULAR(
    input [3:0] A,
    input B,
    output Ea
);

/*
*assign  Ea = ((A >= 4'b1100) & ((B == 1'b1) & (A < 4'b0101)));
*/
assign Ea = ((B & !A[3] & !A[1] & !A[0]) | (!B & A[3] & A[2]) | (B & !A[3] & !A[2]));

endmodule