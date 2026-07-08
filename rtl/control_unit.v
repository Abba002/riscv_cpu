/*Description:
This module decodes a 32-bit RISC-V instruction and generates the
control signals required by the processor.

Currently, the Control Unit supports only R-type and I-Type arithmetic instructions:

- ADD
- SUB
- AND
- OR
- XOR
- ADDI

The opcode identifies the instruction type, while the funct3 and funct7
fields determine the specific ALU operation.

Inputs:
instruction     32-bit RISC-V instruction

Outputs:
reg_write       Enables writing the ALU result back to the Register File
alu_control     Selects the ALU operation

Notes:
- Combinational logic (no clock required)
- Unsupported instructions keep the default control values
-----------------------------------------------------------------------------
*/
module control_unit(
    input [31:0] instruction,
    output reg reg_write,
    output reg [2:0] alu_control,
    output reg alu_src
);

wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;

assign opcode = instruction[6:0];
assign funct3 = instruction[14:12];
assign funct7 = instruction[31:25];

    always @(*) begin
        alu_control = 3'b000;
        reg_write = 1'b0;
        alu_src = 1'b0;

        case(opcode)
            7'b0110011: begin //R-type instruction
                reg_write = 1'b1;
                case({funct7,funct3})
                    10'b0000000000: alu_control = 3'b000; //add
                    10'b0100000000: alu_control = 3'b001; //sub
                    10'b0000000111: alu_control = 3'b010; //and
                    10'b0000000110: alu_control = 3'b011; //or
                    10'b0000000100: alu_control = 3'b100; //xor
                endcase
            end
            7'b0010011: begin  // I-type instruction
                reg_write = 1'b1;
                alu_src = 1'b1;
                case(funct3)
                    3'b000: alu_control = 3'b000; // ADDI
                endcase
            end
        endcase
    end
endmodule

/*
Future Work:
- Load instructions
- Store instructions
- Branch instructions
- Jump instructions
- Additional control signals (mem_read, mem_write, branch, jump, alu_src)
*/