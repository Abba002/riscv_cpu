`timescale 1ns/1ps
/*
-----------------------------------------------------------------------------
Module: RISC-V CPU Testbench
Project: 32-bit RISC-V Processor

Description:
This testbench verifies the integration of the processor datapath.

The simulation verifies:

1. Program Counter increments correctly
2. Instructions are fetched from Instruction Memory
3. Register operands are read correctly
4. The ALU executes R-type instructions
5. Results are written back into the Register File

The processor executes the following instruction sequence:

1. ADD x5, x1, x2
2. SUB x6, x5, x3
3. AND x7, x6, x4

-----------------------------------------------------------------------------
*/
module riscv_cpu_tb;
    reg clk;
    reg reset;

    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] alu_result;
    wire [31:0] read_data1;
    wire [31:0] read_data2;

    riscv_cpu dut(
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction),
        .alu_result(alu_result),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        #10;
        reset = 0;

        #1;
        $display("PC=%d | Instruction=%h | A=%d | B=%d | ALU result=%d", pc, instruction,$signed(read_data1),$signed(read_data2),$signed(alu_result));

        #10;
        $display("PC=%d | Instruction=%h | A=%d | B=%d | ALU result=%d", pc, instruction,$signed(read_data1),$signed(read_data2),$signed(alu_result));
        
        #10;
        $display("PC=%d | Instruction=%h | A=%d | B=%d | ALU result=%d", pc, instruction,$signed(read_data1),$signed(read_data2),$signed(alu_result));
        
        #10;
        $display("PC=%d | Instruction=%h | A=%d | B=%d | ALU result=%d", pc, instruction,$signed(read_data1),$signed(read_data2),$signed(alu_result));
        $finish;    
    end

endmodule