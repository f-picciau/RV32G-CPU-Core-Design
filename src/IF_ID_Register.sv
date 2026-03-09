module IF_ID_Register(
input logic ck,
input logic reset,
input logic IF_flush,
input logic IF_IDwrite,
input logic [31:0] PC,
input logic [31:0] Instruction,
output logic [31:0] PC_out,
output logic [31:0] Instruction_out,
output logic [9:0] rs2_rs1);

always_ff@(posedge ck, posedge reset)
if(reset || IF_flush) begin
PC_out <= '0; 
Instruction_out <= '0;
rs2_rs1 <='0;
end
else if(IF_IDwrite) begin
PC_out <= PC;
Instruction_out <= Instruction;
rs2_rs1 <= Instruction[24:15];
end

endmodule
