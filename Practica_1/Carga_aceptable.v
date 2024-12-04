module CARGA_ACEPTABLE(
    input [3:0] A,
    input B,
    output Ea
);
/*
*assign  Ea = ;
*/
assign Ea = ((B & A[2] & !A[1] & A[0]) | (B & !A[3] & A[2] & A[1]) | (B & A[3] & !A[1]) | (B & A[3] & !A[2]));

endmodule