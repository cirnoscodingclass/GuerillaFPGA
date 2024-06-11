module Counter(
    input clk,                // 100 MHz clock input from the BASYS3
    output [6:0] seg,         // Seven segment display output
    output [3:0] an           // Anode signals of the 7-segment display
);

    reg [26:0] count_1hz;     // Counter to generate 1Hz clock
    reg clk_1hz;              // 1Hz clock signal
    reg [3:0] bcd0, bcd1, bcd2, bcd3;  // BCD digits
    reg [3:0] an_reg;
    reg [6:0] seg_reg;
    reg [15:0] refresh_counter; // Counter to control multiplexing refresh rate

    // Generate 1Hz clock from 100MHz clock
    always @(posedge clk) begin
        if (count_1hz == 100_000_000 - 1) begin
            count_1hz <= 0;
            clk_1hz <= ~clk_1hz;
        end else begin
            count_1hz <= count_1hz + 1;
        end
    end

    // BCD counter logic
    always @(posedge clk_1hz) begin
        if (bcd0 == 4'b1001) begin
            bcd0 <= 4'b0000;
            if (bcd1 == 4'b1001) begin
                bcd1 <= 4'b0000;
                if (bcd2 == 4'b1001) begin
                    bcd2 <= 4'b0000;
                    if (bcd3 == 4'b1001) begin
                        bcd3 <= 4'b0000;
                    end else begin
                        bcd3 <= bcd3 + 1;
                    end
                end else begin
                    bcd2 <= bcd2 + 1;
                end
            end else begin
                bcd1 <= bcd1 + 1;
            end
        end else begin
            bcd0 <= bcd0 + 1;
        end
    end

    // 7-segment display decoder
    always @(*) begin
        case (an_reg)
            4'b1110: seg_reg = bcd_to_7seg(bcd0);
            4'b1101: seg_reg = bcd_to_7seg(bcd1);
            4'b1011: seg_reg = bcd_to_7seg(bcd2);
            4'b0111: seg_reg = bcd_to_7seg(bcd3);
            default: seg_reg = 7'b1111111;
        endcase
    end

    // Anode control for multiplexing 7-segment displays
    always @(posedge clk) begin
        if (refresh_counter == 0) begin
            an_reg <= {an_reg[2:0], an_reg[3]};
        end
        refresh_counter <= refresh_counter + 1;
    end

    // Assign outputs
    assign seg = seg_reg;
    assign an = an_reg;

    // Function to convert BCD to 7-segment display
    function [6:0] bcd_to_7seg;
        input [3:0] bcd;
        case (bcd)
            4'b0000: bcd_to_7seg = 7'b1000000; // 0
            4'b0001: bcd_to_7seg = 7'b1111001; // 1
            4'b0010: bcd_to_7seg = 7'b0100100; // 2
            4'b0011: bcd_to_7seg = 7'b0110000; // 3
            4'b0100: bcd_to_7seg = 7'b0011001; // 4
            4'b0101: bcd_to_7seg = 7'b0010010; // 5
            4'b0110: bcd_to_7seg = 7'b0000010; // 6
            4'b0111: bcd_to_7seg = 7'b1111000; // 7
            4'b1000: bcd_to_7seg = 7'b0000000; // 8
            4'b1001: bcd_to_7seg = 7'b0010000; // 9
            default: bcd_to_7seg = 7'b1111111; // default off
        endcase
    endfunction

    // Initial block to set the initial state
    initial begin
        count_1hz = 0;
        clk_1hz = 0;
        bcd0 = 0;
        bcd1 = 0;
        bcd2 = 0;
        bcd3 = 0;
        an_reg = 4'b1110;
        refresh_counter = 0;
    end

endmodule
