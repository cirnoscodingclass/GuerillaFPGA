`timescale 1ns / 1ps

module Switches_To_LEDs_And_Gate(
    input i_Switch_0,
    input i_Switch_1,
    output o_LED_0
    );

    assign o_LED_0 = i_Switch_0 & i_Switch_1;
endmodule
