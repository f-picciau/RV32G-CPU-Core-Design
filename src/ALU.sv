module ALU(
input logic [31:0] A,
input logic [31:0] B,
input logic [5:0] ALUcontrol,
output logic [31:0] result);


localparam ADD  = 6'b000000;
localparam SUB  = 6'b000001;
localparam XOR  = 6'b000010;
localparam OR   = 6'b000011;
localparam AND  = 6'b000100;
localparam SLL  = 6'b000101;
localparam SRL  = 6'b000110;
localparam SRA  = 6'b000111;
localparam SLT  = 6'b001000;
localparam SLTU = 6'b001001;

always_comb begin
    case(ALUcontrol)
        ADD:  result = A + B;
        SUB:  result = A - B;
        XOR:  result = A ^ B;
        OR:   result = A | B;
        AND:  result = A & B;
        SLL:  result = A << B[4:0];
        SRL:  result = A >> B[4:0];
        SRA:  result = $signed(A) >>> B[4:0];
        SLT:  result = ($signed(A) < $signed(B))?32'b1:32'b0;
        SLTU: result = (A < B)?32'b1:32'b0;


        
    default:result = '0;
    endcase
    end
endmodule
