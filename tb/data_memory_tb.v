`timescale 1ns/1ps
/*
-----------------------------------------------------------------------------
Module: Data Memory Testbench
Project: 32-bit RISC-V Processor

Description:
This testbench verifies the functionality of the Data Memory.

The following behaviors are tested:

1. Writing data into memory
2. Reading data from memory
3. Writing to multiple memory locations
4. Verifying stored data remains unchanged after additional writes

-----------------------------------------------------------------------------
*/

 module data_memory_tb;
    reg clk;
    reg mem_write;
    reg [31:0] address;
    reg [31:0] write_data;
    wire [31:0] read_data;

    data_memory dut(
        .clk(clk),
        .mem_write(mem_write),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        mem_write = 1'b0;
        address = 32'd0;
        write_data = 32'd0;

        #10;
        address = 32'd0;
        write_data = 32'd25;
        mem_write = 1'b1;

        #10;
        mem_write = 1'b0;
        #10;

        $display("Address %d read_data = %d", address, read_data);

        address = 32'd4;
        write_data = 32'd99;
        mem_write = 1'b1;

        #10;
        mem_write = 1'b0;
        #10;
        $display("Address %d read_data = %d", address, read_data);
        
        address = 32'd0;
        #10;
        $display("Address %d read_data = %d", address, read_data);

        $finish;
    end
    
endmodule
