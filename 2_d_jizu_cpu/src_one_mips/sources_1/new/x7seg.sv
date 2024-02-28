`timescale 1ns / 1ps

module x7seg(
    input   logic [11:0] x,
    input   logic       clk,
    input   logic       clr,
    input   logic [15:0] switch,
    output  logic [6:0] a2g,
    output  logic [7:0] an,
    output  logic       dp
    );
    
    logic [2:0] s;
    logic [4:0] digit;
    logic [19:0] clkdiv;
    
    assign dp = 1;
    assign s = clkdiv[19:17];
    
    always_comb
        case(s)
            0: digit = x[3:0];
            1: digit = x[7:4];
            2: digit = x[11:8];
            3: digit = 5'b10000;
            4: digit = switch[3:0];
            5: digit = switch[7:4];
            6: digit = switch[11:8];
            7: digit = switch[15:12];
        endcase
    
    always_comb
        case(s)
            0: an = 8'b1111_1110;
            1: an = 8'b1111_1101;
            2: an = 8'b1111_1011;
            3: an = 8'b1111_0111;
            4: an = 8'b1110_1111;
            5: an = 8'b1101_1111;
            6: an = 8'b1011_1111;
            7: an = 8'b0111_1111;
            default: an = 8'b1111_1110;
        endcase
    
    always_ff @(posedge clk or posedge clr)
    begin
        if(clr == 1) clkdiv <= 0;
        else clkdiv <= clkdiv + 1;
    end
    
    Hex7Seg Hex7Seg(digit, a2g);
    
endmodule
