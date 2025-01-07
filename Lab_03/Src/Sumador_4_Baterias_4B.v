`include "Sumador_1B.v"
`include "Sumador_4B.v"

module SUMADOR_8BITS(
    input [3:0] A,B,C,D,
    input Ci,
    output [5:0] Sum,
    output Co
);

  wire Sum1[3:0], Sum2[3:0], Ci1, Ci2, Ci3;

SUMADOR_4BITS SUM1(
    .A(A[3:0]),
    .B(B[3:0]),
    .Ci(Ci),
    .Sum(Sum1[3:0]),
    .Co(Ci1)
);

SUMADOR_4BITS SUM2(
    .A(C[3:0]),
    .B(D[3:0]),
    .Ci(Ci),
    .Sum(Sum2[3:0]),
    .Co(Ci2)
);

SUMADOR_4BITS SUM3(
    .A(Sum1[3:0]),
    .B(Sum2[3:0]),
    .Ci(Ci),
    .Sum(Sum[3:0]),
    .Co(Ci3)
);

SUMADOR_1BIT SUM4(
    .A(Ci1),
    .B(Ci2),
    .Ci(Ci3),
    .Sum(Sum2[4]),
    .Co(Sum[5])
);

endmodule
