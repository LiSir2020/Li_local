`timescale 1ns / 1ps

module MIPS(
    input   logic clk, reset,
    output  logic [31:0] pcF,
    input   logic [31:0] instrF,
    output  logic memwriteM,
    output  logic [31:0] aluoutM,
    output  logic [31:0] writedataM,
    input   logic [31:0] readdataM
    );
    
    logic [5:0] opD, functD;
    logic pcsrcD, equalD, branchD, branchBneD, jumpD;
    logic [2:0] alucontrolE;
    logic   memtoregE, regwriteE, regdstE, alusrcE, flushE;
    logic   memtoregM, regwriteM;
    logic   memtoregW, regwriteW;
    logic   imm_Ext;
    
    controller c(   clk, reset, opD, functD, flushE, equalD,
                    memtoregE, memtoregM, memtoregW, memwriteM, pcsrcD, branchD, branchBneD,
                    alusrcE, regdstE, regwriteE, regwriteM, regwriteW, jumpD, imm_Ext,
                    alucontrolE);
                    
    datapath dp(clk, reset, memtoregE, memtoregM, memtoregW, pcsrcD, branchD, branchBneD,
                alusrcE, regdstE, imm_Ext,  regwriteE, regwriteM, regwriteW, jumpD,
                alucontrolE,
                equalD, pcF, instrF,
                aluoutM, writedataM, readdataM,
                opD, functD, flushE);
    
endmodule
