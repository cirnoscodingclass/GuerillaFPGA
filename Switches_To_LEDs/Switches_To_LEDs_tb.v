`timescale 1ns / 1ps

module Switches_To_LEDs_tb;
    reg i_Switch_0;
    wire o_LED_0;
    
    Switches_To_LEDs uut (
        .i_Switch_0(i_Switch_0), 
        .o_LED_0(o_LED_0)
    );

    initial begin
        i_Switch_0 = 0;
        
        #10 i_Switch_0 = 1; 
        
        $display("Switch: %b, LED: %b", i_Switch_0, o_LED_0);
        
        $finish;
    end

endmodule
