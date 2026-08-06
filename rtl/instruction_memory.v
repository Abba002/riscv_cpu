/*
-----------------------------------------------------------------------------
Module: Instruction Memory
Project: 32-bit RISC-V Processor

Description:
This module implements a simple read-only instruction memory for the processor.
It stores up to 256 instructions, each 32 bits wide. The Program Counter (PC)
provides the memory address, and the corresponding instruction is returned as
the output.

For this stage of the project, the instruction memory is initialized with a few
hardcoded placeholder instructions. These will later be replaced with real
RISC-V machine code loaded from an external file.

Inputs:
pc          32-bit Program Counter (byte address)

Outputs:
instruction 32-bit instruction stored at the requested address

Notes:
- Instruction memory is combinational.
- Instructions are word-aligned (4 bytes each).
- The lower two bits of the PC are ignored because every instruction occupies
  one 32-bit word.
-----------------------------------------------------------------------------
*/
module instruction_memory(
    input [31:0] pc,
    output [31:0] instruction
);

reg [31:0] memory [0:255];

// placeholder instructions
initial begin

    // ADDI x5, x1, 10
    // x5 = 10 + 10 = 20
    //memory[0] = 32'h00A08293;

    // ANDI x6, x5, 15
    // x6 = 20 & 15 = 4
    //memory[1] = 32'h00F2F313;

    // ORI x7, x6, 8
    // x7 = 4 | 8 = 12
    //memory[2] = 32'h00836393;

    // XORI x8, x7, 3
    // x8 = 12 ^ 3 = 15
    //memory[3] = 32'h0033C413;

    // ADD x5, x1, x2
    //memory[0] = 32'h002082B3;

    // SUB x6, x5, x3
    //memory[1] = 32'h40328333;

    // AND x7, x6, x4
    //memory[2] = 32'h004373B3;

    // LW x5, 4(x0)
    // x5 = memory[0] = 42
    //memory[0] = 32'h00402283;

    // SW x5, 8(x0)
    // memory[1] = x5 = 77
    //memory[1] = 32'h00502423;

    // LW x6, 8(x0)
    // x6 = memory[2], should be 42 if SW worked
    //memory[2] = 32'h00802303;

    // ADDI x7, x6, 5
    // x7 = 42 + 5 = 47
    //memory[3] = 32'h00530393;
    
    // BEQ test
    // ADDI x1, x0, 5
    // x1 = 5
    //memory[0] = 32'h00500093;

    // ADDI x2, x0, 5
    // x2 = 5
    //memory[1] = 32'h00500113;

    // BEQ x1, x2, +8
    // Since x1 == x2, skip memory[3] and branch to memory[4]
    //memory[2] = 32'h00208463;

    // ADDI x3, x0, 99
    // This instruction should be skipped
    //memory[3] = 32'h06300193;

    // ADDI x3, x0, 42
    // This instruction should execute
    //memory[4] = 32'h02A00193;

    //BNE test
    // ADDI x1, x0, 5
    //memory[0] = 32'h00500093;

    // ADDI x2, x0, 6
    //memory[1] = 32'h00600113;

    // BNE x1, x2, +8
    //memory[2] = 32'h00209463;

    // Should be skipped
    //memory[3] = 32'h06300193;

    // Should execute
    //memory[4] = 32'h02A00193;

        // ADDI x5, x0, 10
    // x5 = 10
    //memory[0] = 32'h00A00293;

    //JAL test
    // ADDI x5, x0, 10
    // x5 = 10
    // memory[0] = 32'h00A00293;

    // JAL x1, +8
    // x1 = PC + 4 = 8
    // Jump from PC = 4 to PC = 12
    // memory[1] = 32'h008000EF;

    // ADDI x3, x0, 99
    // This instruction should be skipped
    // memory[2] = 32'h06300193;

    // ADDI x2, x1, 5
    // x1 should contain the return address 8
    // x2 = 8 + 5 = 13
    // memory[3] = 32'h00508113;

    //JALR test
        // ADDI x5, x0, 12
    // x5 = 12
    memory[0] = 32'h00C00293;

    // JALR x1, 8(x5)
    // Target = 12 + 8 = 20
    // x1 = PC + 4 = 8
    memory[1] = 32'h008280E7;

    // ADDI x3, x0, 99
    // Should be skipped
    memory[2] = 32'h06300193;

    // ADDI x4, x0, 88
    // Should also be skipped
    memory[3] = 32'h05800213;

    // ADDI x6, x0, 77
    // Should also be skipped
    memory[4] = 32'h04D00313;

    // ADDI x2, x1, 5
    // x1 should contain 8, so x2 = 13
    memory[5] = 32'h00508113;
end


assign instruction = memory[pc[31:2]];

endmodule