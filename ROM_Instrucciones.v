`timescale 1ns/1ps

module ROM_Instrucciones #(
    parameter INIT_FILE = "instrucciones.txt"
)(
    input  [3:0]  Dir_Inst,
    output [11:0] Instruccion
);

    reg [11:0] mem_inst [0:15];

    assign Instruccion = mem_inst[Dir_Inst];

    initial begin
        $readmemb(INIT_FILE, mem_inst);
    end

endmodule