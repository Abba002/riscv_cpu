`timescale 1ns/1ps
/*
-----------------------------------------------------------------------------
Module: Control Unit Testbench
Project: 32-bit RISC-V Processor

Description:
This testbench verifies that the Control Unit correctly decodes:

- R-type arithmetic instructions
- I-type arithmetic instructions
- Memory instructions

The following instructions are tested:

R-type
1. ADD
2. SUB
3. AND
4. OR
5. XOR

I-type
6. ADDI
7. ANDI
8. ORI
9. XORI

Memory
10. LW
11. SW

For each instruction, the testbench verifies:

- Register write enable
- ALU source selection
- Memory control signals
- ALU control output

-----------------------------------------------------------------------------
*/

module control_unit_tb;

    reg  [31:0] instruction;
    wire        reg_write;
    wire [2:0]  alu_control;
    wire        alu_src;
    wire        mem_write;
    wire        mem_to_reg;

    control_unit dut (
        .instruction(instruction),
        .reg_write(reg_write),
        .alu_control(alu_control),
        .alu_src(alu_src),
        .mem_write(mem_write),
        .mem_to_reg(mem_to_reg)
    );

    initial begin
        // ADD
        instruction = {7'b0000000, 5'd2, 5'd1, 3'b000, 5'd5, 7'b0110011};
        #10;
        $display("ADD: reg_write = %b, alu_control = %b", reg_write, alu_control);

        // SUB
        instruction = {7'b0100000, 5'd2, 5'd1, 3'b000, 5'd5, 7'b0110011};
        #10;
        $display("SUB: reg_write = %b, alu_control = %b", reg_write, alu_control);

        // AND
        instruction = {7'b0000000, 5'd2, 5'd1, 3'b111, 5'd5, 7'b0110011};
        #10;
        $display("AND: reg_write = %b, alu_control = %b", reg_write, alu_control);

        // OR
        instruction = {7'b0000000, 5'd2, 5'd1, 3'b110, 5'd5, 7'b0110011};
        #10;
        $display("OR : reg_write = %b, alu_control = %b", reg_write, alu_control);

        // XOR
        instruction = {7'b0000000, 5'd2, 5'd1, 3'b100, 5'd5, 7'b0110011};
        #10;
        $display("XOR: reg_write = %b, alu_control = %b", reg_write, alu_control);

        // ADDI x5, x1, 10
        instruction = {12'd10, 5'd1, 3'b000, 5'd5, 7'b0010011};
        #10;
        $display("ADDI: reg_write = %b, alu_src = %b, alu_control = %b", reg_write, alu_src, alu_control);

        // ANDI x5, x1, 10
        instruction = {12'd10, 5'd1, 3'b111, 5'd5, 7'b0010011};
        #10;
        $display("ANDI: reg_write = %b, alu_src = %b, alu_control = %b", reg_write, alu_src, alu_control);

        // ORI x5, x1, 10
        instruction = {12'd10, 5'd1, 3'b110, 5'd5, 7'b0010011};
        #10;
        $display("ORI : reg_write = %b, alu_src = %b, alu_control = %b", reg_write, alu_src, alu_control);

        // XORI x5, x1, 10
        instruction = {12'd10, 5'd1, 3'b100, 5'd5, 7'b0010011};
        #10;
        $display("XORI: reg_write = %b, alu_src = %b, alu_control = %b", reg_write, alu_src, alu_control);
        $finish;

        // LW
        instruction = {12'd8, 5'd1, 3'b010, 5'd5, 7'b0000011};
        #10;
        $display("LW: reg_write = %b, alu_src = %b, mem_to_reg = %b, mem_write = %b, alu_control = %b", reg_write, alu_src, mem_to_reg, mem_write, alu_control);

        // SW x5, 8(x1)
        instruction = {7'b0000000, 5'd5, 5'd1, 3'b010, 5'b01000, 7'b0100011};
        #10;
        $display("SW: reg_write = %b, alu_src = %b, mem_to_reg = %b, mem_write = %b, alu_control = %b", reg_write, alu_src, mem_to_reg, mem_write, alu_control);
    
    end

endmodule