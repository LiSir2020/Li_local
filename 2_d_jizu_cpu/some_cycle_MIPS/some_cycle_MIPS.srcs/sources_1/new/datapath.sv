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
    flopenr #(32)       pcreg(clk, reset, PCEn, pcNext, pc);//����߽�pc�ļĴ���
    mux3_PCsrc_32   pcmux(aluResult, aluOut, {pc[31:28], Instr[25:0], 2'b00}, PCSrc, pcNext);//���ұ߲���pc'��ѡ����
    //mux2_MemToReg_32    pcmux(aluResult, aluOut, PCSrc[0:0], pcNext);
    
    mux2_MemToReg_32    adrbuild(pc, aluOut, IorD, Adr);//����Adr��ѡ����
    assign imm_E = imm ? signImmZero : signImm;
    ze_expend   ze(Instr[15:0], signImmZero);//����չλ
    reg_Instr   reInstr(RD, clk, irwrite, Instr);//RD��Instr�ļĴ���
        
    //register file logic
    regfile         rf(clk, RegWrite, Instr[25:21], Instr[20:16], A3, WD3, RD1_A, RD2_B);//��ļĴ����ļ�
    mux2_RegDst     rdst(Instr[20:16], Instr[15:11], RegDst, A3);//RegDstѡ����
    mux2_MemToReg_32    mtrwd3(aluOut, Data, MemtoReg, WD3);//MemToRegѡ����
    
    reg_data        data_reg(RD, clk, Data);//Data�Ĵ���
    signext         se(Instr[15:0], signImm);//������չ
    sl2             immsh(signImm, signImmSh);//������λ
    reg_AB          r_ab(RD1_A, RD2_B, clk, A, B);//AB�Ĵ���
    
    //alu and so on
    mux2_MemToReg_32    alusrca(pc, A, aluSrcA, SrcA);//srcAѡ��
    mux4_ALUsrb_32  alusrb(B, 32'b100, imm_E, signImmSh, aluSrcB, SrcB);//��ѡһ
    alu             alucom(SrcA, SrcB, aluControl, aluResult, zero);//ALU����
    reg_alu         rr(aluResult, clk, aluOut);//�ұ߼Ĵ���
    
    
    
endmodule
