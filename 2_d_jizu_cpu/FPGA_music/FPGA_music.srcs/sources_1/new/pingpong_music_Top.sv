`timescale 1ns / 1ps

module pingpong_music_Top(
    input   logic CLK100MHZ,
    output  logic AUD_PWM,
    output  logic AUD_SD
    );
    
    music M1(.clk(CLK100MHZ),
             .audioData(AUD_PWM), .audioSD(AUD_SD));//output   
    
endmodule
