`timescale 1ns / 1ps

module IDmem(   input   logic clk, we,
                input   logic [31:0] aa, wd,
                output  logic [31:0] rd
    );
    
    logic [31:0] RAM[255:0];
    
    initial
        $readmemh("fuc_teio.dat", RAM);
    
    assign rd = RAM[aa[31:2]];
    
    always_ff @(posedge clk)
        if(we) RAM[aa[31:2]] <= wd;
    
endmodule
