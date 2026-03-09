module Instruction_Memory(
input logic [31:0] PC,
output logic [31:0] Instruction);

logic [31:0] Mem [0:255];

initial begin

$readmemh("Program_File.mem", Mem);
      
end

assign Instruction = Mem[PC[31:2]];
endmodule
