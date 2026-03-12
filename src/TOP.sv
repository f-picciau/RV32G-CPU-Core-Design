module TOP( 
input logic ck,
input logic reset,
output logic [31:0] DataOut,
output logic [31:0] PC,
output logic [31:0] Instruction);

logic [31:0] branchTarget_ID;
logic [31:0] PC_IF;
logic [31:0] Instruction_IF;
logic [6:0] ALUop_Mux;
logic [31:0] rd1_ID;
logic [31:0] rd2_ID;
logic [31:0] Immediate_ID;
logic [4:0] wr_ID;
logic [6:0] Opcode_ID;
logic [9:0] funct7_funct3_ID;
logic [9:0] rs2_rs1_ID;
logic [31:0] ALUresult_EX;
logic [31:0] rd2_EX;
logic [31:0] ALUresult_MEM;
logic [31:0] ReadData_MEM;
logic [31:0] DataOut_WB;
logic [31:0] PC_IF_ID;
logic [31:0] Instruction_IF_ID;
logic [4:0] wr_ID_EX;
logic [31:0] Immediate_ID_EX;
logic [31:0] rd1_ID_EX;
logic [31:0] rd2_ID_EX;
logic [9:0] rs2_rs1_ID_EX;
logic [9:0] rs2_rs1_IF_ID;
logic [9:0] funct7_funct3_ID_EX;
logic [6:0] ALUop_ID_EX;
logic [31:0] ALUresult_EX_MEM;
logic [31:0] rd2_EX_MEM;
logic [4:0] wr_EX_MEM;
logic [4:0] wr_MEM_WB;
logic [31:0] ReadData_MEM_WB;
logic [31:0] ALUresult_MEM_WB;
logic [5:0] ALUcontrol;
logic [5:0] ControlBus;
logic [12:0] m1_out;
logic [1:0] ForwardA_EX;
logic [1:0] ForwardB_EX;
logic [1:0] ForwardA_ID;
logic [1:0] ForwardB_ID;
logic [2:0] funct3_EX_MEM;
logic [1:0] ForwardJ_ID;
logic [31:0] PC_ID_EX;

