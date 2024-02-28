`timescale 1ns / 1ps

module TestBench_IO(   );
    logic CLK100MHZ, BTNC;//reset
    logic BTNL, BTNR;
    logic [15:0] SW;
    logic [7:0] AN;
    logic DP;
    logic [6:0] A2G;
    
    Top T(CLK100MHZ, BTNC, BTNL, BTNR, SW, AN, DP, A2G);
    
    initial begin
        #0; BTNC <= 1;
        #2; BTNC <= 0;
        #2; BTNL <= 1; BTNR <= 1;
        #2; SW <= 16'b00000100_00001000;
    end
    
    always begin
        CLK100MHZ <= 1; #5; CLK100MHZ <= 0; #5; end


endmodule




