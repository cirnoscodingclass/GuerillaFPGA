`timescale 1ns / 1ps

module Switches_To_LEDs_And_Gate_tb;
    reg i_Switch_0;
    reg i_Switch_1;
    wire o_LED_0;

    Switches_To_LEDs_And_Gate uut (
        .i_Switch_0(i_Switch_0),
        .i_Switch_1(i_Switch_1),
        .o_LED_0(o_LED_0)
    );

    initial begin
        i_Switch_0 = 0;
        i_Switch_1 = 0;

        #10 i_Switch_0 = 0; i_Switch_1 = 0;
        #10 i_Switch_0 = 0; i_Switch_1 = 1;
        #10 i_Switch_0 = 1; i_Switch_1 = 0;
        #10 i_Switch_0 = 1; i_Switch_1 = 1;

        #10 $finish;
    end

    always @* begin
        $display("Time=%0t, i_Switch_0=%b, i_Switch_1=%b, o_LED_0=%b", $time, i_Switch_0, i_Switch_1, o_LED_0);
    end

endmodule

