`timescale 1ns/1ps
/*
-----------------------------------------------------------------------------
Module: Immediate Generator Testbench
Project: 32-bit RISC-V Processor

Description:
This testbench verifies that the Immediate Generator correctly extracts
and sign-extends immediate values from I-type instructions.

The following cases are tested:

1. Positive immediate value
2. Negative immediate value

-----------------------------------------------------------------------------
*/
module immediate_generator_tb;
    reg [31:0] instruction;
    wire [31:0] immediate;

    immediate_generator dut(
        .instruction(instruction),
        .immediate(immediate)
    );

    initial begin
        // Test 1: Positive immediate = 10
        instruction = {12'd10, 5'd1, 3'b000, 5'd5, 7'b0010011};
        #10;
        $display("Immediate = %0d", $signed(immediate));

        // Test 2: Negative immediate = -5
        instruction = {-12'sd5, 5'd1, 3'b000, 5'd5, 7'b0010011};
        #10;
        $display("Immediate = %0d", $signed(immediate));
        $finish;
    end
    
    endmodule