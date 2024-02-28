`timescale 1ns / 1ps

module Hex7Seg(
    input   logic [4:0] x,
    output  logic [6:0] a2g
    );
    
    always_comb
    case(x)
        'h0: a2g = 7'b100_0000;
        'h1: a2g = 7'b111_1001;
        'h2: a2g = 7'b010_0100;
        'h3: a2g = 7'b011_0000;
        'h4: a2g = 7'b001_1001;
        'h5: a2g = 7'b001_0010;
        'h6: a2g = 7'b000_0010;
        'h7: a2g = 7'b111_1000;
        'h8: a2g = 7'b000_0000;
        'h9: a2g = 7'b001_0000;
        'hA: a2g = 7'b000_1000;
        'hB: a2g = 7'b000_0011;
        'hC: a2g = 7'b100_0110;
        'hD: a2g = 7'b010_0001;
        'hE: a2g = 7'b000_0110;
        'hF: a2g = 7'b000_1110;
        'h10: a2g = 7'b011_0111;
    default: a2g = 7'b100_0000;
    endcase
    
endmodule
