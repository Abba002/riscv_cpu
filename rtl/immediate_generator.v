/*
-----------------------------------------------------------------------------
Module: Immediate Generator
Project: 32-bit RISC-V Processor

Description:
This module extracts and sign-extends the immediate field from a
32-bit RISC-V instruction.

Currently, the Immediate Generator supports I-type instructions.

For I-type instructions, the immediate value is stored in bits [31:20]
of the instruction and is sign-extended to 32 bits.

Inputs:
instruction     32-bit RISC-V instruction

Outputs:
immediate       32-bit sign-extended immediate value

Notes:
- Combinational logic (no clock required)
- Currently supports I-type immediates only
-----------------------------------------------------------------------------
*/
module immediate_generator (
    input [31:0] instruction,
    output [31:0] immediate
);

// Extract and sign-extend the 12-bit I-type immediate.
    assign immediate = {{20{instruction[31]}}, instruction[31:20]};
endmodule

/*
Future Work:
- Support S-type immediates (SW)
- Support B-type immediates (BEQ, BNE)
- Support U-type immediates (LUI, AUIPC)
- Support J-type immediates (JAL)
*/