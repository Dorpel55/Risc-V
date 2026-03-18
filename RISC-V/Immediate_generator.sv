module Immediate_generator(
    input logic [31:0] instr,
    output logic [31:0] imm_out
        );
logic [31:0] imm_i, imm_s, imm_b, imm_u, imm_j;
// imm_r doesnt need to be generated (no imm used)
assign imm_i = {{20{instr[31]}}, instr[31:20]};
assign imm_s = {{20{instr[31]}}, instr[31:25], instr[11:7]};
assign imm_b = {{19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0};
assign imm_u = {instr[31:12],12'b0};
assign imm_j ={{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0};


    always_comb begin
        case (instr[6:0])
        //7'b0110011: imm_out = imm_r
        7'b0010011: imm_out = imm_i; //I - ALU
        7'b0000011: imm_out = imm_i; //I - LOAD
        7'b1100111: imm_out = imm_i; //I - JALR
        7'b0100011: imm_out = imm_s; //S - STORE
        7'b1100011: imm_out = imm_b; //B - BRANCH
        7'b0110111: imm_out = imm_u; //U - LUI
        7'b0010111: imm_out = imm_u; //U - AUIPC
        7'b1101111: imm_out = imm_j; //J - JAL
        default     imm_out = 32'b0;
        endcase
    end
endmodule
