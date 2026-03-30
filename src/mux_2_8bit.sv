module MUX_2_12bits(
input logic sel,
input logic [12:0] A,
input logic [12:0] B,
output logic [12:0] out);

assign out=sel?A:B;

endmodule
