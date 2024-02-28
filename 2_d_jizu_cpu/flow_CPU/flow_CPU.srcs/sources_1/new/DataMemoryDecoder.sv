`timescale 1ns / 1ps

module DataMemoryDecoder(
    input   logic        clk,    writeEN,
    input   logic [31:0] addr,  writeData,
    output  logic [31:0] readData,
    
    input   logic IOclock,
    input   logic reset,
    input   logic btnL, btnR,
    input   logic [15:0] switch,
    output  logic [7:0] AN,
    output  logic       DP,
    output  logic [6:0] A2G
    );
    
    logic [31:0] ReadData1, ReadData2;
    logic WE, pWrite, pRead;
    logic [11:0] led;
    
    assign WE = (addr[7] == 1'b0) & writeEN;
    assign pWrite = (addr[7] == 1'b1) ? writeEN : 0;
    assign readData = (addr[7] == 1'b0) ? ReadData1 : ReadData2;
    assign pRead = (addr[7] == 1'b1) ? 1 : 0;
    
    dmem dmem(clk, WE, addr, writeData, ReadData1);
    IO IO(IOclock, reset, pRead, pWrite, addr[3:2], writeData, ReadData2, btnL, btnR, switch, led);
    x7seg x7seg(led, IOclock, reset, switch, A2G, AN, DP);
    
endmodule
