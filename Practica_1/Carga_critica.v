module CARGA_CRITICA(
    input [3:0] A,
    input B,
    output Ea
);

assign  Ea = !(A[3] || A[2] || B);

endmodule