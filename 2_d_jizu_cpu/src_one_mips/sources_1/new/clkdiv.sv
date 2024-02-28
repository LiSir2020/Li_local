`timescale 1ns / 1ps

module clkdiv(
    input   logic mclk,
    input   logic clr,
    output  logic clk190
    );
    
    logic [24:0] q;
    
    always_comb
    begin
        if(clr == 1) q <= 0;
        else q <= q+1;
    end
    
    assign clk190 = q[18];
    
endmodule
