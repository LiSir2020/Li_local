module dmem(input logic clk, we,
            input logic [31:0] a, wd,//����alu���ġ�regfile����
            output  logic   [31:0] rd);//readdata���
            
        logic [31:0] RAM[255:0];
        assign rd = RAM[a[31:2]];//word aligned
        always_ff @(posedge clk)
            if(we) RAM[a[31:2]] <= wd;

endmodule