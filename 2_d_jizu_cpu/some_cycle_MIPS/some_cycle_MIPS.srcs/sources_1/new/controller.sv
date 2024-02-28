`timescale 1ns / 1ps

module controller(  input   logic [5:0] op, funct,
                    input   logic clk, reset, zero,
                    output  logic memtoreg, memwrite, pcwrite,
                    output  logic irwrite, alusrca,
                    output  logic regdst, regwrite, iord, pcen,
                    output  logic branch, branchBne, imm,
                    output  logic [2:0] alucontrol,
                    output  logic [1:0] alusrcb, pcsrc,
                    output  logic [2:0] aluop
    );
    
    
    maindec md(clk, reset, op, pcwrite, memwrite, irwrite, regwrite,alusrca, branch, iord, memtoreg, regdst, alusrcb, pcsrc, aluop, branchBne, imm);
    aludec ad(funct, aluop, alucontrol);
    
    assign pcen = pcwrite | (zero & branch) | (branchBne & ~zero);


endmodule
