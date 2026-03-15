module ImmGen(
input logic [31:0] Instruction,
output logic [31:0] Immediate);

always_comb
case(Instruction[6:0])
//I-type Instructions
7'b0000011: Immediate = {{20{Instruction[31]}},Instruction[31:20]};
7'b0010011: Immediate = {{20{Instruction[31]}},Instruction[31:20]};
7'b1100111: Immediate = {{20{Instruction[31]}},Instruction[31:20]};
//S-type Instructions
7'b0100011: Immediate = {{20{Instruction[31]}},Instruction[31:25],Instruction[11:7]};
//SB-type Instructions
7'b1100011: Immediate = {{19{Instruction[31]}},Instruction[31],Instruction[7],Instruction[30:25],Instruction[11:8],1'b0};
//U-type Instructions
7'b0110111: Immediate = {Instruction[31:12],{12{1'b0}}};
7'b0010111: Immediate = {Instruction[31:12],{12{1'b0}}};
//UJ-type Instructions
7'b1101111: Immediate = {{19{Instruction[31]}},Instruction[31],Instruction[19:12],Instruction[20],Instruction[30:21],1'b0};
default: Immediate = '0;
endcase
endmodule
