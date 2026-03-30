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
output logic [1:0] ForwardC_EX,
output logic [1:0] ForwardA_ID,
output logic [1:0] ForwardB_ID);

logic EX;
logic MEM;
logic WB;

logic EX_MEM_rs1, EX_WB_rs1;
logic EX_MEM_rs2, EX_WB_rs2;

logic ID_EX_rs1, ID_MEM_rs1, ID_WB_rs1;
logic ID_EX_rs2, ID_MEM_rs2, ID_WB_rs2;


assign EX = ((REGwrite_EX) && (wr_EX != 0));
assign MEM = ((REGwrite_MEM) && (wr_MEM != 0));
assign WB =  ((REGwrite_WB) && (wr_WB != 0));

assign EX_MEM_rs1 = MEM && (wr_MEM == rs1_EX);
assign EX_WB_rs1 = WB && (wr_WB == rs1_EX);
assign EX_MEM_rs2 = MEM && (wr_MEM == rs2_EX);
assign EX_WB_rs2 = WB && (wr_WB == rs2_EX);


assign ID_EX_rs1 = EX && (wr_EX == rs1_ID);
assign ID_MEM_rs1 = MEM && (wr_MEM == rs1_ID);
assign ID_WB_rs1 = WB && (wr_WB == rs1_ID);
assign ID_EX_rs2 = EX && (wr_EX == rs2_ID);
assign ID_MEM_rs2 = MEM && (wr_MEM == rs2_ID);
assign ID_WB_rs2 = WB && (wr_WB == rs2_ID);




//ForwardA_EX
assign ForwardA_EX = (Jump || auipc)?2'b11:        //Jump / auipc
                     (EX_MEM_rs1)   ?2'b10:        //MEM Hazard
                     (EX_WB_rs1)    ?2'b01:2'b00;  //WB Hazard / No Hazard
//ForwardB_EX
assign ForwardB_EX = (Jump)         ?2'b11:        //Jump
                     (EX_MEM_rs2)   ?2'b10:        //MEM Hazard
                     (EX_WB_rs2)    ?2'b01:2'b00;  //WB Hazard / No Hazard  
//ForwardC_EX
assign ForwardC_EX = (EX_MEM_rs2)   ?2'b10:        //MEM Hazard
                     (EX_WB_rs2)    ?2'b01:2'b00;  //WB Hazard / No Hazard              
//ForwardA_ID
assign ForwardA_ID = (ID_EX_rs1)    ?2'b11:        //EX Hazard
                     (ID_MEM_rs1)   ?2'b10:        //MEM Hazard
                     (ID_WB_rs1)    ?2'b01:2'b00;  //WB Hazard / No Hazard
//ForwardB_ID
assign ForwardB_ID = (ID_EX_rs2)    ?2'b11:        //EX Hazard
                     (ID_MEM_rs2)   ?2'b10:        //MEM Hazard
                     (ID_WB_rs2)    ?2'b01:2'b00;  //WB Hazard / No Hazard
endmodule
