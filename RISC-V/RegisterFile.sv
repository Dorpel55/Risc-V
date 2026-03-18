module RegisterFile (
    input logic clk,RegWrite,rst,
    input logic [4:0] RA1, RA2, WA, //Read and write addresses
    input logic [31:0] WD, //write data
    output logic [31:0] RD1, RD2 //Read data
);
    logic [31:0] registers [32]; //32 registers of 32 bits each

    assign RD1 = (RA1 == 5'h0) ? 32'h0 : registers[RA1]; //if address is 0 output 0
    assign RD2 = (RA2 == 5'h0) ? 32'h0 : registers[RA2];
    always @(posedge clk) begin
        if (rst) begin
            for (int i = 0 ; i<32; i++) begin
                registers[i] <= 32'h0; // reset all registers
            end
        end else if (RegWrite) begin
                if (WA != 5'h0) begin
                    registers[WA] <= WD; //write the data into the register
                end
            end
        end
endmodule

