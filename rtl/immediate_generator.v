/*
-----------------------------------------------------------------------------
Module: Immediate Generator
Project: 32-bit RISC-V Processor

Description:
This module extracts and sign-extends the immediate field from a
32-bit RISC-V instruction.

Currently, the Immediate Generator supports:

- I-type immediates
    • ADDI
    • ANDI
    • ORI
    • XORI
    • LW

- S-type immediates
    • SW

For I-type instructions, the immediate value is stored in bits [31:20]
of the instruction and is sign-extended to 32 bits.

Inputs:
instruction     32-bit RISC-V instruction

Outputs:
immediate       32-bit sign-extended immediate value

Notes:
- Combinational logic (no clock required)
- Supports I-type and S-type immediates
-----------------------------------------------------------------------------
*/
module immediate_generator (
    input [31:0] instruction,
    output reg [31:0] immediate
);


    always @(*) begin
        case (instruction[6:0])

            7'b0010011: // I-type arithmetic
                immediate = {{20{instruction[31]}}, instruction[31:20]};

            7'b0000011: // LW
                immediate = {{20{instruction[31]}}, instruction[31:20]};

            7'b0100011: // SW
                immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};

            default:
                immediate = 32'd0;

        endcase
    end

endmodule

/*
Future Work:
- Support B-type immediates (BEQ, BNE)
- Support U-type immediates (LUI, AUIPC)
- Support J-type immediates (JAL)
*/