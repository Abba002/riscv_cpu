/*
Module: ALU

Project: 32 bit RISC-V processor

Description: This module implements the Arithmetic and Logical Unit(ALU). The Alu perfoms basic arithmetic and logical operations depending on the alu_ontrol input.

Supported Operations:
000 - Addition
001 - Subtraction
010 - AND
011 - OR
100 - XOR

*/
module alu (
    input [31:0] a,
    input [31:0] b,
    input [2:0] alu_control,
    output reg [31:0] result
);
    always @(*) begin
        case (alu_control)
            3'b000: result = a + b; //ADD
            3'b001: result = a - b; //SUB
            3'b010: result = a & b; //AND
            3'b011: result = a | b; //OR
            3'b100: result = a ^ b; //XOR

            default: result = 32'b0;
        endcase
    end
endmodule