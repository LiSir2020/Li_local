`timescale 1ns / 1ps

module reg_data(
    input   logic [31:0] a,
    input   logic clk,
    output  logic [31:0] y
    );
    
    always_ff @(posedge clk)
        y <= a;
    
endmodule
