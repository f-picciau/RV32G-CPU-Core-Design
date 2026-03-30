module ALU_Control_Unit(
input logic [6:0] ALUop,
input logic [2:0] funct3,
input logic funct7_bit5,
output logic [5:0] ALUcontrol);

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

always_comb
    case(ALUop[6:4])
        //----------  RV32I-Base  ----------
        3'b000: case(ALUop[3:0])
            4'b0000:
                case(funct3)
                    3'b000:
                        if(funct7_bit5) ALUcontrol = SUB;            //SUB
                        else ALUcontrol = ADD;                       //ADD            
                    3'b001: ALUcontrol = SLL;                        //SLL
                    3'b010: ALUcontrol = SLT;                        //SLT
                    3'b011: ALUcontrol = SLTU;                       //SLTU
                    3'b100: ALUcontrol = XOR;                        //XOR
                    3'b101: begin
                        if(funct7_bit5) ALUcontrol = SRA;            //SRA
                        else ALUcontrol = SRL;                       //SRL
                    end     
                    3'b110: ALUcontrol = OR;                         //OR
                    3'b111: ALUcontrol = AND;                        //AND   
                    default: ALUcontrol = ADD;     
                endcase
            4'b0001:
               case(funct3)
                    3'b000: ALUcontrol = ADD;                        //ADDI                              
                    3'b001: ALUcontrol = SLL;                        //SLLI
                    3'b010: ALUcontrol = SLT;                        //SLTI
                    3'b011: ALUcontrol = SLTU;                       //SLTIU
                    3'b100: ALUcontrol = XOR;                        //XORI
                    3'b101: begin
                        if(funct7_bit5) ALUcontrol = SRA ;           //SRAI
                        else ALUcontrol = SRL;                       //SRLI
                    end     
                    3'b110: ALUcontrol = OR;                         //ORI
                    3'b111: ALUcontrol = AND;                        //ANDI  
                    default: ALUcontrol = ADD;       
                endcase
            4'b0010: ALUcontrol = ADD;                               //LB,LH,lW,LBU,LHU
            4'b0011: ALUcontrol = ADD;                               //SB,SH,SW
            //BRANCH do nothing, already implemented in Branch Block in Instruction Decode Stage
            4'b0100: ALUcontrol = ADD;                               //BRANCH
            4'b0101: ALUcontrol = ADD;                               //JAL,JALR
            4'b0110: ALUcontrol = ADD;                               //LUI,AUIPC
            //3'b0111:                                               //ECALL, EBREAK
            default: ALUcontrol = ADD;     
        endcase
        /*----------  RV32M-Math  ----------
        3'b001: case(ALUop[3:0])
        endcase
        //----------  RV32A-Atomic  ----------
        3'b010: case(ALUop[3:0])
        endcase
        //----------  RV32F/D-Float  ----------
        3'b011: case(ALUop[3:0])
        endcase
        //----------  Custom-Alpha  ----------
        3'b100: case(ALUop[3:0])
        endcase
        //----------  Custom-Beta  ----------
        3'b101: case(ALUop[3:0])
        endcase
        //----------  System/CSR  ----------
        3'b110: case(ALUop[3:0])
        endcase
        //----------  Special  ----------
        3'b111: case(ALUop[3:0])
        endcase
        */
        default: ALUcontrol = ADD;
        
endcase 
    
endmodule
