module Forwarding_Unit(
input logic [4:0] rs1_ID,
input logic [4:0] rs2_ID,
input logic [4:0] rs1_EX,
input logic [4:0] rs2_EX,
input logic [4:0] wr_EX,
input logic [4:0] wr_MEM,
input logic [4:0] wr_WB,
input logic REGwrite_EX,
input logic REGwrite_MEM,
input logic REGwrite_WB,
input logic Jump,
input logic auipc,
output logic [1:0] ForwardA_EX,
output logic [1:0] ForwardB_EX,
output logic [1:0] ForwardA_ID,
output logic [1:0] ForwardB_ID,
output logic [1:0] ForwardJ_ID);

always_comb begin
    //ForwardA_EX Jump
    if(Jump || auipc)
        ForwardA_EX = 2'b11;
    //ForwardA_EX MEM Hazard
    else if((REGwrite_MEM) && (wr_MEM != 0) && (wr_MEM == rs1_EX))
        ForwardA_EX = 2'b10;
    //ForwardA_EX WB Hazard
    else if((REGwrite_WB) && (wr_WB != 0) && (wr_WB == rs1_EX))
        ForwardA_EX = 2'b01;
    //ForwardA_EX No Hazard
    else ForwardA_EX = 2'b00;
    
    //ForwardB_EX Jump
    if(Jump)
        ForwardB_EX = 2'b11;  
    //ForwardB_EX MEM Hazard
    else if((REGwrite_MEM) && (wr_MEM != 0) && (wr_MEM == rs2_EX))
        ForwardB_EX = 2'b10;
    //ForwardB_EX WB Hazard
    else if((REGwrite_WB) && (wr_WB != 0) && (wr_WB == rs2_EX))
        ForwardB_EX = 2'b01;
    //ForwardB_EX No Hazard
    else ForwardB_EX = 2'b00;
end

always_comb begin
    //ForwardA_ID EX Hazard
    if((REGwrite_EX) && (wr_EX != 0) && (wr_EX == rs1_ID))
        ForwardA_ID = 2'b11;
    //ForwardA_ID MEM Hazard
    else if((REGwrite_MEM) && (wr_MEM != 0) && (wr_MEM == rs1_ID))
        ForwardA_ID = 2'b10;
    //ForwardA_ID WB Hazard
    else if((REGwrite_WB) && (wr_WB != 0) && (wr_WB == rs1_ID))
        ForwardA_ID = 2'b01;
    //ForwardA_ID No Hazard       
    else 
        ForwardA_ID = 2'b00;
     
    //ForwardB_ID EX Hazard
    if((REGwrite_EX) && (wr_EX != 0) && (wr_EX == rs2_ID))
        ForwardB_ID = 2'b11;  
    //ForwardB_ID MEM Hazard
    else if((REGwrite_MEM) && (wr_MEM != 0) && (wr_MEM == rs2_ID))
        ForwardB_ID = 2'b10;
    //ForwardB_ID WB Hazard
    else if((REGwrite_WB) && (wr_WB != 0) && (wr_WB == rs2_ID))
        ForwardB_ID = 2'b01;
    //ForwardB_ID No Hazard       
    else 
        ForwardB_ID = 2'b00;           
end
always_comb begin
    //ForwardJ_ID WB Hazard
    if((REGwrite_WB) && (wr_WB != 0) && (wr_WB == rs1_ID))
        ForwardJ_ID = 2'b11;
    //ForwardJ_ID MEM Hazard
    else if((REGwrite_MEM) && (wr_MEM != 0) && (wr_MEM == rs1_ID))
        ForwardJ_ID = 2'b10;
    //ForwardJ_ID EX Hazard
    else if((REGwrite_EX) && (wr_EX != 0) && (wr_EX == rs1_ID))
        ForwardJ_ID = 2'b01;
    //ForwardJ_ID No Hazard
    else 
        ForwardJ_ID = 2'b00;
end
endmodule
