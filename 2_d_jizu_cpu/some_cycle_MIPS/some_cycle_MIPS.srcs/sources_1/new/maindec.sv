`timescale 1ns / 1ps

module maindec(
    input  logic    clk,
    input  logic    reset,
    input  logic [5:0] op,
    output logic    pcwrite, memwrite, irwrite, regwrite,
    output logic    alusrca, branch, iord, memtoreg, regdst,
    output logic [1:0] alusrcb, pcsrc, 
    output logic [2:0] aluop,
    output logic branchBne, imm);
    
    localparam FETCH    = 5'b00000;//State 0
    localparam DECODE   = 5'b00001;//State 1
    localparam MEMADR   = 5'b00010;//State 2
    localparam MEMRD    = 5'b00011;//State 3
    localparam MEMWB    = 5'b00100;
    localparam MEMWR    = 5'b00101;
    localparam RTYPEEX  = 5'b00110;
    localparam RTYPEWB  = 5'b00111;
    localparam BEQEX    = 5'b01000;
    localparam ADDIEX   = 5'b01001;
    localparam ADDIWB   = 5'b01010;
    localparam JEX      = 5'b01011;//State 11
    
    localparam ANDIEX   = 5'b01100;
    localparam ANDIWB   = 5'b01101;
    localparam ORIEX    = 5'b01110;
    localparam ORIWB    = 5'b01111;
    localparam BNEEX    = 5'b10000;
    
    localparam LW       = 6'b100_011;//Opcode for lw
    localparam SW       = 6'b101_011;//sw
    localparam RTYPE    = 6'b000_000;
    localparam BEQ      = 6'b000_100;
    localparam ADDI     = 6'b001_000;
    localparam J        = 6'b000_010;
    
    localparam ANDI     = 6'b001_100;
    localparam BNE      = 6'b000_101;
    localparam ORI      = 6'b001_101;
    
    logic [4:0]     state, nextstate;
    logic [17:0]    controls;
    
    //state register
    always_ff @(posedge clk or posedge reset)
        if (reset)  state <= FETCH;
        else        state <= nextstate;
        
    always_comb
        case (state)
            FETCH: nextstate = DECODE;
            DECODE: case(op)
                    LW:     nextstate = MEMADR;
                    SW:     nextstate = MEMADR;
                    RTYPE:  nextstate = RTYPEEX;
                    BEQ:    nextstate = BEQEX;
                    ADDI:   nextstate = ADDIEX;
                    J:      nextstate = JEX;
                    
                    ANDI:   nextstate = ANDIEX;
                    ORI:    nextstate = ORIEX;
                    BNE:    nextstate = BNEEX;
                    
                    default:    nextstate = 5'bx;//never happen
                    endcase
            MEMADR: case(op)
                    LW:     nextstate = MEMRD;
                    SW:     nextstate = MEMWR;
                    default:    nextstate = 5'bx;
                    endcase
            MEMRD:      nextstate = MEMWB;
            MEMWB:      nextstate = FETCH;
            MEMWR:      nextstate = FETCH;
            RTYPEEX:    nextstate = RTYPEWB;
            RTYPEWB:    nextstate = FETCH;
            BEQEX:      nextstate = FETCH;
            ADDIEX:     nextstate = ADDIWB;
            ADDIWB:     nextstate = FETCH;
            JEX:        nextstate = FETCH;
            
            ANDIEX:     nextstate = ANDIWB;
            ANDIWB:     nextstate = FETCH;
            ORIEX:      nextstate = ORIWB;
            ORIWB:      nextstate = FETCH;
            BNEEX:      nextstate = FETCH;
            default:    nextstate = 5'bx;
        endcase
    //output logic
    assign {pcwrite, memwrite, irwrite, regwrite,
            alusrca, branch, iord, memtoreg, regdst,
            alusrcb, pcsrc, aluop, branchBne, imm} = controls;
    
    always_comb
        case (state)
            FETCH:      controls = 18'b0101_0000_0001_00_000_0_0;
            DECODE:     controls = 18'b0000_0000_0011_00_000_0_0;
            MEMADR:     controls = 18'b0000_0100_0010_00_000_0_0;
            MEMRD:      controls = 18'b0000_0001_0000_00_000_0_0;
            MEMWB:      controls = 18'b0000_1000_1000_00_000_0_0;
            MEMWR:      controls = 18'b0010_0001_0000_00_000_0_0;
            RTYPEEX:    controls = 18'b0000_0100_0000_00_010_0_0;
            RTYPEWB:    controls = 18'b0000_1000_0100_00_000_0_0;
            BEQEX:      controls = 18'b0000_0110_0000_01_001_0_0;
            ADDIEX:     controls = 18'b0000_0100_0010_00_000_0_0;
            ADDIWB:     controls = 18'b0000_1000_0000_00_000_0_0;
            JEX:        controls = 18'b0100_0000_0000_10_000_0_0;
            
            ANDIEX:     controls = 18'b0000_0100_0010_00_100_0_1;
            ANDIWB:     controls = 18'b0000_1000_0000_00_100_0_0;
            ORIEX:      controls = 18'b0000_0100_0010_00_011_0_1;
            ORIWB:      controls = 18'b0000_1000_0000_00_011_0_0;
            BNEEX:      controls = 18'b0000_0110_0000_01_001_1_0;
            default:    controls = 18'hxxxx;
        endcase
    
endmodule
