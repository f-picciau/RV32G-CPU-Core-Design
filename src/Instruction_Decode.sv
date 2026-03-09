module Instruction_Decode(
input logic ck,
input logic reset,
input logic REGwrite,
input logic Branch,
input logic [1:0] ForwardA_ID,
input logic [1:0] ForwardB_ID,
input logic [31:0] PC,
input logic [31:0] Instruction,
input logic [4:0] wr_WB,
input logic [31:0] wd_WB,
input logic [31:0] ALUresult_EX,
input logic [31:0] ALUresult_MEM,
output logic Branch_out,
output logic [31:0] rd1,
output logic [31:0] rd2,
output logic [31:0] branchTarget,
output logic [31:0] Immediate,
output logic [4:0] wr,
output logic [6:0] Opcode,
output logic [9:0] funct7_funct3, 
output logic [9:0] rs2_rs1);

logic BranchCondition;
logic [31:0] rd1_mux;
logic [31:0] rd2_mux;
logic [31:0] m1_out;
logic [31:0] m2_out;

Registers u1(ck,reset,REGwrite,Instruction[19:15],Instruction[24:20],wr_WB,wd_WB,rd1,rd2);   
ImmGen u2(Instruction,Immediate);
Adder u3(PC,Immediate,branchTarget);
BranchBlock u4(Instruction[14:12],m1_out,m2_out,BranchCondition);
MUX_4 m1(ForwardA_ID,rd1_mux,ALUresult_MEM,ALUresult_EX,wd_WB,m1_out);
MUX_4 m2(ForwardB_ID,rd2_mux,ALUresult_MEM,ALUresult_EX,wd_WB,m2_out);

assign rd1_mux = rd1;
assign rd2_mux = rd2;

assign Branch_out=(BranchCondition & Branch)?1'b1:1'b0;

assign Opcode = Instruction[6:0];
assign wr = Instruction[11:7];
assign funct7_funct3 = {Instruction[31:25],Instruction[14:12]};
assign rs2_rs1 = Instruction[24:15];

endmodule
