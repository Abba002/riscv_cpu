/*
-----------------------------------------------------------------------------
Module: RISC-V CPU
Project: 32-bit RISC-V Processor

Description:
This module integrates the major hardware components of the processor
into a single datapath.

The CPU performs the following operations:

1. Fetches an instruction from Instruction Memory
2. Decodes the instruction using the Control Unit
3. Reads operands from the Register File
4. Executes the operation in the ALU
5. Writes the ALU result back to the Register File

Current Features:

- Sequential instruction fetch
- R-type arithmetic instructions
- I-type arithmetic instructions
- Load Word (LW)
- Store Word (SW)
- Register write-back
- Data memory access

Inputs:
clk         System clock
reset       Resets the Program Counter

Outputs:
pc          Current Program Counter value
instruction Current instruction being executed
alu_result  Result produced by the ALU
read_data1  First register operand (debug)
read_data2  Second register operand (debug)

-----------------------------------------------------------------------------
*/
module riscv_cpu(
    input clk,
    input reset,
    output [31:0] pc,
    output [31:0] instruction,
    output [31:0] alu_result,
    output [31:0] read_data1,
    output [31:0] alu_input_b
);
    wire reg_write;
    wire [2:0] alu_control;
    wire alu_src;
    wire mem_to_reg;
    wire mem_write;

    wire [31:0] write_data;
    wire [31:0] memory_read_data;
    wire [31:0] immediate;
    wire [31:0] read_data2;

    program_counter pc_inst(
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    instruction_memory imem_inst(
        .pc(pc),
        .instruction(instruction)
    );

    control_unit cu_inst(
        .instruction(instruction),
        .reg_write(reg_write),
        .alu_control(alu_control),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write)
    );

    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;

    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd  = instruction[11:7];

    register_file rf_inst(
        .clk(clk),
        .reg_write(reg_write),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    immediate_generator imm_gen_inst (
    .instruction(instruction),
    .immediate(immediate)
    );

    alu alu_inst(
        .a(read_data1),
        .b(alu_input_b),
        .alu_control(alu_control),
        .result(alu_result)
    );

    data_memory dm_inst(
        .clk(clk),
        .mem_write(mem_write),
        .address(alu_result),
        .write_data(read_data2),
        .read_data(memory_read_data)
    );
    
    assign alu_input_b = alu_src ? immediate : read_data2;

    assign write_data = mem_to_reg ? memory_read_data : alu_result; //write back mux for LW
endmodule