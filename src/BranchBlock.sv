module BranchBlock(
input logic[2:0] funct3,
input logic [31:0] m1_in,
input logic [31:0] m2_in,
output logic BranchCondition);

localparam BEQ  = 3'b000;
localparam BNE  = 3'b001;
localparam BLT  = 3'b100;
localparam BGE  = 3'b101;
localparam BLTU = 3'b110;
localparam BGEU = 3'b111;


always_comb begin
    case(funct3)
        BEQ:  BranchCondition = ($signed(m1_in) == $signed(m2_in))?1'b1:1'b0;
        BNE:  BranchCondition = ($signed(m1_in) != $signed(m2_in))?1'b1:1'b0;
        BLT:  BranchCondition = ($signed(m1_in) < $signed(m2_in))?1'b1:1'b0;
        BGE:  BranchCondition = ($signed(m1_in) >= $signed(m2_in))?1'b1:1'b0;
        BLTU: BranchCondition = (m1_in < m2_in)?1'b1:1'b0;
        BGEU: BranchCondition = (m1_in >= m2_in)?1'b1:1'b0;
        default: BranchCondition = 1'b0;
    endcase 
    end
endmodule
