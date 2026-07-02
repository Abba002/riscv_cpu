### ALU Implementation

Implemented a 32-bit Arithmetic Logic Unit (ALU) in Verilog.

Supported operations:

* ADD
* SUB
* AND
* OR
* XOR

### Verification

Created a Verilog testbench and verified all five operations using Icarus Verilog simulation.

Example results:

* 10 + 5 = 15
* 10 - 5 = 5
* 10 AND 5 = 0
* 10 OR 5 = 15
* 10 XOR 5 = 15

### Lessons Learned

* Verilog module structure
* Combinational logic using always @(*)
* Testbench creation
* Simulation workflow using Icarus Verilog
# Progress Log

---

## Objectives

* Set up the development environment
* Build and verify a 32-bit Arithmetic Logic Unit (ALU)
* Learn the basics of Verilog simulation and testbenches

---

## Environment Setup

Installed and configured:

* Homebrew
* Visual Studio Code
* Icarus Verilog
* Git
* GitHub
* GitHub CLI

Created the initial project structure:

```text
riscv_cpu/
│
├── rtl/
├── tb/
├── docs/
├── README.md
└── .gitignore
```

---

## ALU Implementation

Implemented a 32-bit Arithmetic Logic Unit (ALU) in Verilog.

### Supported Operations

* ADD
* SUB
* AND
* OR
* XOR

The ALU was implemented as a combinational circuit using an `always @(*)` block and a `case` statement to select the desired arithmetic or logic operation.

---

## ALU Verification

Created a Verilog testbench to verify each supported ALU operation.

Example simulation results:

* 10 + 5 = 15
* 10 - 5 = 5
* 10 AND 5 = 0
* 10 OR 5 = 15
* 10 XOR 5 = 15

Successfully compiled and simulated using:

* Icarus Verilog (`iverilog`)
* Verilog Virtual Processor (`vvp`)

---

## Register File

Designed and implemented a 32-register, 32-bit Register File.

Features:

* Two simultaneous read ports
* One write port
* Synchronous write using the positive clock edge
* Register x0 is hardwired to zero and cannot be modified

Created and verified a dedicated testbench to confirm successful register writes and reads.

---

## Instruction Memory

Designed a simple read-only Instruction Memory.

Features:

* 256 instruction locations
* 32-bit instruction width
* Combinational instruction fetch
* Address indexing using `pc[31:2]` to account for 4-byte instruction alignment

Initialized memory with placeholder instructions for early verification:

* `32'hAAAAAAAA`
* `32'hBBBBBBBB`
* `32'hCCCCCCCC`

Test cases:

- PC = 0 returned `32'hAAAAAAAA`
- PC = 4 returned `32'hBBBBBBBB`
- PC = 8 returned `32'hCCCCCCCC`

---

## Concepts Learned
- Instruction memory is combinational.
- The PC is a byte address.
- Since each instruction is 4 bytes, `pc[31:2]` selects the instruction index.
- Misaligned PC values such as 1, 2, or 7 still map to an index because the lower two bits are ignored.

### Verilog

* Module declaration
* Inputs and outputs
* Registers vs. wires
* Arrays (memory declarations)
* Continuous assignments (`assign`)
* Combinational logic (`always @(*)`)
* Sequential logic (`always @(posedge clk)`)
* Initial blocks
* Hexadecimal literals

### Verification

* Testbench structure
* Clock generation
* Simulation timing (`#`)
* `$display`
* Device Under Test (DUT)

### Computer Architecture

* Responsibilities of an ALU
* Purpose of the Register File
* Instruction Memory organization
* Program Counter fundamentals
* Word-aligned instruction addressing
* Difference between byte addresses and instruction indices

---

## Lessons Learned

One of the biggest takeaways from today's work was learning the difference between combinational and sequential logic.

The ALU responds immediately whenever its inputs change, making it a combinational circuit. In contrast, the Register File stores information and only updates on a positive clock edge, making it a sequential circuit.

Another important concept was understanding that the Program Counter does not store instructions—it simply provides the address of the next instruction. The Instruction Memory's sole responsibility is to return the instruction stored at the address specified by the Program Counter.

