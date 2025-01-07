module CARGA_BAJA(
    input [3:0] A,
    input B,
    output Ea
);

assign Ea = ((!B & !A[3] & A[2]) | (!B & A[3] & !A[2]));

endmodule