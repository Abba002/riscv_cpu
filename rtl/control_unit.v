/*Description:
This module decodes a 32-bit RISC-V instruction and generates the
control signals required by the processor.

Currently, the Control Unit supports:

- R-type arithmetic instructions
    • ADD
    • SUB
    • AND
    • OR
    • XOR

- I-type arithmetic instructions
    • ADDI
    • ANDI
    • ORI
    • XORI

- Memory Instructions
    • LW
    • SW

The opcode identifies the instruction type, while the funct3 and funct7
fields determine the specific ALU operation.

Inputs:
instruction     32-bit RISC-V instruction

Outputs:
reg_write      Enables writing to the Register File
alu_control    Selects the ALU operation

alu_src        Selects the ALU second operand
               0 = Register File
               1 = Immediate Generator

mem_to_reg     Selects Register File write-back source
               0 = ALU result
               1 = Data Memory output

mem_write      Enables writing to Data Memory

Notes:
- Combinational logic (no clock required)
- Unsupported instructions keep the default control values
-----------------------------------------------------------------------------
*/
module control_unit(
    input [31:0] instruction,
    output reg reg_write,
    output reg [2:0] alu_control,
    output reg alu_src,
    output reg mem_to_reg,
    output reg mem_write
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
        mem_write = 1'b0;
        mem_to_reg = 1'b0;

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
                    3'b111: alu_control = 3'b010; // ANDI
                    3'b110: alu_control = 3'b011; // ORI
                    3'b100: alu_control = 3'b100; // XORI
                endcase
            end

            7'b0000011: begin // LW 
                    reg_write  = 1'b1;
                    alu_src    = 1'b1;
                    mem_to_reg = 1'b1;
                    mem_write  = 1'b0;
                    alu_control = 3'b000; // ADD address = base + offset
            end

            7'b0100011: begin // SW
                    reg_write  = 1'b0;
                    alu_src    = 1'b1;
                    mem_to_reg = 1'b0;
                    mem_write  = 1'b1;
                    alu_control = 3'b000; // ADD address = base + offset
            end
        endcase
    end
endmodule

/*
Future Work:
- Branch instructions (BEQ, BNE)
- Jump instructions (JAL, JALR)
- Additional control signals
    • branch
    • jump
*/