/*`include "Sumador_1B.v"*/

module SUMADOR_4BITS(
    input [3:0] A,B,
    input Ci,
    output [3:0] Sum,
    output Co
);

wire Ci1, Ci2, Ci3;

SUMADOR_1BIT SUM1(
    .A(A[0]),
    .B(B[0]),
    .Ci(Ci),
    .Sum(Sum[0]),
    .Co(Ci1)
);

SUMADOR_1BIT SUM2(
    .A(A[1]),
    .B(B[1]),
    .Ci(Ci1),
    .Sum(Sum[1]),
    .Co(Ci2)
);

SUMADOR_1BIT SUM3(
    .A(A[2]),
    .B(B[2]),
    .Ci(Ci2),
    .Sum(Sum[2]),
    .Co(Ci3)
);

SUMADOR_1BIT SUM4(
    .A(A[3]),
    .B(B[3]),
    .Ci(Ci3),
    .Sum(Sum[3]),
    .Co(Co)
);

endmodule