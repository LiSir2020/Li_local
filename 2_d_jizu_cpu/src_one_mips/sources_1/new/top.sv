`timescale 1ns / 1ps

module top(
    //input logic     clk, reset,
    //output logic [31:0] writedata, dataadr,
    //output logic    memwrite
    input   logic CLK100MHZ, BTNC,
    input   logic BTNL, BTNR,
    input   logic [15:0] SW,
    output  logic [7:0] AN,
    output  logic       DP,
    output  logic [6:0] A2G
    );
    
    logic [31:0] pc, instr, readData;
    
    logic [31:0] writeData, dataAdr;
    logic Write;//可能是memWrite, 也可能是ioWrite
    
    logic IOclock;
    assign IOclock = ~CLK100MHZ;
    
    mips mips(CLK100MHZ, BTNC, pc, instr, Write, dataAdr, writeData, readData);
    imem imem(pc[7:2], instr);
    //dmem dmem(clk, memwrite, dataadr, writedata, readdata);
    DataMemoryDecoder dmemDecoder(CLK100MHZ, Write, dataAdr, writeData, readData, IOclock, 
                                  BTNC, BTNL, BTNR, SW, AN, DP, A2G);
    
endmodule
