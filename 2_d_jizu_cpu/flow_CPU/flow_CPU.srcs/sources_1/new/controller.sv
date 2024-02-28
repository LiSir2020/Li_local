`timescale 1ns / 1ps

module controller(
    input   logic clk, reset,
    input   logic [5:0] opD, functD,
    input   logic flushE, equalD,
    output  logic memtoregE, memtoregM, memtoregW, memwriteM,
    output  logic pcsrcD, branchD, branchBneD, alusrcE,
    output  logic regdstE, regwriteE, regwriteM, regwriteW,
    output  logic jumpD, imm_Ext,
    output  logic [2:0] alucontrolE
    );
    
    logic [2:0] alucontrolD;
    logic regwriteD, regdstD, alusrcD, memwriteD, memtoregD, memwriteE;
    logic [2:0] aluopD;
  
    
    maindec md( opD,
                regwriteD, regdstD, alusrcD, branchD,
                memwriteD, memtoregD, jumpD, aluopD, imm_Ext, branchBneD);
                
    aludec ad(  functD, aluopD, alucontrolD);
    
    assign pcsrcD = (branchD & equalD) | (branchBneD & ~equalD);
    
    floprc #(8) regE(   clk, reset, flushE,
                        {memtoregD, memwriteD, alusrcD, regdstD, regwriteD, alucontrolD},
                        {memtoregE, memwriteE, alusrcE, regdstE, regwriteE, alucontrolE});
                        
    flopr #(3) regM(    clk, reset,
                        {memtoregE, memwriteE, regwriteE},
                        {memtoregM, memwriteM, regwriteM});
                        
    flopr #(2) regW(    clk, reset,
                        {memtoregM, regwriteM},
                        {memtoregW, regwriteW});
    
endmodule
