`timescale 1ns / 1ps

module controller(  input   logic [5:0] op, funct,
                    input   logic zero,
                    output  logic memtoreg, memwrite,
                    output  logic pcsrc, alusrc,
                    output  logic regdst, regwrite,
                    output  logic jump, imm_Ext,
                    output  logic [2:0] alucontrol
    );
    
    logic [2:0] aluop;
    logic branch;
    logic branchBne;
    
    maindec md(op, memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump, aluop, imm_Ext, branchBne);
    aludec ad(funct, aluop, alucontrol);
    
    assign pcsrc = branch & zero | branchBne & ~zero;
    
endmodule
