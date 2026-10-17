`timescale 1ns/1ps

module RORO_tb;

    reg  [11:0] instruccion;
    wire [31:0] resultado;
    wire        ZF;

    RORO uut (
        .instruccion(instruccion),
        .resultado(resultado),
        .ZF(ZF)
    );

    task check_case(
        input [11:0] inst_in,
        input [31:0] exp_dd,
        input        exp_zf
    );
    begin
      instruccion = inst_in;
        #10;
        if (resultado === exp_dd && ZF === exp_zf)
            $display("[PASS] Inst=%b (OP=%0d, R1=%0d, R2=%0d) | DD=%0d (esp=%0d) | ZF=%b (esp=%b)",
                     instruccion, instruccion[11:8], instruccion[7:4], instruccion[3:0],
                     resultado, exp_dd, ZF, exp_zf);
        else
            $display("[FAIL] Inst=%b (OP=%0d, R1=%0d, R2=%0d) | DD=%0d (esp=%0d) | ZF=%b (esp=%b)",
                     instruccion, instruccion[11:8], instruccion[7:4], instruccion[3:0],
                     resultado, exp_dd, ZF, exp_zf);
    end
    endtask

    initial begin
        $display("=== Inicio de simulacion RORO_tb ===");
        // Caso 1: Suma 12 + 5 = 17 (OP=2, R1=0, R2=0)
        check_case(12'b0010_0000_0000, 32'd17, 1'b0);
        // Caso 2: Resta con cero 0 - 0 = 0, ZF=1 (OP=6, R1=6, R2=6)
        check_case(12'b0110_0110_0110, 32'd0, 1'b1);
        // Caso 3: Resta positiva 15 - 6 = 9 (OP=6, R1=7, R2=7)
        check_case(12'b0110_0111_0111, 32'd9, 1'b0);
        // Caso 4: Resta negativa 9 - 50 = 4294967255 (OP=6, R1=9, R2=9)
        check_case(12'b0110_1001_1001, 32'd4294967255, 1'b0);
        // Caso 5: SLT verdadero 8 < 16 -> 1 (OP=7, R1=14, R2=14)
        check_case(12'b0111_1110_1110, 32'd1, 1'b0);
        // Caso 6: SLT falso 20 < 4 -> 0, ZF=1 (OP=7, R1=15, R2=15)
        check_case(12'b0111_1111_1111, 32'd0, 1'b1);
        $display("=== Fin de simulacion RORO_tb ===");
        $finish;
    end

endmodule