logic Jump_ID_EX;
logic Jump_ID;
logic JumpTaken;
logic IF_Flush;
logic Stall;
logic Jump;
logic Branch_ID;
logic IF_IDwrite;
logic ALUsrc_ID_EX;
logic MEMread_ID_EX;
logic MEMwrite_ID_EX;
logic REGwrite_ID_EX;
logic MEMtoReg_ID_EX;
logic REGwrite_MEM_WB;
logic MEMtoReg_MEM_WB;
logic PCen;
logic MuxControl;
logic MEMread_EX_MEM;
logic MEMwrite_EX_MEM;
logic REGwrite_EX_MEM;
logic MEMtoReg_EX_MEM;


 //---------- STAGES REGISTERS ----------   
 
 //IF_ID_Register  --outputs ok  --inputs ok --FATTO
 IF_ID_Register r1 (
    //Inputs
    .ck(ck),
    .reset(reset),
    .IF_flush(IF_Flush),
    .IF_IDwrite(IF_IDwrite),
    .PC(PC_IF),
    .Instruction(Instruction_IF),
    //Outputs
    .PC_out(PC_IF_ID),
    .Instruction_out(Instruction_IF_ID),
    .rs2_rs1(rs2_rs1_IF_ID)
);
 //ID_EX_Register  --outputs ok  --inputs ok  --FATTO
 ID_EX_Register r2 (
    //Inputs
    .reset(reset),
    .ck(ck),
    .wr(wr_ID),
    .rs2_rs1(rs2_rs1_ID),
    .Immediate(Immediate_ID),
    .rd1(rd1_ID),
    .rd2(rd2_ID),
    .funct7_funct3(funct7_funct3_ID),
    .ALUsrc(m1_out[4]),
    .ALUop(m1_out[12:6]),
    .MEMread(m1_out[2]),
    .MEMwrite(m1_out[1]),
    .REGwrite(m1_out[5]),
    .MEMtoReg(m1_out[3]),
    .Jump(Jump_ID),
    .PC(PC_IF_ID),
    //Outputs
    .PC_out(PC_ID_EX),
    .Jump_out(Jump_ID_EX),
    .wr_out(wr_ID_EX),
    .Immediate_out(Immediate_ID_EX),
    .rd1_out(rd1_ID_EX),
    .rd2_out(rd2_ID_EX),
    .rs2_rs1_out(rs2_rs1_ID_EX),
    .funct7_funct3_out(funct7_funct3_ID_EX),
    .ALUsrc_out(ALUsrc_ID_EX),
    .ALUop_out(ALUop_ID_EX),
    .MEMread_out(MEMread_ID_EX),
    .MEMwrite_out(MEMwrite_ID_EX),
    .REGwrite_out(REGwrite_ID_EX),
    .MEMtoReg_out(MEMtoReg_ID_EX)
);
 //EX_MEM_Register  --inputs ok  --outputs ok  --FATTO
 EX_MEM_Register r3 (
    //Inputs
    .ck(ck),
    .reset(reset),
    .ALUresult(ALUresult_EX),
    .rd2(rd2_EX),
    .wr(wr_ID_EX),
    .MEMread(MEMread_ID_EX),
    .MEMwrite(MEMwrite_ID_EX),
    .REGwrite(REGwrite_ID_EX),
    .MEMtoReg(MEMtoReg_ID_EX),
    .funct3(funct7_funct3_ID_EX[2:0]),
    //Outputs
    .ALUresult_out(ALUresult_EX_MEM),
    .rd2_out(rd2_EX_MEM),
    .wr_out(wr_EX_MEM),
    .MEMread_out(MEMread_EX_MEM),
    .MEMwrite_out(MEMwrite_EX_MEM),
    .REGwrite_out(REGwrite_EX_MEM),
    .MEMtoReg_out(MEMtoReg_EX_MEM),
    .funct3_out(funct3_EX_MEM)
);
 //MEM_WB_Register  --inputs ok --outputs ok  --FATTO
 MEM_WB_Register r4 (
    //Inputs
    .ck(ck),
    .reset(reset),
    .REGwrite(REGwrite_EX_MEM),
    .MEMtoReg(MEMtoReg_EX_MEM),
    .ReadData(ReadData_MEM),
    .ALUresult(ALUresult_MEM),
    .wr(wr_EX_MEM),
    //Outputs
    .REGwrite_out(REGwrite_MEM_WB),
    .MEMtoReg_out(MEMtoReg_MEM_WB),
    .wr_out(wr_MEM_WB),
    .ReadData_out(ReadData_MEM_WB),
    .ALUresult_out(ALUresult_MEM_WB)
);
 
 
 //---------- STAGES ----------
 
 //Instruction_Fetch   --outputs ok  --inputs ok  --FATTO
 Instruction_Fetch s1 (
    //Inputs
    .ck(ck),
    .reset(reset),
    .PCsrc(JumpTaken),
    .PCen(PCen),
    .Adder_ID(branchTarget_ID),
    //Outputs
    .PC(PC_IF),
    .Instruction(Instruction_IF)
);
 //Instruction_Decode  --outputs ok  --inputs ok  --FATTO
 Instruction_Decode s2 (
    //Inputs
    .ck(ck),
    .reset(reset),
    .REGwrite(REGwrite_MEM_WB),
    .PC(PC_IF_ID),
    .Instruction(Instruction_IF_ID),
    .wr_WB(wr_MEM_WB),
    .wd_WB(DataOut_WB),
    .Branch(m1_out[0]),
    .ALUresult_EX(ALUresult_EX),
    .ALUresult_MEM(ALUresult_EX_MEM),
    .ForwardA_ID(ForwardA_ID),
    .ForwardB_ID(ForwardB_ID),
    .Jump(Jump),
    .Stall(Stall),
    .ForwardJ_ID(ForwardJ_ID),
    //Outputs
    .Jump_out(Jump_ID),
    .JumpTaken(JumpTaken),
    .rd1(rd1_ID),
    .rd2(rd2_ID),
    .branchTarget(branchTarget_ID),
    .Immediate(Immediate_ID),
    .wr(wr_ID),
    .Opcode(Opcode_ID),
    .funct7_funct3(funct7_funct3_ID),
    .rs2_rs1(rs2_rs1_ID),
    .IF_Flush(IF_Flush)
    );
 //Execute_Stage    --outputs ok  --inputs ok  --FATTO
 Execute_Stage s3 (
    //Inputs
    .rd1(rd1_ID_EX),
    .rd2(rd2_ID_EX),
    .Immediate(Immediate_ID_EX),
    .ALUresult_MEM(ALUresult_MEM),
    .WriteData_WB(DataOut_WB),
    .ALUsrc(ALUsrc_ID_EX),
    .Forward_A(ForwardA_EX),
    .Forward_B(ForwardB_EX),
    .ALUcontrol(ALUcontrol),
    .PC(PC_ID_EX),
    //Outputs
    .ALUresult(ALUresult_EX),
    .rd2_out(rd2_EX)
);
 //Memory_Stage  --outputs ok  --inputs ok  --FATTO
 Memory_Stage s4 (
    //Inputs
    .ck(ck),
    .MEMwrite(MEMwrite_EX_MEM),
    .MEMread(MEMread_EX_MEM),
    .ALUresult(ALUresult_EX_MEM),
    .rd2(rd2_EX_MEM),
    .funct3(funct3_EX_MEM),
    //Outputs
    .ALUresult_out(ALUresult_MEM),
    .ReadData(ReadData_MEM)
);
 //Write_Back_Stage  --inputs ok --outputs ok  --FATTO
 Write_Back_Stage s5 (
    //Inputs
    .MEMtoReg(MEMtoReg_MEM_WB),
    .ReadData(ReadData_MEM_WB),
    .ALUresult(ALUresult_MEM_WB),
    //Output
    .Result_WB(DataOut_WB)
);
 
 
 //---------- CONTROL BLOCKS ----------
 
 //ALU_Control_Unit  --inputs ok  --output ok  -FATTO
 ALU_Control_Unit c1 (
    //Input
    .ALUop(ALUop_ID_EX),
    .funct3(funct7_funct3_ID_EX[2:0]),
    .funct7_bit5(funct7_funct3_ID_EX[8]),
    //Output
    .ALUcontrol(ALUcontrol)
);
 //Control_Unit  --input ok  --outputs ok  --FATTO
 Control_Unit c2 (
    //Input
    .Opcode(Opcode_ID),
    //Outputs
    .ControlBus(ControlBus),
    .ALUop(ALUop_Mux),
    .Jump(Jump)
);
 //Forwarding_Unit  --inputs ok  --outputs ok  --FATTO
 Forwarding_Unit c3 (
    //Inputs
    .rs1_EX(rs2_rs1_ID_EX[4:0]),
    .rs2_EX(rs2_rs1_ID_EX[9:5]),
    .rs1_ID(rs2_rs1_IF_ID[4:0]),
    .rs2_ID(rs2_rs1_IF_ID[9:5]),
    .wr_EX(wr_ID_EX),
    .wr_MEM(wr_EX_MEM),
    .wr_WB(wr_MEM_WB),
    .Jump(Jump_ID_EX),
    .REGwrite_EX(ControlBus[5]),
    .REGwrite_MEM(REGwrite_EX_MEM),
    .REGwrite_WB(REGwrite_MEM_WB),
    //Outputs
    .ForwardA_EX(ForwardA_EX),
    .ForwardB_EX(ForwardB_EX),
    .ForwardA_ID(ForwardA_ID),
    .ForwardB_ID(ForwardB_ID),
    .ForwardJ_ID(ForwardJ_ID)
);
 //Hazard_Detection_Unit  --outputs ok  --inputs ok  --FATTO
 Hazard_Detection_Unit c4 (
    //Inputs
    .rs1(rs2_rs1_ID[4:0]),
    .rs2(rs2_rs1_ID[9:5]),
    .wr_EX(wr_ID_EX),
    .wr_MEM(wr_EX_MEM),
    .MEMread_EX(MEMread_ID_EX),
    .MEMread_MEM(MEMread_EX_MEM),
    .REGwrite_EX(REGwrite_ID_EX),
    .REGwrite_MEM(REGwrite_EX_MEM),
    .Branch(ControlBus[0]),
    .Jump(Jump),
    //Outputs
    .IF_IDwrite(IF_IDwrite),
    .PCen(PCen),
    .MuxControl(MuxControl),
    .Stall(Stall)
);
 
 
 //MUX Hazard_Detection_Unit - Control_Unit  --inputs ok  --output ok  --FATTO
 MUX_2_12bits m1 (
    //Inputs
    .sel(MuxControl),
    .A({ALUop_Mux,ControlBus}),
    .B('0),
    //Output
    .out(m1_out)
);
 
 assign DataOut = DataOut_WB;
 assign PC = PC_IF;
 assign Instruction = Instruction_IF;
 
 endmodule
