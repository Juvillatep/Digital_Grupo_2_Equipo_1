`include "Sumador_1B.v"
`include "Sumador_4B.v"

module SUMADOR_8BITS(
    input [7:0] A,B,
    input Ci,
    output [7:0] Sum,
    output Co
);

wire Ci1, Ci2, Ci3;

SUMADOR_4BITS SUM1(
    .A(A[3:0]),
    .B(B[3:0]),
    .Ci(Ci),
    .Sum(Sum[3:0]),
    .Co(Ci1)
);

SUMADOR_4BITS SUM2(
    .A(A[7:4]),
    .B(B[7:4]),
    .Ci(Ci1),
    .Sum(Sum[7:4]),
    .Co(Ci2)
);

endmodule
