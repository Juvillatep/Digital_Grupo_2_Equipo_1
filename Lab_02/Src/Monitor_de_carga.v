module MONITOR_DE_CARGA(
    input [3:0] A, B,
    output Ea, Eb, E2, E3, E4, E5, E6
);

wire [3:0] Sum;
wire Co;

SUMADOR_4BITS SUM4B(
    .A(A),
    .B(B),
    .Ci(1'b0),
    .Sum(Sum),
    .Co(Co)
);

BATERIAS_DESCARGADAS BATDES(
    .A(A),
    .B(B),
    .Ea(Ea),
    .Eb(Eb)
);

CARGA_CRITICA CARGACRT(
    .A(Sum),
    .B(Co),
    .Ea(E2)
);

CARGA_BAJA CARGABJ(
    .A(Sum),
    .B(Co),
    .Ea(E3)
);

CARGA_REGULAR CARGAREG(
    .A(Sum),
    .B(Co),
    .Ea(E4)
);

CARGA_ACEPTABLE CARGAACEP(
    .A(Sum),
    .B(Co),
    .Ea(E5)
);

CARGA_COMPLETA CARGACOM(
    .A(Sum),
    .B(Co),
    .Ea(E6)
);

endmodule