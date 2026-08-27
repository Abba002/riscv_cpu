`timescale 1ns/1ps
// ============================================================================
// RISC-V CPU Testbench
// ============================================================================
//
// Tests the complete single-cycle RISC-V processor.
//
// The CPU executes machine-code programs loaded into Instruction Memory
// from external .mem files.
//
// The testbench:
//
// - Generates the processor clock
// - Applies the initial reset
// - Displays CPU execution information
// - Detects the simulation halt marker
// - Provides a timeout to prevent infinite simulations
//
// ============================================================================

module riscv_cpu_tb;
    reg clk;
    reg reset;

    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] alu_result;
    wire [31:0] read_data1;
    wire [31:0] alu_input_b;

    //signed wires since simple expressions can only be passed into $monitor
    wire signed [31:0] signed_read_data1;
    wire signed [31:0] signed_alu_input_b;
    wire signed [31:0] signed_alu_result;

    assign signed_read_data1 = read_data1;
    assign signed_alu_input_b = alu_input_b;
    assign signed_alu_result = alu_result;

    riscv_cpu dut(
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction),
        .alu_result(alu_result),
        .read_data1(read_data1),
        .alu_input_b(alu_input_b)
    );

    always #5 clk = ~clk;


    initial begin
        clk = 0;
        reset = 1;

        #10;
        reset = 0;

        //manually add pc's to display
        /*
        #1;
        $display("PC=%d | Instruction=%h | A=%d | B=%d | ALU result=%d", pc, instruction,$signed(read_data1),$signed(alu_input_b),$signed(alu_result));

        #10;
        $display("PC=%d | Instruction=%h | A=%d | B=%d | ALU result=%d", pc, instruction,$signed(read_data1),$signed(alu_input_b),$signed(alu_result));
        
        #10;
        $display("PC=%d | Instruction=%h | A=%d | B=%d | ALU result=%d", pc, instruction,$signed(read_data1),$signed(alu_input_b),$signed(alu_result));
        
        #10;
        $display("PC=%d | Instruction=%h | A=%d | B=%d | ALU result=%d", pc, instruction,$signed(read_data1),$signed(alu_input_b),$signed(alu_result));
        $finish;   
        */ 
    end

    // automatically prints pc's
    initial begin
        $monitor(
            "PC=%d | Instruction=%h | A=%0d | B=%0d | ALU result=%0d", 
            pc,
            instruction,
            signed_read_data1,
            signed_alu_input_b,
            signed_alu_result
        );
    end

    // check for FFFFFFFF to end program
    always @(posedge clk) begin
        if(!reset && instruction == 32'hFFFFFFFF) begin
            $display("Program Complete");
            $finish;
        end
    end

    //timemout safety net to terminate program if caught in a loop
    initial begin
        #100000;
        $display("Error: Simulation timeout");
        $finish;
    end

endmodule