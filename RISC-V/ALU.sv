module ALU(
    input logic [2:0] alu_control,
    input logic [31:0] rs1, rs2,// inputs
    output logic  [31:0] rd, // output
    output logic zero_flag,
    output logic big_flag
    );
    always_comb begin
        case (alu_control) //
            3'b000: rd = rs1 + rs2; //ADD
            3'b001: rd = rs1 - rs2; //SUB
            3'b010: rd = (rs1 ^ rs2); //XOR
            3'b011: rd = (rs1 | rs2); //OR
            3'b100: rd = (rs1 & rs2); //AND
            3'b101: rd = rs1 << rs2[4:0];//SLL
            3'b110: rd = rs1 >> rs2[4:0]; //SRL
            3'b111: rd = (rs1 < rs2) ? 32'd1 : 32'd0;//SLT
        default rd = 32'b0;

        endcase
    end
    assign zero_flag = (rd == 32'b0);
    assign big_flag = rd[31];


endmodule
