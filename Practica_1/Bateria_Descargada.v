module BATERIAS_DESCARGADAS(
    input [3:0] A,B,
    output Ea, Eb
);

assign  Ea = !(A[0] || A[1] || A[2] || A[3]);
assign  Eb = !(B[0] || B[1] || B[2] || B[3]);

endmodule