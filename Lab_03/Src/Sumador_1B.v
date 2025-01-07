module SUMADOR_1BIT(
    input A,B,
    input Ci,
    output Sum,
    output Co
);

assign Sum = (A ^ B) ^Ci;
assign Co = (A & B)||(Ci & (A ^ B));

endmodule