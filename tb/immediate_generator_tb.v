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
6. Postive J-type immediates
7. Negative J-type immediates
8. JALR I-type immediates
9. LUI U-type immediates
10. AUIPC U-type immediates

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

        // Test 6 : J-type immediate = +8 (JAL)
        instruction = {
            1'b0,          // imm[20]
            10'b0000000100,// imm[10:1]
            1'b0,          // imm[11]
            8'b00000000,   // imm[19:12]
            5'd1,          // rd = x1
            7'b1101111     // JAL opcode
        };
        #10;
        $display("JAL positive immediate = %0d", $signed(immediate));

        // Test 7 : J-type immediate = -8 (JAL)
        instruction = {
            1'b1,           // imm[20]
            10'b1111111100, // imm[10:1]
            1'b1,           // imm[11]
            8'b11111111,    // imm[19:12]
            5'd1,
            7'b1101111
        };
        #10;
        $display("JAL negative immediate = %0d", $signed(immediate));

        // Test 8: LUI x5, 0x12345 Expected immediate = 0x12345000
        instruction = {
            20'h12345,    // U-type immediate
            5'd5,         // rd = x5
            7'b0110111    // LUI opcode
        };
        #10;
        $display("LUI immediate = %h",immediate);


        // Test 9: AUIPC x5, 0x1 expected immediate: 0x00001000
        instruction = {
            20'h00001, //upper immediate
            5'd5,      //rd = x5
            7'b0010111 //AUIPC opcode
        };
        #10;
        $display("AUIPC instruction = %h, opcode = %b",
         instruction, instruction[6:0]);
        $display("AUIPC immediate = %h", immediate);

        $finish;

    end
    
    endmodule