`timescale 1ns / 1ps

module imem(
    input   logic [5:0] a,
    output  logic [31:0] rd
    );
    
    logic [31:0] RAM[255:0];
    
    initial
        $readmemh("flow3.dat", RAM);
    
    assign rd = RAM[a];
    
endmodule
