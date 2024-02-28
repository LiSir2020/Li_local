`timescale 1ns / 1ps

module clkDiv(
    input   logic clk,
    input   logic clr,
    output  logic clk25MHZ
    );
    
    logic [1:0] q;
    
    always @(posedge clk, posedge clr)
        if(clr==1)  q <= 0;
        else        q <= q + 1;
        
    assign clk25MHZ = q[1];
    
endmodule
