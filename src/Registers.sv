module Registers(
input logic ck,
input logic reset,
input logic REGwrite,
input logic [4:0] rs1,     //Read Source 1
input logic [4:0] rs2,     //Read Source 2
input logic [4:0] wr,      //Write Register 
input logic [31:0] wd,      //Write Data
output logic [31:0] rd1,    //Read Data 1
output logic [31:0] rd2);   //Read Data 2

logic [31:0] x [0:31];   //32bx32 Registers

always_ff@(posedge ck,posedge reset)
if(reset) begin
    for(int i = 0; i < 32; i++)begin
        x[i] <= '0;
end end
else if(REGwrite && wr!=5'b0) x[wr] <= wd; 

assign rd1 = (rs1 == 5'b0)?32'b0:x[rs1];
assign rd2 = (rs2 == 5'b0)?32'b0:x[rs2];

endmodule
