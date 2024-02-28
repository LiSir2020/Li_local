`timescale 1ns / 1ps

module IO(
    input   logic       clk,
    input   logic       reset,
    input   logic       pRead,
    input   logic       pWrite,
    input   logic [1:0] addr,
    input   logic [31:0]    pWriteData,
    output  logic [31:0]    pReadData,
    
    input   logic       buttonL,
    input   logic       buttonR,
    input   logic [15:0]    switch,
    output  logic [11:0]    led
    );
    
    logic [1:0] status;
    logic [15:0] switch1;
    logic [11:0] led1;
    
    always_ff @(posedge clk)
    begin
        if(reset)
        begin
            status  <=  2'b00;
            led1    <=  12'h00;
            switch1  <=  16'h00;
        end
        else
        begin
            //����λ���Ѿ����ã���������������
            if(buttonR)
            begin
                status[1]   <=  1;
                switch1     <=  switch;
            end
            //LEDs�Ѿ�׼���ã��������������
            if(buttonL)
            begin
                status[0]   <=  1;
                led     <=  led1;
            end
            //����������˿����(LED)
            if(pWrite & (addr == 2'b01))
            begin
                led1        <=  pWriteData[11:0];
                status[0]   <=  0;
            end
            //������
            if(pRead)
            begin
                //11����������˿ڣ��ߣ���10����������˿ڣ��ͣ�
                //01����������˿ڣ�LED����00��״̬�˿�
                case(addr)
                2'b11:  pReadData   <=  {24'b0, switch1[15:8]};
                2'b10:  pReadData   <=  {24'b0, switch1[7:0]};
                2'b00:  pReadData   <=  {24'b0, 6'b000000, status};
                default:pReadData   <=  32'b0;
                endcase 
            end
        end//if
    end//always_ff
    
endmodule