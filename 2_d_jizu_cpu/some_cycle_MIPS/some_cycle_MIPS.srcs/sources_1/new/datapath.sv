`timescale 1ns / 1ps

module datapath(
    input   logic clk, reset,
    input   logic [31:0] RD,
    input   logic IorD, imm, irwrite,
    input   logic RegDst, MemtoReg, RegWrite,
    input   logic PCEn,
    input   logic [2:0] aluControl,
    input   logic [1:0] aluSrcB, PCSrc,
    input   logic aluSrcA,
    output  logic [31:0] B, Adr, Instr,
    output  logic zero
    );
    
    logic [31:0] pcNext, Data, WD3, SrcA, SrcB; 
    logic [4:0] A3;
    logic [31:0] RD1_A, RD2_B, A, aluResult, pcPlus4, pc, aluOut;
    logic [31:0] signImm, signImmSh, signImmZero, imm_E;
    
    //next PC logic
    flopenr #(32)       pcreg(clk, reset, PCEn, pcNext, pc);//最左边接pc的寄存器
    mux3_PCsrc_32   pcmux(aluResult, aluOut, {pc[31:28], Instr[25:0], 2'b00}, PCSrc, pcNext);//最右边产生pc'的选择器
    //mux2_MemToReg_32    pcmux(aluResult, aluOut, PCSrc[0:0], pcNext);
    
    mux2_MemToReg_32    adrbuild(pc, aluOut, IorD, Adr);//生成Adr的选择器
    assign imm_E = imm ? signImmZero : signImm;
    ze_expend   ze(Instr[15:0], signImmZero);//零扩展位
    reg_Instr   reInstr(RD, clk, irwrite, Instr);//RD到Instr的寄存器
        
    //register file logic
    regfile         rf(clk, RegWrite, Instr[25:21], Instr[20:16], A3, WD3, RD1_A, RD2_B);//大的寄存器文件
    mux2_RegDst     rdst(Instr[20:16], Instr[15:11], RegDst, A3);//RegDst选择器
    mux2_MemToReg_32    mtrwd3(aluOut, Data, MemtoReg, WD3);//MemToReg选择器
    
    reg_data        data_reg(RD, clk, Data);//Data寄存器
    signext         se(Instr[15:0], signImm);//符号扩展
    sl2             immsh(signImm, signImmSh);//左移两位
    reg_AB          r_ab(RD1_A, RD2_B, clk, A, B);//AB寄存器
    
    //alu and so on
    mux2_MemToReg_32    alusrca(pc, A, aluSrcA, SrcA);//srcA选择
    mux4_ALUsrb_32  alusrb(B, 32'b100, imm_E, signImmSh, aluSrcB, SrcB);//四选一
    alu             alucom(SrcA, SrcB, aluControl, aluResult, zero);//ALU计算
    reg_alu         rr(aluResult, clk, aluOut);//右边寄存器
    
    
    
endmodule
