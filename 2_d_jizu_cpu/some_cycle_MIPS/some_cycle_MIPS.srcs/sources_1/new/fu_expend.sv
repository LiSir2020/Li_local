`timescale 1ns / 1ps

module fu_expend(
    input   logic [15:0] a,
    output  logic [31:0] y
    );
    
    assign y = {6'b111111, a};
    
endmodule
