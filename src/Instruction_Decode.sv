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
input logic Jump,
input logic [1:0] ForwardJ_ID,
input logic Stall,
output logic Jump_out,
output logic JumpTaken,
output logic IF_Flush,
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
logic [31:0] rd1_temp;
logic [31:0] rd2_temp;
logic [31:0] m1_out;
logic [31:0] m2_out;
logic [31:0] m3_out;
logic [31:0] jump_data;
logic Branch_out;

Registers u1(ck,reset,REGwrite,Instruction[19:15],Instruction[24:20],wr_WB,wd_WB,rd1_temp,rd2_temp);   
ImmGen u2(Instruction,Immediate);
Adder u3(m3_out,Immediate,branchTarget);
BranchBlock u4(Instruction[14:12],m1_out,m2_out,BranchCondition);
MUX_4 m1(ForwardA_ID,rd1_mux,wd_WB,ALUresult_MEM,ALUresult_EX,m1_out);
MUX_4 m2(ForwardB_ID,rd2_mux,wd_WB,ALUresult_MEM,ALUresult_EX,m2_out);

MUX_2 m3(Jump,jump_data,PC,m3_out);
MUX_4 m4(ForwardJ_ID,rd1,ALUresult_EX,ALUresult_MEM,wd_WB,jump_data);

assign rd1_mux = rd1_temp;
assign rd2_mux = rd2_temp;
assign rd1 = m1_out;
assign rd2 = m2_out;

assign Jump_out = Jump;
assign Branch_out=(BranchCondition & Branch)?1'b1:1'b0;
assign JumpTaken = Jump || Branch_out;
assign IF_Flush = JumpTaken && (!Stall);

assign Opcode = Instruction[6:0];
assign wr = Instruction[11:7];
assign funct7_funct3 = {Instruction[31:25],Instruction[14:12]};
assign rs2_rs1 = Instruction[24:15];

endmodule
