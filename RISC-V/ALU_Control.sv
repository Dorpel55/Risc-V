module ALU_Control(
    input logic [2:0] func3, //instr[14:12]
    input logic [1:0] ALUOp,
    input logic  instr30, // instr[30] choose operation from func7
    output logic [2:0] alu_control
    );

    always_comb begin
        case (ALUOp)
            2'b00: alu_control = 3'b000; // load/store ADD
            2'b01: alu_control = 3'b001;//branch SUB
            2'b10: begin
            case (func3)
                3'b000: if (instr30)
                        alu_control = 3'b001; // SUB
                        else alu_control = 3'b000; //ADD
                3'b001: alu_control = 3'b101; // SLL
                3'b010: alu_control = 3'b111; // SLT
                //3'b011: alu_control = 3'bXXX //SLT(U) not in use
                3'b100: alu_control = 3'b010; // XOR
                3'b101: alu_control = 3'b110; //SRL
                3'b110: alu_control = 3'b011; //OR
                3'b111: alu_control = 3'b100; //AND
                default: alu_control = 3'b000;
            endcase
                end
            default: alu_control = 3'b000;
        endcase
    end

endmodule
