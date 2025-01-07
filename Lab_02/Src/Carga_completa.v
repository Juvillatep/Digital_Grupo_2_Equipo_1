module CARGA_COMPLETA(
    input [3:0] A,
    input B,
    output Ea
);

assign  Ea = (A[3] & A[2] & A[1] & B);

endmodule