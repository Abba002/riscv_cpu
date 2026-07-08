/*
Module : Immediate Generator
Project: 32-bit RISC-V Processor

Description:
this module generates the immediate code for i type instructions and sign extends bit 1 to 12 depending on if it is positive or negative
*/
module immediate_generator (
    input [31:0] instruction,
    output [31:0] immediate
);
    assign immediate = {{20{instruction[31]}}, instruction[31:20]};
endmodule