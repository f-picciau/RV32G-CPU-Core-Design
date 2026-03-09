module Store_Unit(
input logic [2:0] funct3,
input logic [31:0] ALUresult,
input logic MEMwrite,
input logic [31:0] rd2,
output logic [31:0] rd2_out,
output logic [3:0] WriteByte);


always_comb
    if(MEMwrite) begin
        case(funct3)
            //SB
            3'b000: begin
                case(ALUresult[1:0])
                    2'b00: begin rd2_out = {24'b0,rd2[7:0]}; WriteByte = 4'b0001; end
                    2'b01: begin rd2_out = {16'b0,rd2[7:0],8'b0}; WriteByte = 4'b0010; end
                    2'b10: begin rd2_out = {8'b0,rd2[7:0],16'b0}; WriteByte = 4'b0100; end
                    2'b11: begin rd2_out = {rd2[7:0],24'b0}; WriteByte = 4'b1000; end
                endcase
            end
            //SH
            3'b001: begin
                if(ALUresult[1] == 1'b0) begin rd2_out = {16'b0,rd2[15:0]};WriteByte = 4'b0011; end
                else begin rd2_out = {rd2[15:0],16'b0}; WriteByte = 4'b1100; end
            end
            //SW
            3'b010: begin rd2_out = rd2; WriteByte = 4'b1111; end
        default: begin rd2_out = rd2; WriteByte = 4'b1111; end
        endcase
    end
    else begin rd2_out = rd2; WriteByte = 4'b0000; end;
endmodule