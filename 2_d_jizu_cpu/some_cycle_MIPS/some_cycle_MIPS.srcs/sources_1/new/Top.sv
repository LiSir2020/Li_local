`timescale 1ns / 1ps

module Top(
    //input   logic clk, reset,
    //output  logic [31:0] writedata, Adr,
    //output  logic memwrite
    input   logic CLK100MHZ, BTNC,
    input   logic BTNL, BTNR,
    input   logic [15:0] SW,
    output  logic [7:0] AN,
    output  logic       DP,
    output  logic [6:0] A2G
    );
    
    logic [31:0] readdata, Adr, writedata;
    
    logic Write;//可能是memWrite, 也可能是ioWrite
    
    logic IOclock;
    assign IOclock = ~CLK100MHZ;
    
    mips    mipss(CLK100MHZ, BTNC, Write, Adr, writedata, readdata);
    //IDmem   idmem(CLK100MHZ, Write, Adr, writedata, readdata);
    DataMemoryDecoder dmemDecoder(CLK100MHZ, Write, Adr, writedata, readdata, IOclock, 
                                  BTNC, BTNL, BTNR, SW, AN, DP, A2G);
    
endmodule
