`timescale 1ns / 1ps

module tb_RiscV_Top();
    logic clk;
    logic rst;

    // Instance of your Top Level
    RiscV_Top dut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation: 10ns period (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 0; // Start with reset active (Low)

        // Hold reset for 20ns
        #20;
        rst = 1; // Release reset

        // Run for a few cycles to see the program execute
        #200;

        $display("Simulation Finished. Check the Waveform window!");
        $stop;
    end

endmodule
