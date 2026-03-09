module Instruction_Fetch(
input logic ck,
input logic reset,
input logic PCsrc,
input logic PCen,
input logic [31:0] Adder_ID,
output logic [31:0] PC,
output logic [31:0] Instruction);

logic [31:0] Adder_out;
logic [31:0] Mux_out;

Program_Counter u1(ck,reset,PCen,Mux_out,PC);
Instruction_Memory u2(PC,Instruction);
Adder a1(PC,32'd4,Adder_out);
MUX_2 m1(PCsrc,Adder_ID,Adder_out,Mux_out);

endmodule
