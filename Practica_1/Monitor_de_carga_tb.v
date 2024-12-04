`include "Bateria_Descargada.v"
`include "Carga_critica.v"
`include "Carga_baja.v"
`include "Carga_regular.v"
`include "Carga_aceptable.v"
`include "Carga_completa.v"
`include "Sumador.v"
`timescale 1ps/1ps

module Test1(
);

reg [3:0] A_tb;
reg [3:0] B_tb;
reg Ci_tb;

wire Ea_tb;
wire Eb_tb;
wire Ea2_tb;
wire Ea3_tb;
wire Ea4_tb;
wire Ea5_tb;
wire Ea6_tb;
wire [3:0] Sum_tb;
wire Co_tb;

SUMADOR_4BITS ut(
    .A(A_tb),
    .B(B_tb),
    .Ci(1'b0),
    .Sum(Sum_tb),
    .Co(Co_tb)
);

BATERIAS_DESCARGADAS uut(
    .A(A_tb),
    .B(B_tb),
    .Ea(Ea_tb),
    .Eb(Eb_tb)
);

CARGA_CRITICA uuut(
    .A(Sum_tb),
    .B(Co_tb),
    .Ea(Ea2_tb)
);

CARGA_BAJA uuuut(
    .A(Sum_tb),
    .B(Co_tb),
    .Ea(Ea3_tb)
);

CARGA_REGULAR uuuuut(
    .A(Sum_tb),
    .B(Co_tb),
    .Ea(Ea4_tb)
);

CARGA_ACEPTABLE uuuuuut(
    .A(Sum_tb),
    .B(Co_tb),
    .Ea(Ea5_tb)
);

CARGA_COMPLETA uuuuuuut (
    .A(Sum_tb),
    .B(Co_tb),
    .Ea(Ea6_tb)
);

initial begin
    A_tb = 4'b0000;
    B_tb = 4'b0000;
    #10;
    A_tb = 4'b0010;
    B_tb = 4'b0001;
    #10;
    A_tb = 4'b0100;
    B_tb = 4'b0101;
    #10;
    A_tb = 4'b0110;
    B_tb = 4'b0101;
    #10;
    A_tb = 4'b0000;
    B_tb = 4'b1100;
    #10;
    A_tb = 4'b1101;
    B_tb = 4'b0011;
    #10;
    A_tb = 4'b1111;
    B_tb = 4'b0110;
    #10;
    A_tb = 4'b1111;
    B_tb = 4'b0111;
    #10;
    A_tb = 4'b1111;
    B_tb = 4'b1111;
    #10;
end

initial begin:TEST_CASE
    $dumpfile("Test1.vcd");
    $dumpvars(-1, ut);
    $dumpvars(-1, uut);  
    $dumpvars(-1, uuut);  
    $dumpvars(-1, uuuut);
    $dumpvars(-1, uuuuut);
    $dumpvars(-1, uuuuuut);
    $dumpvars(-1, uuuuuuut);
    #100 $finish;
end

endmodule