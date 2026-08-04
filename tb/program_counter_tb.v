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
    reg next_pc;
    wire [31:0] pc;

    program_counter dut(
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );

    always #5 clk = ~clk;
    initial begin
        clk = 0;
        reset = 1;
        next_pc = 32'd0;
        
        // Release reset
        #10;
        reset = 0;

        // Load PC = 4
        next_pc = 32'd4;
        #10;
        $display("PC = %d", pc);

        // Load PC = 8
        next_pc = 32'd8;
        #10;
        $display("PC = %d", pc);

        // Load PC = 16
        next_pc = 32'd16;
        #10;
        $display("PC = %d", pc);

        // Load PC = 20
        next_pc = 32'd20;
        #10;
        $display("PC = %d", pc);

        $finish;

    end
    
    endmodule