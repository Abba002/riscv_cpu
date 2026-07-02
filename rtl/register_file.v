/*
Module: Register file

Description: 
-contains 32 32-bit registers
-Supports 2 simultaneous reads
-one read per clock cycle

*/
module register_file(
    
    input clk,
    input reg_write,

    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] write_data,

    output [31:0] read_data1,
    output [31:0] read_data2

    );
    reg [31:0] registers [31:0];

    initial begin
        registers[0] = 32'd0;
        registers[1] = 32'd10;
        registers[2] = 32'd5;
        registers[3] = 32'd20;
        registers[4] = 32'd3;
       // registers[5] = 32'd9;
        //registers[6] = 32'd2;
        //registers[7] = 32'd7;
    end

    assign read_data1 = registers[rs1];
    assign read_data2 = registers[rs2];

    always @(posedge clk) begin
        if (reg_write &&(rd != 0))
            registers[rd] <=write_data; 
    end
endmodule
