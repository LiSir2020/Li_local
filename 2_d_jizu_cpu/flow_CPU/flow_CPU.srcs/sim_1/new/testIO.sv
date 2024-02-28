`timescale 1ns / 1ps

module testIO(
    );
    logic CLK100MHZ, BTNC;
    logic BTNL, BTNR;
    logic [15:0] SW;
    logic [7:0] AN;
    logic [6:0] A2G;
    logic DP;
    
    
    Top T(CLK100MHZ, BTNC, BTNL, BTNR, SW, AN, DP, A2G);
    
    initial
    begin
        #0; BTNC <= 1;
        #2; BTNC <= 0;
        #2; BTNL <= 1; BTNR <= 1;
        #2; SW <= 16'b0000_0100_0000_1000;
    end
    
    always
    begin
        CLK100MHZ <= 1; #5; CLK100MHZ <= 0; #5;
    end
    
endmodule
