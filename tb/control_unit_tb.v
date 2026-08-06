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
- Branch instructions
- Jump instructions

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

Branch
12. BEQ
13. BNE

Jump
14. JAL
15. JALR

For each instruction, the testbench verifies:

- Register write enable
- ALU source selection
- Write-back source selection
- Memory control signals
- Branch control output
- Jump control output
- ALU control output

-----------------------------------------------------------------------------
*/

module control_unit_tb;

    reg  [31:0] instruction;
    wire        reg_write;
    wire [2:0]  alu_control;
    wire        alu_src;
    wire        mem_write;
    wire [1:0] branch_control;
    wire [1:0] writeback_select;
    wire [1:0] jump_control;

    control_unit dut (
        .instruction(instruction),
        .reg_write(reg_write),
        .alu_control(alu_control),
        .alu_src(alu_src),
        .mem_write(mem_write),
        .branch_control(branch_control),
        .writeback_select(writeback_select),
        .jump_control(jump_control)
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

        // LW
        instruction = {12'd8, 5'd1, 3'b010, 5'd5, 7'b0000011};
        #10;
        $display("LW: reg_write = %b, alu_src = %b, writeback_select = %b, mem_write = %b, alu_control = %b", reg_write, alu_src, writeback_select, mem_write, alu_control);

        // SW x5, 8(x1)
        instruction = {7'b0000000, 5'd5, 5'd1, 3'b010, 5'b01000, 7'b0100011};
        #10;
        $display("SW: reg_write = %b, alu_src = %b, writeback_select = %b, mem_write = %b, alu_control = %b", reg_write, alu_src, writeback_select, mem_write, alu_control);
    
        // BEQ x1, x2, +8
        instruction = {1'b0, 6'b000000, 5'd2, 5'd1, 3'b000, 4'b0100, 1'b0, 7'b1100011};
        #10;
        $display("BEQ: branch_control = %b, alu_control = %b", branch_control, alu_control);

        // BNE x1, x2, +8
        instruction = {1'b0, 6'b000000, 5'd2, 5'd1, 3'b001, 4'b0100, 1'b0, 7'b1100011};
        #10;
        $display("BNE: branch_control = %b, alu_control = %b", branch_control, alu_control);

        // JAL x1, +8
        instruction = {1'b0, 10'b0000000100, 1'b0, 8'b00000000, 5'd1, 7'b1101111};
        #10;
        $display("JAL: reg_write = %b, writeback_select = %b, jump_control = %b", reg_write, writeback_select, jump_control);

        // JALR x1, 8(x5)
        instruction = {12'd8, 5'd5, 5'd1, 7'b1100111};
        #10;
        $display("JALR: reg_write = %b, alu_src = %b, writeback_select = %b, jump_control = %b, alu_control = %b", reg_write, alu_src, writeback_select, jump_control, alu_control);
        $finish;
    end

endmodule