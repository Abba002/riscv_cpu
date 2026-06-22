`timescale 1ps/1ps
/*
Testbench: ALU testbench

Description: This testbench is used to verify the functionality of the  32-bitALU module.

*/
module alu_tb;
    reg [31:0] a;
    reg [31:0] b;
    reg [2:0] alu_control;

    wire [31:0] result;

    alu dut(
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result)
    );

    initial begin
        a = 1;
        b = 0;

        alu_control = 3'b000; #10;
        $display("ADD: %d + %d = %d", a, b, result);

        alu_control = 3'b001; #10;
        $display("SUB: %d - %d = %d", a, b, result);

        alu_control = 3'b010; #10;
        $display("AND: %b & %b = %b", a, b, result);
        
        alu_control = 3'b011; #10;
        $display("OR: %b | %b = %b", a, b, result);

        alu_control = 3'b100; #10;
        $display("XOR: %b ^ %b = %b", a, b, result);

        $finish;
    end
endmodule
