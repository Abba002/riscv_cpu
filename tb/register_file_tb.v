`timescale 1ps/1ps

module register_file_tb;
    reg clk;
    reg we;

    reg [4:0] rs1;
    reg [4:0] rs2;
    reg [4:0] rd;

    reg [31:0] write_data;

    wire [31:0] read_data1;
    wire [31:0] read_data2;
    
    register_file dut(
        .clk(clk),
        .we(we),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        we = 1;

        rd = 5;
        write_data = 32'd15;

        #10;

        rs1 = 5;
        rs2 = 0;

        #10;

        $display("register x5 = %d", read_data1);

        $finish;
    end
endmodule