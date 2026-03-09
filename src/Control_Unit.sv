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
output logic [6:0] ALUop);

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
             end                  
        /*
        sb
        sh
        sw
        */
        7'b0100011: begin
             ControlBus = 6'b01x010;
             ALUop = 7'b0000011;            
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
             end                       
        /*
        jal
        jalr
        */           
        7'b1101111: begin
             ControlBus = 6'b11x000;
             ALUop = 7'b0000101;
             end                         
        /*
        lui
        auipc
        */ 
        7'b0110111: begin
             ControlBus = 6'b110000;
             ALUop = 7'b0000110;
             end   
        /*      
        auipc
        */ 
        7'b0010111: begin
             ControlBus = 6'b110000;
             ALUop = 7'b0000111;
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
        ALUop = 7'b10;
        end
    endcase
endmodule
