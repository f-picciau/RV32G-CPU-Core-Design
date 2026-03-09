`timescale 1ns / 1ps

module TOP_testbench();
    logic clk;
    logic reset;
    logic [31:0] PC;
    logic [31:0] Instruction;
    logic [31:0] DataOut;


TOP dut(clk,reset,DataOut,PC,Instruction);


    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        
        #20;
        reset = 0;

        
        #200 $stop;
    end

endmodule