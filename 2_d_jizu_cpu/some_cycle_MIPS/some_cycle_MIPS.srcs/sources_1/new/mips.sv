`timescale 1ns / 1ps

module mips(
    input   logic clk, reset,
    output  logic memwrite,
    output  logic [31:0] Adr, writedata,
    input   logic [31:0] readdata
    );
    
    logic   iord, memtoreg, alusrc, regdst, regwrite, jump, zero, imm;
    logic   pcwrite, irwrite, alusrca, branch, pcen, branchBne;
    logic [2:0] alucontrol, aluop;
    logic [1:0] alusrcb, pcsrc;
    logic [31:0] instr;
    
    controller   c( instr[31:26], instr[5:0],
                    clk, reset, zero, memtoreg, memwrite, pcwrite,
                    irwrite, alusrca, regdst, regwrite, iord, pcen,
                    branch, branchBne, imm, alucontrol, alusrcb, pcsrc, aluop);
    
     
    datapath    dp( clk, reset, readdata, iord, imm, irwrite, regdst, memtoreg,
                    regwrite, pcen, alucontrol,
                    alusrcb, pcsrc, alusrca, writedata, Adr, instr, zero);
    
endmodule
