module MainControlUnit(
    input logic [6:0] Opcode,
    output logic [1:0] ALUOp,
    output logic RegWrite,
    output logic MemWrite,
    output logic MemRead,
    output logic ALUSrc, // imm or rs2 (imm = 1, rs2 = 0)
    output logic Branch,
    output logic MemtoReg
    );

    always_comb begin
        case (Opcode)
            7'b0110011: begin // R Type
                ALUOp = 2'b10;
                RegWrite = 1'b1;
                MemWrite = 1'b0;
                MemRead = 1'b0;
                ALUSrc = 1'b0;
                Branch = 1'b0;
                MemtoReg = 1'b0;
            end

            7'b0010011: begin // I Type
                ALUOp = 2'b10;
                RegWrite = 1'b1;
                MemWrite = 1'b0;
                MemRead = 1'b0;
                ALUSrc = 1'b1;
                Branch = 1'b0;
                MemtoReg = 1'b0;
            end

            7'b0000011: begin //I type Load
                ALUOp = 2'b00;
                RegWrite = 1'b1;
                MemWrite = 1'b0;
                MemRead = 1'b1;
                ALUSrc = 1'b1;
                Branch = 1'b0;
                MemtoReg = 1'b1;
            end

           7'b0100011: begin //S type Store
                ALUOp = 2'b00;
                RegWrite = 1'b0;
                MemWrite = 1'b1;
                MemRead = 1'b0;
                ALUSrc = 1'b1;
                Branch = 1'b0;
                MemtoReg = 1'b0;
           end

            7'b1100011: begin //B type Branch
                ALUOp = 2'b01;
                RegWrite = 1'b0;
                MemWrite = 1'b0;
                MemRead = 1'b0;
                ALUSrc = 1'b0;
                Branch = 1'b1;
                MemtoReg = 1'b0;
            end
        default begin
                ALUOp = 2'b00;
                RegWrite = 1'b0;
                MemWrite = 1'b0;
                MemRead = 1'b0;
                ALUSrc = 1'b0;
                Branch = 1'b0;
                MemtoReg = 1'b0;
            end

        endcase
    end

endmodule
