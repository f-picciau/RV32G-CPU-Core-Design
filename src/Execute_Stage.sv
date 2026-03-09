module Execute_Stage(
input logic [31:0] rd1,
input logic [31:0] rd2,
input logic [31:0] Immediate,
input logic [31:0] ALUresult_MEM,
input logic [31:0] WriteData_WB,
input logic ALUsrc,
input logic [1:0] Forward_A,
input logic [1:0] Forward_B,
input logic [5:0] ALUcontrol,

output logic [31:0] ALUresult,
output logic [31:0] rd2_out);

logic [31:0] m1_out;
logic [31:0] m2_out;
logic [31:0] m3_out;


ALU a1(m1_out,m3_out,ALUcontrol,ALUresult);
MUX_3 m1(Forward_A,rd1,WriteData_WB,ALUresult_MEM,m1_out);
MUX_3 m2(Forward_B,rd2,WriteData_WB,ALUresult_MEM,m2_out);
MUX_2 m3(ALUsrc,Immediate,m2_out,m3_out);

assign rd2_out = m2_out;

endmodule
