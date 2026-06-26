/*
-----------------------------------------------------------------------------
Module: Program Counter Testbench
Project: 32-bit RISC-V Processor

Description:
This testbench verifies the functionality of the Program Counter.

The following behaviors are tested:

1. Reset initializes the PC to address 0.
2. PC increments by 4 on each positive clock edge.
3. Reset can be asserted again during execution.
4. PC resumes normal operation after reset is released.

-----------------------------------------------------------------------------
*/
`timescale 1ns/1ps

module program_counter_tb;
    reg clk;
    reg reset;
    wire [31:0] pc;

    program_counter dut(
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    always #5 clk = ~clk;
    initial begin
        clk = 0;
        reset = 1;
        
        #10;
        $display("After reset, pc = %d", pc);

        reset = 0;

        #10;
        $display("After 1 increment: PC = %d", pc);

        #10;
        $display("After 2 increments: PC = %d", pc);

        #10;
        reset = 1;

        #10;
        $display("After 3 increments: PC = %d", pc);

        reset = 0;

        #10;
        $display("After 4 increments: PC = %d", pc);

        #10;
        $display("After 5 increments: PC = %d", pc);

        #10;
        $display("After 6 increments: PC = %d", pc);

        $finish;

    end
    
    endmodule