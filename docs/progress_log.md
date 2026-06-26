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
