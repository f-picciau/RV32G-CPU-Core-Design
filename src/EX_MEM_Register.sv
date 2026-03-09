module EX_MEM_Register(
input logic ck,
input logic reset,
input logic [31:0] ALUresult,
input logic [31:0] rd2,
input logic [4:0] wr,
input logic MEMread,
input logic MEMwrite,
input logic REGwrite,
input logic MEMtoReg,
input logic [2:0] funct3,
output logic [31:0] ALUresult_out,
output logic [31:0] rd2_out,
output logic [4:0] wr_out,
output logic MEMread_out,
output logic MEMwrite_out,
output logic REGwrite_out,
output logic MEMtoReg_out,
output logic [2:0] funct3_out);

always_ff@(posedge ck,posedge reset)
if(reset) begin
{MEMread_out,MEMwrite_out,REGwrite_out,MEMtoReg_out} <= '0;
{ALUresult_out,rd2_out,wr_out} <= '0;
end
else begin
ALUresult_out <= ALUresult;
rd2_out <= rd2;
wr_out <= wr;
MEMread_out <= MEMread;
MEMwrite_out <= MEMwrite;
REGwrite_out <= REGwrite; 
MEMtoReg_out <= MEMtoReg;
end
endmodule
