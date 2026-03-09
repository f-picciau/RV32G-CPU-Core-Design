module Program_Counter(
input logic ck,
input logic reset,
input logic PCen,
input logic [31:0] PC_next,
output logic [31:0] PC);


always_ff@(posedge ck, posedge reset)
if(reset) PC <= '0;
else if(PCen) PC <= PC_next;

endmodule
