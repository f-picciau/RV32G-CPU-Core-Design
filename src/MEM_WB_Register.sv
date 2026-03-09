module MEM_WB_Register(
input logic ck,
input logic reset,
input logic REGwrite,
input logic MEMtoReg,
input logic [31:0] ReadData,
input logic [31:0] ALUresult,
input logic [4:0] wr,
output logic REGwrite_out,
output logic MEMtoReg_out,
output logic [4:0] wr_out,
output logic [31:0] ReadData_out,
output logic [31:0] ALUresult_out);

always_ff@(posedge ck,posedge reset)
if(reset) begin
{REGwrite_out,MEMtoReg_out} <= '0;
{ReadData_out,ALUresult_out,wr_out} <= '0;
end
else begin
REGwrite_out <= REGwrite;
MEMtoReg_out <= MEMtoReg;
wr_out <= wr;
ReadData_out <= ReadData;
ALUresult_out <= ALUresult;
end



endmodule
