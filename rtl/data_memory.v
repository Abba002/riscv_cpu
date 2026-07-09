/*
-----------------------------------------------------------------------------
Module: Data Memory
Project: 32-bit RISC-V Processor

Description:
This module implements the processor's Data Memory.

The Data Memory stores 32-bit data values that can be read from or
written to during program execution.

Memory reads are combinational, allowing data to be accessed immediately
when the address changes.

Memory writes are sequential and occur only on the positive edge of the
clock when mem_write is asserted.

Inputs:
clk         System clock
mem_write   Memory write enable
address     Byte address supplied by the ALU
write_data  Data to be written into memory

Outputs:
read_data   Data stored at the selected memory address

Notes:
- 256 memory locations
- 32-bit word width
- Byte addresses are converted to word indices using address[31:2]
-----------------------------------------------------------------------------
*/
module data_memory(
    input clk,
    input mem_write,
    input [31:0] address,
    input [31:0] write_data,
    output [31:0] read_data
);
    reg [31:0] memory [255:0];
    
    assign read_data = memory[address[31:2]];

    always @(posedge clk ) begin
        if(mem_write)
            memory[address[31:2]] <= write_data;
    end

    initial begin
        memory[0] = 32'd100;
        memory[1] = 32'd42;
        memory[2] = 32'd99;
    end
endmodule