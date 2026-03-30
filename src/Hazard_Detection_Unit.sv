module Hazard_Detection_Unit(
input logic [4:0] rs1,
input logic [4:0] rs2,
input logic [4:0] wr_EX,
input logic [4:0] wr_MEM,
input logic MEMread_EX,
input logic MEMread_MEM,
input logic REGwrite_EX,
input logic REGwrite_MEM,
input logic Branch,
input logic Jump,
output logic IF_IDwrite,
output logic PCen,
output logic MuxControl,
output logic Stall);


logic load_Standard;
logic load_EX_Branch;
logic load_MEM_Branch;
logic load_EX_Jump;
logic load_MEM_Jump;

//LOAD Standard Use
assign load_Standard = ((MEMread_EX) && (REGwrite_EX) && (wr_EX != '0) && (wr_EX == rs1 || wr_EX == rs2));
//LOAD in EX Branch in ID
assign load_EX_Branch  = ((Branch || Jump) && MEMread_EX && (wr_EX != 5'b0) && (wr_EX == rs1 || wr_EX == rs2));
//LOAD in MEM Branch in ID
assign load_MEM_Branch = ((Branch || Jump) && MEMread_MEM && (wr_MEM != 5'b0) && (wr_MEM == rs1 || wr_MEM == rs2));

always_comb begin
    //Default Pipeline Settings
    PCen = 1'b1;
    MuxControl = 1'b1;
    IF_IDwrite = 1'b1;
    Stall = 1'b0;
    
    Stall = load_Standard || load_EX_Branch || load_MEM_Branch;
    PCen = !Stall;
    MuxControl = !Stall;
    IF_IDwrite = !Stall;
end
endmodule
