module Write_Back_Stage(
input logic MEMtoReg,
input logic [31:0] ReadData,
input logic [31:0] ALUresult,
output logic [31:0] Result_WB);

MUX_2 u1(MEMtoReg,ReadData,ALUresult,Result_WB);

endmodule
