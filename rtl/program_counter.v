/*
-----------------------------------------------------------------------------
Module: Program Counter
Project: 32-bit RISC-V Processor

Description:
Stores the current Program Counter (PC).

The next PC value is supplied by the CPU datapath,
allowing support for:

- Sequential execution (PC + 4)
- Branch instructions
- Future jump instructions

Inputs:
clk         System clock
reset       Resets the Program Counter to address 0
next_pc     Next Program Counter value

Outputs:
pc      Current Program Counter value (instruction address)

Notes:
- Sequential logic
- Loads the next PC value on each rising clock edge
-----------------------------------------------------------------------------
*/
module program_counter (
    input clk,
    input reset,
    input [31:0] next_pc,
    output reg [31:0] pc
);
    always @(posedge clk) begin
        if (reset)
            pc <= 32'd0;
        else
            //pc <= pc + 32'd4;
            pc <= next_pc;
    end
endmodule