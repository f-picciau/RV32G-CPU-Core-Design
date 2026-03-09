module Load_Unit(
input logic [2:0] funct3,
input logic [31:0] ReadData,
input logic MEMread,
input logic [1:0] ALUresult,
output logic [31:0] DataOut);

always_comb
    if(MEMread) begin
        case(funct3)
            //LB
            3'b000: begin
                case(ALUresult)
                    2'b00: DataOut = {{24{ReadData[7]}},ReadData[7:0]};
                    2'b01: DataOut = {{24{ReadData[15]}},ReadData[15:8]};
                    2'b10: DataOut = {{24{ReadData[23]}},ReadData[23:16]};
                    2'b11: DataOut = {{24{ReadData[31]}},ReadData[31:24]};               
                endcase
            end
            //LH
            3'b001: 
                if(ALUresult == 2'b00) DataOut = {{16{ReadData[15]}},ReadData[15:0]};
                else DataOut = {{16{ReadData[31]}},ReadData[31:16]};
            //LW
            3'b010: DataOut = ReadData;
            //LBU
            3'b100:
                case(ALUresult)
                    2'b00: DataOut = {{24{1'b0}},ReadData[7:0]};
                    2'b01: DataOut = {{24{1'b0}},ReadData[15:8]};
                    2'b10: DataOut = {{24{1'b0}},ReadData[23:16]};
                    2'b11: DataOut = {{24{1'b0}},ReadData[31:24]};               
                endcase
            //LHU
            3'b101:
                if(ALUresult == 2'b00) DataOut = {{16{1'b0}},ReadData[15:0]};
                else DataOut = {{16{1'b0}},ReadData[31:16]};
            default: DataOut = ReadData;
        endcase
        end
        else DataOut = 32'b0;
        
    


endmodule
