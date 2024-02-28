`timescale 1ns / 1ps

module mux3_PCsrc_32(
    input   logic [31:0] d0, d1, d2,
    input   logic [1:0] s,
    output  logic [31:0] y
    );
    
    always_comb
        case(s)
        2'b00: y = d0;
        2'b01: y = d1;
        2'b10: y = d2;
        default: y = 32'bx;
        endcase
    
endmodule
