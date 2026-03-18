module RiscV_Top(
    input logic rst,
    input logic clk
);
    logic [31:0] pc_in, pc_out, pc_next, pc_branch;
    logic [31:0] instr;
    logic [31:0] rd1, rd2;
    logic [31:0] alu_src2;
    logic [31:0] imm_next;
    logic [31:0] read_data;
    logic [31:0] alu_out;
    logic [31:0] wd_reg;
    logic [1:0] alu_op;
    logic [2:0] alu_ctrl;
    logic [2:0] func3;
    logic zero_flag;
    logic mem_write, mem_read, branch, mem_to_reg, reg_write;
    logic alu_src;
    logic branch_zero,branch_path;





ALU_Control alu_Control_Unit (
    .func3(instr[14:12]), .ALUOp(alu_op), .instr30(instr[30]), .alu_control(alu_ctrl)
);

ALU ALU_Unit (
    .alu_control(alu_ctrl), .rs1(rd1), .rs2(alu_src2),
    .rd(alu_out), .zero_flag(zero_flag), .big_flag(big_flag)
);

DataMemory Data_Memory_Unit (
    .address(alu_out), .wd(rd2), .mem_read(mem_read),
    .mem_write(mem_write), .clk(clk), .rd(read_data)
);

Immediate_generator imm_gen (
    .instr(instr), .imm_out(imm_next)
);

Instruction_memory instr_mem (
    .address(pc_out), .instr(instr)
);

MainControlUnit MainCtrlUnit (
    .Opcode(instr[6:0]), .ALUOp(alu_op), .RegWrite(reg_write),
    .MemWrite(mem_write), .MemRead(mem_read),
    .ALUSrc(alu_src), .Branch(branch), .MemtoReg(mem_to_reg)
);

pc_reg pc_reg_unit (
    .clk(clk), .rst(rst), .pc_in(pc_in), .pc_out(pc_out)
);
RegisterFile reg_file_unit (
    .RA1 (instr[19:15]), .RA2(instr[24:20]), .WA(instr[11:7]),
    .clk(clk), .RegWrite(reg_write), .rst(rst),
    .RD1(rd1), .RD2(rd2), .WD(wd_reg)
);

assign func3 = instr[14:12];
assign pc_next = pc_out + 32'd4;

assign alu_src2 = (alu_src) ? imm_next : rd2;  //RD2(0) or imm(1)

assign pc_branch = pc_out + imm_next; //for branch
always_comb begin
    case (instr[14:12]) //func3
    3'b000: branch_path = zero_flag; //BEQ
    3'b001: branch_path = !zero_flag; //BNE
    3'b100: branch_path = big_flag; //BLT
    3'b101: branch_path = !big_flag; //BGE
    default branch_path = 1'b0;
    endcase
end

assign branch_zero = branch && branch_path; //checks if its branch command
assign pc_in = branch_zero ? pc_branch : pc_next; //jumps if branch_zero = 1, else continue

assign wd_reg = (mem_to_reg) ? read_data : alu_out; //0 - alu calcs, 1 - load commands

endmodule
