`timescale 1ns / 1ps

module alu(
    input   logic [31:0] a, b,
    input   logic [2:0] alucont,
    output  logic [31:0] result,
    output  logic zero
    );
    
    always_comb
        case(alucont)
            3'b000: result <= a & b;
            3'b001: result <= a | b;
            3'b010: result <= a + b;
            3'b100: result <= a & ~b;
            3'b101: result <= a | ~b;
            3'b110: result <= a - b;
            3'b111: 
                if(a < b) result <= 1;
                else result <= 0;
        endcase
    
    always_comb
        if(result==0) zero <= 1;
        else zero <= 0;
    
endmodule
