`timescale 1ns / 1ps

module Switches_Toggle_LEDs_tb;
    reg i_Clk;
    reg i_Switch_0;
    wire o_LED_0;

    Switches_Toggle_LEDs uut (
        .i_Clk(i_Clk),
        .i_Switch_0(i_Switch_0),
        .o_LED_0(o_LED_0)
    );

    always #5 i_Clk = ~i_Clk;

    initial begin
        i_Switch_0 = 0;
        i_Clk = 0;

        #10 i_Switch_0 = 1;
        #10 i_Switch_0 = 0;
        #10 i_Switch_0 = 1;
        #10 i_Switch_0 = 0;

        #10 $finish;
    end

    always @* begin
        $display("Time=%0t, i_Switch_0=%b, o_LED_0=%b", $time, i_Switch_0, o_LED_0);
    end

endmodule
