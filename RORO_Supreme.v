`timescale 1ns/1ps

module RORO_Supreme(
   input  [3:0]  Dir_Inst,
    output [31:0] DD,
    output        ZF
);
    wire [11:0] w_instruccion;
    ROM_Instrucciones Mem_Inst (
        .Dir_Inst(Dir_Inst),
        .Instruccion(w_instruccion)
    );

    RORO Bloque_RORO (
        .instruccion(w_instruccion),
        .resultado(DD),
        .ZF(ZF)
    );
endmodule