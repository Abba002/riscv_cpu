`timescale 1ns/1ps
/*
-----------------------------------------------------------------------------
Module: Immediate Generator Testbench
Project: 32-bit RISC-V Processor

Description:
This testbench verifies that the Immediate Generator correctly extracts
and sign-extends immediate values from I-type instructions.

The following cases are tested:

1. Positive I-type immediate
2. Negative I-type immediate
3. S-type immediate (SW)
4. Positive B-type immediate
5. Negative B-type immediate

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

        // Test 3: S-type immediate for SW = 8
        instruction = {7'b0000000, 5'd5, 5'd1, 3'b010, 5'b01000, 7'b0100011};
        #10;
        $display("SW immediate = %0d", $signed(immediate));

        // Test 4 : B-type immediate = +8
        instruction = {
            1'b0,       // imm[12]
            6'b000000,  // imm[10:5]
            5'd2,       // rs2
            5'd1,       // rs1
            3'b000,     // funct3 = BEQ
            4'b0100,    // imm[4:1]
            1'b0,       // imm[11]
            7'b1100011  // branch opcode
        };
        #10;
        $display("BEQ positive immediate = %0d", $signed(immediate));

        // Test 5 : B-type immediate = -8
        instruction = {
            1'b1,       // imm[12]
            6'b111111,  // imm[10:5]
            5'd2,       // rs2
            5'd1,       // rs1
            3'b000,     // funct3 = BEQ
            4'b1100,    // imm[4:1]
            1'b1,       // imm[11]
            7'b1100011  // branch opcode
        };

        #10;
        $display("BEQ negative immediate = %0d", $signed(immediate));

        $finish;

    end
    
    endmodule