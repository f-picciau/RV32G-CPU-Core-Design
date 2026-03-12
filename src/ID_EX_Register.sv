module ID_EX_Register(
input logic reset,
input logic ck,

input logic [4:0] wr,
input logic [9:0] rs2_rs1,
input logic [31:0] Immediate,
input logic [31:0] rd1,
input logic [31:0] rd2,
input logic [9:0] funct7_funct3, 
input logic Jump,
input logic [31:0] PC,
input logic ALUsrc,
input logic [6:0] ALUop,
input logic MEMread,
input logic MEMwrite,
input logic REGwrite,
input logic MEMtoReg,

output logic [31:0] PC_out,
output logic Jump_out,
output logic [4:0] wr_out,
output logic [31:0] Immediate_out,
output logic [31:0] rd1_out,
output logic [31:0] rd2_out,
output logic [9:0] rs2_rs1_out,
output logic [9:0] funct7_funct3_out,
output logic ALUsrc_out,
output logic [6:0] ALUop_out,
output logic MEMread_out,
output logic MEMwrite_out,
output logic REGwrite_out,
output logic MEMtoReg_out);

always_ff@(posedge ck, posedge reset)
if(reset)begin
{ALUsrc_out,ALUop_out,MEMread_out,MEMwrite_out,REGwrite_out,MEMtoReg_out} <= '0;
{wr_out,Immediate_out,rd1_out,rd2_out,rs2_rs1_out,funct7_funct3_out,Jump_out,PC_out} <= '0;
end
else begin
wr_out <= wr;
Immediate_out <= Immediate; 
rd1_out <= rd1;
rd2_out <= rd2;
rs2_rs1_out <= rs2_rs1;
funct7_funct3_out <= funct7_funct3;
ALUsrc_out <= ALUsrc;
ALUop_out <= ALUop;
MEMread_out <= MEMread;
MEMwrite_out <= MEMwrite;
REGwrite_out <= REGwrite;
MEMtoReg_out <= MEMtoReg;
Jump_out <= Jump;
PC_out <= PC;
end
endmodule
