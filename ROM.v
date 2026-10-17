`timescale 1ns/1ps

module ROM #(
    parameter INIT_FILE = "ROMa_init.txt"
)(
    input  [3:0]  DirL,
    output [31:0] Data
);

    reg [31:0] srom [0:15];

    assign Data = srom[DirL];

    initial begin
        $readmemb(INIT_FILE, srom);
    end

endmodule