`timescale 1ns / 1ps

module tb_RiscV_Top();
    logic clk;
    logic rst;

    RiscV_Top dut (
        .clk(clk),
        .rst(rst)
    );

    //10ns period (100MHz)
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 0;

        #20;
        rst = 1;

        #200;
        $stop;
    end

endmodule
