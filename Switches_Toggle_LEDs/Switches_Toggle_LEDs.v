`timescale 1ns / 1ps

module Switches_Toggle_LEDs(
    input i_Clk,
    input i_Switch_0,
    output o_LED_0
    );

    reg r_Switch_0 = 1'b0;
    reg r_LED_0 = 1'b0;

    always @ (posedge i_Clk)
    begin
        r_Switch_0 <= i_Switch_0;
        if ( i_Switch_0 == 1'b0 && r_Switch_0 == 1'b1)
            begin
                r_LED_0 <= ~r_LED_0;
            end
    end

    assign o_LED_0 = r_LED_0;
endmodule
