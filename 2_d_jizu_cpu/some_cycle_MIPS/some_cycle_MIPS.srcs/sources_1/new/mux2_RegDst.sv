`timescale 1ns / 1ps

module mux2_RegDst(
    input   logic [4:0] d0, d1,
    input   logic s,
    output  logic [4:0] y
    );
    
    assign y = s ? d1 : d0;
    
endmodule
