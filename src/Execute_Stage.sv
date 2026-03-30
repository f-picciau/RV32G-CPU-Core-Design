module Execute_Stage(
input logic [31:0] rd1,
input logic [31:0] rd2,
input logic [31:0] Immediate,
input logic [31:0] ALUresult_MEM,
input logic [31:0] WriteData_WB,
input logic [31:0] PC,
input logic ALUsrc,
input logic [1:0] Forward_A,
input logic [1:0] Forward_B,
input logic [1:0] Forward_C,
input logic [5:0] ALUcontrol,
//new
input logic [2:0] funct3,
input logic Branch,
input logic Jump,
input logic jal,
output logic JumpTaken,
output logic [31:0] BranchTarget,


output logic [31:0] ALUresult,
output logic [31:0] rd2_out);

logic [31:0] m1_out;
logic [31:0] m2_out;
logic [31:0] m3_out;

//new
logic Branch_out;
logic [31:0] m4_out;
logic sel_m4;
logic BranchCondition;
logic [31:0] m5_out;



ALU a1(m1_out,m3_out,ALUcontrol,ALUresult);
MUX_4 m1(Forward_A,rd1,WriteData_WB,ALUresult_MEM,PC,m1_out);
MUX_4 m2(Forward_B,rd2,WriteData_WB,ALUresult_MEM,4,m2_out);
MUX_2 m3(ALUsrc,Immediate,m2_out,m3_out);



//new
BranchBlock u2(funct3,m1_out,m2_out,BranchCondition);
Adder u3(m4_out,Immediate,BranchTarget);
MUX_2 m4(sel_m4,PC,m5_out,m4_out);
MUX_4 m5(Forward_C,rd1,WriteData_WB,ALUresult_MEM,32'b0,m5_out);



//new
assign Branch_out=(BranchCondition & Branch)?1'b1:1'b0;
assign JumpTaken = Jump || Branch_out;
assign sel_m4 = Branch || (jal && Jump);




assign rd2_out = m2_out;

endmodule
