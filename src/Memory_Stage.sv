module Memory_Stage(
input logic ck,
input logic MEMwrite,
input logic MEMread,
input logic [31:0] ALUresult,
input logic [31:0] rd2,
input logic [2:0] funct3,
output logic [31:0] ALUresult_out,
output logic [31:0] ReadData);

logic [31:0] rd2_out;
logic [3:0] WriteByte;
logic [31:0] ReadData_RAM;
logic [31:0] DataOut;

Data_Memory u1(ck,ALUresult,rd2_out,WriteByte,MEMwrite,MEMread,ReadData_RAM);

Store_Unit u2(funct3,ALUresult,MEMwrite,rd2,rd2_out,WriteByte);

Load_Unit u3(funct3,ReadData_RAM,MEMread,ALUresult[1:0],DataOut);

assign ReadData = DataOut;

assign ALUresult_out = ALUresult;

endmodule
