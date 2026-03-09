module Data_Memory(
input logic ck,
input logic [31:0] Address,
input logic [31:0] WriteData,
input logic [3:0] WriteByte,
input logic MEMwrite,
input logic MEMread,
output logic [31:0] ReadData);

logic [31:0] RAM [0:511];

always_ff@(posedge ck) 
    if(MEMwrite) 
        case(WriteByte)
            //LB
            4'b0001: RAM[Address[31:2]][7:0] <= WriteData[7:0];
            4'b0010: RAM[Address[31:2]][15:8] <= WriteData[15:8];
            4'b0100: RAM[Address[31:2]][23:16] <= WriteData[23:16];
            4'b1000: RAM[Address[31:2]][31:24] <= WriteData[31:24];
            //LH
            4'b0011: RAM[Address[31:2]][15:0] <= WriteData[15:0];
            4'b1100: RAM[Address[31:2]][31:16] <= WriteData[31:16];
            //LW
            4'b1111: RAM[Address[31:2]] <= WriteData[31:0];
        endcase
always_comb
    if(MEMread)
        ReadData = RAM[Address[31:2]];
    else 
        ReadData = '0;


endmodule