These concepts form the foundation for building the remainder of the processor.

# Control Unit

## Objectives

- Implement the first version of the Control Unit
- Decode R-type RISC-V instructions
- Generate control signals for the Register File and ALU

---

## Control Unit Implementation

Implemented a combinational Control Unit that receives a 32-bit RISC-V instruction and extracts the following fields:

- `opcode = instruction[6:0]`
- `funct3 = instruction[14:12]`
- `funct7 = instruction[31:25]`

The Control Unit currently supports R-type arithmetic instructions.

### Supported Instructions

- ADD
- SUB
- AND
- OR
- XOR

### Generated Control Signals

- `reg_write`
- `alu_control`

For supported R-type instructions:

- `reg_write = 1`
- `alu_control` selects the ALU operation

Unsupported instructions keep the default control values:

- `reg_write = 0`
- `alu_control = 000`

---

## Control Unit Verification

Created a dedicated testbench for the Control Unit.

The testbench builds R-type instructions using concatenation:

```verilog
{funct7, rs2, rs1, funct3, rd, opcode}

Verified that each supported R-type instruction produces the expected control outputs.

Instruction	Expected reg_write	Expected alu_control
ADD	1	000
SUB	1	001
AND	1	010
OR	1	011
XOR	1	100

## Concepts Learned

RISC-V R-type instruction format
Opcode extraction
funct3 and funct7 decoding
Control signals vs. data signals
Verilog concatenation using {}
Default assignments in combinational logic
Avoiding inferred latches
Using case statements for instruction decoding

## Lessons Learned

The Control Unit does not perform arithmetic or move data itself. Instead, it generates control signals that tell other hardware blocks what to do.

The destination and source registers are part of the instruction data fields, while signals like reg_write and alu_control are control signals generated by the Control Unit.

This module introduced the separation between datapath and control logic, which is a major concept in CPU design.

---

# Data Memory

## Objectives

- Implement the processor Data Memory
- Support 32-bit memory reads and writes
- Verify memory storage across multiple addresses

---

## Data Memory Implementation

Implemented a 256-word Data Memory module.

Features:

- 32-bit data width
- 256 memory locations
- Combinational read path
- Sequential write path
- Write enable controlled by `mem_write`
- Byte address to word index conversion using `address[31:2]`

---

## Data Memory Verification

Created a dedicated Data Memory testbench.

Verified:

- Writing `25` to address `0`
- Reading back `25` from address `0`
- Writing `99` to address `4`
- Reading back `99` from address `4`
- Confirming address `0` still contains `25` after writing to address `4`

---

## Concepts Learned

- Difference between read and write memory behavior
- Combinational reads vs. sequential writes
- Memory write enable signals
- Byte addressing vs. word indexing
- Preventing accidental writes by deasserting `mem_write`

---

# Top-Level CPU Integration

## Objectives

- Integrate the major processor modules into a single top-level CPU
- Connect instruction fetch, decode, register read, ALU execution, and write-back
- Verify execution of R-type RISC-V instructions

---

## CPU Integration

Implemented the top-level `riscv_cpu` module.

Integrated modules:

- Program Counter
- Instruction Memory
- Control Unit
- Register File
- ALU

The current CPU supports execution of R-type arithmetic/logic instructions.

### Supported Instruction Flow

1. Program Counter outputs the current instruction address
2. Instruction Memory returns the instruction
3. Control Unit decodes the instruction
4. Register File reads source operands
5. ALU executes the operation
6. ALU result is written back to the destination register

---

## CPU Verification

Created `riscv_cpu_tb.v` to verify integrated datapath behavior.

Test program:

```assembly
ADD x5, x1, x2
SUB x6, x5, x3
AND x7, x6, x4

Simulation verified:

ADD: 10 + 5 = 15
SUB: 15 - 20 = -5
AND: -5 & 3 = 3

This confirmed:

Instruction fetch works
Instruction decode works
Register reads work
ALU execution works
Register write-back works
Data dependencies between instructions work correctly
Concepts Learned
Top-level CPU integration
Datapath wiring
Debug signal exposure
Instruction execution flow
Register write-back
Data dependencies
Integration testing
