`timescale 1ns / 1ps

module reg_AB(
    input   logic [31:0] rd1, rd2,
    input   logic clk,
    output  logic [31:0] a, b
    );
    
    always_ff @(posedge clk)
        begin
            a <= rd1;
            b <= rd2;
        end
    
endmodule
