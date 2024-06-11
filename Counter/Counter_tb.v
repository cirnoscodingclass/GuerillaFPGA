`timescale 1ns / 1ps

module Counter_tb;

    reg clk;                // 100 MHz clock input
    wire [6:0] seg;         // Seven segment display output
    wire [3:0] an;          // Anode signals of the 7-segment display

    // Instantiate the DUT (Device Under Test)
    bcd_counter uut (
        .clk(clk),
        .seg(seg),
        .an(an)
    );

    // Generate 100 MHz clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100 MHz clock period is 10 ns (100 MHz = 1 / (10 ns))
    end

    // Testbench initial block
    initial begin
        // Initialize signals if necessary
        // In this case, we only have a clock signal and no other inputs to initialize
        
        // Run the simulation for a certain time period
        // 1 Hz counter will take significant time to change state visibly in simulation
        // We will simulate for a short period and observe initial behavior
        #1000000; // Run simulation for 1 ms
        
        // Stop the simulation
        $stop;
    end

endmodule
