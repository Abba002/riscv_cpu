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
    wire zero;

    alu dut(
        .a(a),
        .b(b),
        .alu_control(alu_control),
        .result(result),
        .zero(zero)
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

        //Test: result is not zero
        a = 32'd10;
        b = 32'd5;
        alu_control = 3'b001; //sub
        #10;
        $display("SUB: %0d - %0d = %0d | zero = %b", a, b, $signed(result), zero ;)

        //Test: result is zero
        a = 32'd10;
        b = 32'd10;
        alu_control = 3'b001; //sub
        #10;
        $display("SUB: %0d - %0d = %0d | zero = %b", a, b, $signed(result), zero ;)

        $finish;
    end
endmodule
