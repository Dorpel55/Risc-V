module DataMemory(
    input logic [31:0] address,
    input logic [31:0] wd,
    input logic mem_read,
    input logic mem_write,
    input logic clk,
    output logic [31:0] rd
);
    logic [31:0] ram [256];
    assign rd = mem_read ? ram[address[9:2]] : 32'b0; //if mem_Read outputs data
always_ff @(posedge clk) begin
    if (mem_write) begin
        ram[address[9:2]] <= wd; //if mem_write store data into the ram
    end
end

endmodule
