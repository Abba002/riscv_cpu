/*
-----------------------------------------------------------------------------
Module: Program Counter
Project: 32-bit RISC-V Processor

Description:
This module implements the Program Counter (PC) for the processor.

The Program Counter stores the address of the current instruction being
executed. On every positive clock edge, the PC normally increments by
4 bytes to point to the next instruction. If reset is asserted, the PC
returns to address 0 so execution begins from the start of the program.

Inputs:
clk     System clock
reset   Resets the Program Counter to address 0

Outputs:
pc      Current Program Counter value (instruction address)

Notes:
- Sequential logic (updates on positive clock edge)
- Instructions are 32 bits (4 bytes), so the PC increments by 4
-----------------------------------------------------------------------------
*/
module program_counter (
    input clk,
    input reset,
    output reg [31:0] pc
);
    always @(posedge clk) begin
        if (reset)
            pc <= 32'd0;
        else
            pc <= pc + 32'd4;
    end
endmodule