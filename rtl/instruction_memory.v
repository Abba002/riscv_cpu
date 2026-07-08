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
    memory[0] = 32'h00A08293;

    // ANDI x6, x5, 15
    // x6 = 20 & 15 = 4
    memory[1] = 32'h00F2F313;

    // ORI x7, x6, 8
    // x7 = 4 | 8 = 12
    memory[2] = 32'h00836393;

    // XORI x8, x7, 3
    // x8 = 12 ^ 3 = 15
    memory[3] = 32'h0033C413;

    // ADD x5, x1, x2
    //memory[0] = 32'h002082B3;

    // SUB x6, x5, x3
    //memory[1] = 32'h40328333;

    // AND x7, x6, x4
    //memory[2] = 32'h004373B3;
end


assign instruction = memory[pc[31:2]];

endmodule