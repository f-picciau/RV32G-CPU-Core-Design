/*
module BranchBlock(
input logic[2:0] funct3,
input logic [31:0] A,
input logic [31:0] B,
output logic BranchCondition);

localparam BEQ  = 3'b000;
localparam BNE  = 3'b001;
localparam BLT  = 3'b100;
localparam BGE  = 3'b101;
localparam BLTU = 3'b110;
localparam BGEU = 3'b111;


always_comb begin
    case(funct3)
        BEQ:  BranchCondition = ($signed(A) == $signed(B))?1'b1:1'b0;
        BNE:  BranchCondition = ($signed(A) != $signed(B))?1'b1:1'b0;
        BLT:  BranchCondition = ($signed(A) < $signed(B))?1'b1:1'b0;
        BGE:  BranchCondition = ($signed(A) >= $signed(B))?1'b1:1'b0;
        BLTU: BranchCondition = (A < B)?1'b1:1'b0;
        BGEU: BranchCondition = (A >= B)?1'b1:1'b0;
        default: BranchCondition = 1'b0;
    endcase 
    end
endmodule
*/
module BranchBlock(
    input  logic [2:0]  funct3,
    input  logic [31:0] A,
    input  logic [31:0] B,
    output logic        BranchCondition
);
    // Una sola operazione a 32-bit usa una carry-chain velocissima
    logic [32:0] sub;
    assign sub = {1'b0, A} - {1'b0, B};
    
    logic eq, lt, ltu;
    assign eq  = (A == B);
    assign ltu = sub[32]; // Il borrow della sottrazione
    assign lt  = (A[31] != B[31]) ? A[31] : ltu; // Gestione del segno

    always_comb begin
        case(funct3)
            3'b000: BranchCondition = eq;      // BEQ
            3'b001: BranchCondition = !eq;     // BNE
            3'b100: BranchCondition = lt;      // BLT
            3'b101: BranchCondition = !lt;     // BGE
            3'b110: BranchCondition = ltu;     // BLTU
            3'b111: BranchCondition = !ltu;    // BGEU
            default: BranchCondition = 1'b0;
        endcase
    end
endmodule