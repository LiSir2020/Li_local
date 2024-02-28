`timescale 1ns / 1ps

module aludec(
    input   logic [5:0] funct,
    input   logic [2:0] aluop,
    output  logic [2:0] alucontrol
    );
    
    always_comb
        case(aluop)
            3'b000: alucontrol = 3'b010;//addi, lw, sw
            3'b001: alucontrol = 3'b110;//beq,bne
            3'b100: alucontrol = 3'b000;//andi
            3'b011: alucontrol = 3'b001;//ori
            default:
            case(funct)
                6'b100_000: alucontrol = 3'b010;//ADD
                6'b100_010: alucontrol = 3'b110;//SUB
                6'b100_100: alucontrol = 3'b000;//AND
                6'b100_101: alucontrol = 3'b001;//OR
                6'b101_010: alucontrol = 3'b111;//SLT
                default:    alucontrol = 3'bxxx;//???
            endcase
        endcase
    
endmodule
