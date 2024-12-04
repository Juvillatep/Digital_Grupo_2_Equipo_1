module SUMADOR_4BITS(
    input [3:0] A,B,
    input Ci,
    output [3:0] Sum,
    output Co
);

assign {Co, Sum} = A + B + Ci;

endmodule