module pc_reg(
    input logic clk,
    input logic rst,
    input logic [31:0] pc_in,
    output logic [31:0] pc_out
);
always @(posedge clk) begin
    if (rst) begin
        pc_out <= 32'h00000000;
    end else begin
        pc_out <= pc_in;
    end
end

endmodule
