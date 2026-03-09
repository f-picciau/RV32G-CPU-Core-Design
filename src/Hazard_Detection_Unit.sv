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
output logic IF_IDwrite,
output logic PCen,
output logic MuxControl);

always_comb begin
    //Default Pipeline Settings
    PCen = 1'b1;
    MuxControl = 1'b1;
    IF_IDwrite = 1'b1;
    //LOAD Standard Use
    if((MEMread_EX) && (wr_EX != '0) && (wr_EX == rs1 || wr_EX == rs2))
        begin
        PCen = 1'b0;
        MuxControl = 1'b0;
        IF_IDwrite = 1'b0;
        end
    //BRANCH in ID, LOAD in EX
    if((Branch) && (MEMread_EX) && (wr_EX != '0) && (wr_EX == rs1 || wr_EX == rs2))
        begin
        PCen = 1'b0;
        MuxControl = 1'b0;
        IF_IDwrite = 1'b0;
        end
    //BRANCH in ID, LOAD in MEM
    if((Branch) && (MEMread_MEM) && (wr_MEM != '0) && (wr_MEM == rs1 || wr_MEM == rs2))
        begin
        PCen = 1'b0;
        MuxControl = 1'b0;
        IF_IDwrite = 1'b0;
        end
end
endmodule
