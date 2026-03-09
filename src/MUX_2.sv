module MUX_2(
input logic sel,
input logic [31:0] A,
input logic [31:0] B,
output logic [31:0] out);

assign out=sel?A:B;

endmodule
