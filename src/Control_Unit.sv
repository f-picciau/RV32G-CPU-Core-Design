module Control_Unit(
input logic [6:0] Opcode,
output logic [5:0] ControlBus,
/*
ControlBus[5] = REGwrite
ControlBus[4] = ALUsrc
ControlBus[3] = MEMtoReg
ControlBus[2] = MEMread
ControlBus[1] = MEMwrite
ControlBus[0] = Branch
*/
output logic [6:0] ALUop,
output logic auipc,
output logic jal,
output logic Jump);

/*

*/
always_comb
    case(Opcode)     
    //----------  RV32I Base Integer Instructions  ----------
        /*
        add
        sub
        xor
        or
        and
        sll
        srl
        sra
        slt
        sltu
        */
        7'b0110011: begin
             ControlBus = 6'b100000;
             ALUop = 7'b0000000;
             Jump = 1'b0;
             end
             
        /*
        addi
        xori
        ori
        andi
        slli
        srli
        srai
        slti
        sltiu
        */
        7'b0010011: begin
             ControlBus = 6'b110000;
             ALUop = 7'b0000001;
             Jump = 1'b0;
             end       
        
        /*
        lb
        lh
        lw
        lbu
        lhu
        */
        7'b0000011: begin
             ControlBus = 6'b111100;
             ALUop = 7'b0000010;
            Jump = 1'b0; 
             end                  
        /*
        sb
        sh
        sw
        */
        7'b0100011: begin
             ControlBus = 6'b01x010;
             ALUop = 7'b0000011;  
             Jump = 1'b0;          
             end                
        /*
        beq
        bne
        blt
        bge
        bltu
        bgeu
        */
        7'b1100011: begin
             ControlBus = 6'b00x001;
             ALUop = 7'b0000100;
             Jump = 1'b0;
             end                       
        /*
        jal
        */           
        7'b1101111: begin
             ControlBus = 6'b100000;
             ALUop = 7'b0000101;
             Jump = 1'b1;
             jal = 1'b1;
             end   
        /*
        jalr  
        */   
        7'b1100111: begin
             ControlBus = 6'b100000;
             ALUop = 7'b0000101;
             Jump = 1'b1;
             end                   
        /*
        lui
        */ 
        7'b0110111: begin
             ControlBus = 6'b110000;
             ALUop = 7'b0000110;
             Jump = 1'b0;
             end   
        /*      
        auipc
        */ 
        7'b0010111: begin
             ControlBus = 6'b110000;
             ALUop = 7'b0000101;
             Jump = 1'b0;
             auipc = 1'b1;
             end
        
        /*
        ecall
        ebreak
               
        7'b1110011: begin
             ControlBus = 6'b;
             ALUop = 7'b0001000;
             end  
             
        */  
    //-------------------------        
        default: begin
        ControlBus = '0;
        Jump = 1'b0;
        auipc = 1'b0;
        ALUop = 7'b10;
        jal = 1'b0;
        end
    endcase
endmodule
