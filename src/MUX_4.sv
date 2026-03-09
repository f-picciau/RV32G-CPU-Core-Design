module MUX_4(
input logic [1:0] sel,
input logic [31:0] A,
input logic [31:0] B,
input logic [31:0] C,
input logic [31:0] D,
output logic [31:0] out);

always_comb
    case(sel)
        2'b00: out = A;
        2'b01: out = B;
        2'b10: out = C;
        2'b11: out = D;
        default: out = '0;
    endcase
endmodule

