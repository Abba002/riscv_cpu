---

# Running Individual Modules

## ALU

Compile:

```bash
iverilog -o alu_test rtl/alu.v tb/alu_tb.v
```

Run:

```bash
vvp alu_test
```

---

## Register File

Compile:

```bash
iverilog -o regfile_test rtl/register_file.v tb/register_file_tb.v
```

Run:

```bash
vvp regfile_test
```

---

## Instruction Memory

Compile:

```bash
iverilog -o imem_test rtl/instruction_memory.v tb/instruction_memory_tb.v
```

Run:

```bash
vvp imem_test
```

---
## Program Counter

Compile:

```bash
iverilog -o pc_test rtl/programcounter.v tb/program_counter_tb.v

Run:

vvp pc_test

```bash
## Program Counter
iverilog -o control_test rtl/control_unit.v tb/control_unit_tb.v

Run:
vvp control_test

vvp control_test

# Typical Development Workflow

Whenever implementing a new hardware module, follow this process:

### 1. Open the project

```bash
cd ~/riscv_cpu

code .
```

### 2. Edit RTL

Modify files in:

```text
rtl/
```

### 3. Edit Testbench

Modify files in:

```text
tb/
```

### 4. Compile

Example:

```bash
iverilog -o module_test rtl/module.v tb/module_tb.v
```

### 5. Run Simulation

```bash
vvp module_test
```

### 6. Verify Output

Check the terminal output and confirm the expected behavior.

### 7. Commit Changes

```bash
git add .

git commit -m "Describe the changes"

git push
```

---

# Verilog Naming Conventions

## RTL Modules

```text
rtl/alu.v

rtl/register_file.v

rtl/instruction_memory.v

rtl/programcounter.v

rtl/control_unit.v
```

## Testbenches

```text
tb/alu_tb.v

tb/register_file_tb.v

tb/instruction_memory_tb.v

tb/program_counter_tb.v

tb/control_unit_tb.v
```

Executable simulation names:

```text
alu_test

regfile_test

imem_test

pc_test

control_test
```

---

# Common Verilog Syntax

Continuous assignment:

```verilog
assign output_signal = input_signal;
```

Combinational logic:

```verilog
always @(*) begin

end
```

Sequential logic:

```verilog
always @(posedge clk) begin

end
```

Initialize values:

```verilog
initial begin

end
```

Display values:

```verilog
$display("Value = %d", signal);
```

Display hexadecimal:

```verilog
$display("Instruction = %h", instruction);
```

Delay simulation:

```verilog
#10;
```

Finish simulation:

```verilog
$finish;
```
Concatenation:

```verilog
{signal_a, signal_b}
```

Example R-type instruction construction:

```verilog
instruction = {7'b0000000, 5'd2, 5'd1, 3'b000, 5'd5, 7'b0110011};
```
---

# Useful Terminal Shortcuts

Clear the terminal:

```bash
clear
```

or

```bash
Cmd + K
```

Show previous commands:

```bash
history
```

Search previous commands:

```bash
Ctrl + R
```

Remove a file:

```bash
rm filename
```

Remove a directory:

```bash
rm -r directory_name
```

---

# Simulation Tips

If the design is sequential:

- Generate a clock using `always #5 clk = ~clk;`
- Initialize the clock before simulation:
  ```verilog
  clk = 0;