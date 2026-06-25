`timescale 1ns/1ps

module instruction_memory_tb;
    reg [31:0] pc;
    wire [31:0] instruction;

    instruction_memory dut(
        .pc(pc),
        .instruction(instruction)
    );
    initial begin
        pc = 32'd0;
        #10;
        $display("PC = %d, Instruction = %h", pc, instruction);
        pc = 32'd4;
        #10;
        $display("PC = %d, Instruction = %h", pc, instruction);
        pc = 32'd8;
        #10;
        $display("PC = %d, Instruction = %h", pc, instruction);
        $finish;
    end

endmodule
