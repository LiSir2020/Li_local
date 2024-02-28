`timescale 1ns / 1ps

module mux7seg(
    input   reset,
    input   logic [3:0] SW,
    output  logic [6:0] A2G,
    output  logic [3:0] AN,
    output  logic       DP,
    input   logic [11:0] digit
    );
    
    logic [15:0] x;
    logic [1:0] s;
    
    assign DP = 1;
    assign AN = ~SW;
    
    
    
endmodule
