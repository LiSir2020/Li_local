`timescale 1ns / 1ps

module maindec(
    input   logic [5:0] op,
    output  logic regwrite, regdst, alusrc, branch,
    output  logic memwrite, memtoreg, jump,
    output  logic [2:0] aluop,
    output  logic imm_Ext,
    output  logic BranchBne
    );
    
    logic [11:0] controls;
    
    assign {regwrite, regdst, alusrc, branch, memwrite,
            memtoreg, jump, aluop, imm_Ext, BranchBne} = controls;
    
    always_comb
        case(op)
        6'b000000: controls <= 12'b110000001000;//rtype
        6'b100011: controls <= 12'b101001000000;//lw
        6'b101011: controls <= 12'b001010000000;//sw
        6'b000100: controls <= 12'b000100000100;//beq
        6'b001000: controls <= 12'b101000000000;//addi
        6'b000010: controls <= 12'b0000001xxx00;//j
        
        6'b001100: controls <= 12'b101000010010;//andi
        6'b000101: controls <= 12'b000000000101;//bne
        6'b001101: controls <= 12'b101000001110;//ori
        default: controls <= 12'bxxxxxxxxxxxx;//illegal op
        endcase
    
endmodule
