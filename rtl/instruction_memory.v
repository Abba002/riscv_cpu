// ============================================================================
// Instruction Memory
// ============================================================================
//
// Stores the machine-code instructions executed by the processor.
//
// Instructions are loaded from an external hexadecimal .mem file using
// $readmemh(). This keeps program code separate from the CPU hardware.
//
// Each line of the .mem file contains one 32-bit instruction in hexadecimal.
//
// Example:
//
//     00500093
//     01400113
//     002081B3
//
// Since each RISC-V instruction is 4 bytes, the Program Counter increments
// by 4 while the memory array is indexed by words:
//
//     PC = 0  -> memory[0]
//     PC = 4  -> memory[1]
//     PC = 8  -> memory[2]
//
// Different test programs are stored in the programs/ directory.
// Change the file path in $readmemh() to select the program to execute.
//
// ============================================================================
module instruction_memory(
    input [31:0] pc,
    output [31:0] instruction
);

reg [31:0] memory [0:255];


initial begin
    $readmemh("programs/memory_branch_test.mem",memory); // Load machine-code instructions from an external hexadecimal memory fil
    
    // placeholder instructions
    // ADDI x5, x1, 10
    // x5 = 10 + 10 = 20
    //memory[0] = 32'h00A08293;

    // ANDI x6, x5, 15
    // x6 = 20 & 15 = 4
    //memory[1] = 32'h00F2F313;

    // ORI x7, x6, 8
    // x7 = 4 | 8 = 12
    //memory[2] = 32'h00836393;

    // XORI x8, x7, 3
    // x8 = 12 ^ 3 = 15
    //memory[3] = 32'h0033C413;

    // ADD x5, x1, x2
    //memory[0] = 32'h002082B3;

    // SUB x6, x5, x3
    //memory[1] = 32'h40328333;

    // AND x7, x6, x4
    //memory[2] = 32'h004373B3;

    // LW x5, 4(x0)
    // x5 = memory[0] = 42
    //memory[0] = 32'h00402283;

    // SW x5, 8(x0)
    // memory[1] = x5 = 77
    //memory[1] = 32'h00502423;

    // LW x6, 8(x0)
    // x6 = memory[2], should be 42 if SW worked
    //memory[2] = 32'h00802303;

    // ADDI x7, x6, 5
    // x7 = 42 + 5 = 47
    //memory[3] = 32'h00530393;
    
    // BEQ test
    // ADDI x1, x0, 5
    // x1 = 5
    //memory[0] = 32'h00500093;

    // ADDI x2, x0, 5
    // x2 = 5
    //memory[1] = 32'h00500113;

    // BEQ x1, x2, +8
    // Since x1 == x2, skip memory[3] and branch to memory[4]
    //memory[2] = 32'h00208463;

    // ADDI x3, x0, 99
    // This instruction should be skipped
    //memory[3] = 32'h06300193;

    // ADDI x3, x0, 42
    // This instruction should execute
    //memory[4] = 32'h02A00193;

    //BNE test
    // ADDI x1, x0, 5
    //memory[0] = 32'h00500093;

    // ADDI x2, x0, 6
    //memory[1] = 32'h00600113;

    // BNE x1, x2, +8
    //memory[2] = 32'h00209463;

    // Should be skipped
    //memory[3] = 32'h06300193;

    // Should execute
    //memory[4] = 32'h02A00193;

        // ADDI x5, x0, 10
    // x5 = 10
    //memory[0] = 32'h00A00293;

    //JAL test
    // ADDI x5, x0, 10
    // x5 = 10
    // memory[0] = 32'h00A00293;

    // JAL x1, +8
    // x1 = PC + 4 = 8
    // Jump from PC = 4 to PC = 12
    // memory[1] = 32'h008000EF;

    // ADDI x3, x0, 99
    // This instruction should be skipped
    // memory[2] = 32'h06300193;

    // ADDI x2, x1, 5
    // x1 should contain the return address 8
    // x2 = 8 + 5 = 13
    // memory[3] = 32'h00508113;

    //JALR test
        // ADDI x5, x0, 12
    // x5 = 12
    //memory[0] = 32'h00C00293;

    // JALR x1, 8(x5)
    // Target = 12 + 8 = 20
    // x1 = PC + 4 = 8
    //memory[1] = 32'h008280E7;

    // ADDI x3, x0, 99
    // Should be skipped
    //memory[2] = 32'h06300193;

    // ADDI x4, x0, 88
    // Should also be skipped
    //memory[3] = 32'h05800213;

    // ADDI x6, x0, 77
    // Should also be skipped
    //memory[4] = 32'h04D00313;

    // ADDI x2, x1, 5
    // x1 should contain 8, so x2 = 13
    //memory[5] = 32'h00508113;

    //LUI test
    //LUI x5, 0x12345
    //memory[0] = 32'h123452B7;

    //ADDI x6, x5, 5
    //memory[1] = 32'h00528313;

    //AUIPC Test
    //ADDI x1, x0, 5
    //memory[0] = 32'h00500093;

    //AUIPC x5, 0x1
    //memory[1] = 32'h00001297;

    //ADDI x6,x5,5
    //memory[2] = 32'h00528313;
end

assign instruction = memory[pc[31:2]];

endmodule