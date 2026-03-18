module Instruction_memory(
    input logic [31:0] address,
    output logic [31:0] instr
);
logic [31:0] rom [256]; //memory
assign instr = rom[address[9:2]];
initial begin
    $readmemh("program.hex",rom); //machine code file
end

endmodule
