`timescale 1ns / 1ps

module reg_Instr(
    input   logic [31:0] a,
    input   logic clk, EN,
    output  logic [31:0] y
    );
    
    always_ff @(posedge clk)
        if(EN) y <= a;
    
endmodule
