# RISC-V Processor Project

# Setup and Command Reference

## Environment Information

Machine:

* 2020 Intel MacBook Pro
* macOS 15.7.4

Tools:

* Homebrew
* VS Code
* Git
* GitHub
* Icarus Verilog

---

# Homebrew Installation

Install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Add Homebrew to PATH:

```bash
echo >> ~/.zprofile

echo 'eval "$(/usr/local/bin/brew shellenv zsh)"' >> ~/.zprofile

eval "$(/usr/local/bin/brew shellenv zsh)"
```

Verify:

```bash
brew --version
```

---

# Tool Installation

Install Icarus Verilog:

```bash
brew install icarus-verilog
```

Install Git:

```bash
brew install git
```

Install GitHub CLI:

```bash
brew install gh
```

Verify installations:

```bash
iverilog -V

git --version

gh --version
```

---

# VS Code

Open current folder in VS Code:

```bash
code .
```

Open a specific file:

```bash
code filename.v
```

---

# Project Creation

Create project directory:

```bash
mkdir riscv_cpu

cd riscv_cpu
```

Create folders:

```bash
mkdir rtl

mkdir tb

mkdir docs
```

Create files:

```bash
touch README.md

touch .gitignore

touch rtl/alu.v

touch tb/alu_tb.v
```

---

# Git Commands

Initialize repository:

```bash
git init
```

Check status:

```bash
git status
```

Add files:

```bash
git add .
```

Commit changes:

```bash
git commit -m "commit message"
```

View commit history:

```bash
git log
```

Push to GitHub:

```bash
git push
```

---

# Useful GitHub Commands

Login:

```bash
gh auth login
```

Check remote:

```bash
git remote -v
```

Change remote URL:

```bash
git remote set-url origin https://github.com/USERNAME/REPO.git
```

---

# Navigation Commands

Current directory:

```bash
pwd
```

List files:

```bash
ls
```

List files in a folder:

```bash
ls rtl

ls tb
```

Move into a folder:

```bash
cd folder_name
```

Move up one level:

```bash
cd ..
```

---

# Verilog Compilation

Compile ALU and testbench:

```bash
iverilog -o alu_test rtl/alu.v tb/alu_tb.v
```

Explanation:

* iverilog = Verilog compiler
* -o alu_test = output executable
* rtl/alu.v = design file
* tb/alu_tb.v = testbench

---

# Simulation

Run simulation:

```bash
vvp alu_test
```

Expected output:

```text
ADD: 10 + 5 = 15
SUB: 10 - 5 = 5
```

---

# Common Debug Commands

Display file contents:

```bash
cat filename
```

Show line numbers:

```bash
nl -ba filename
```

Check Icarus Verilog installation:

```bash
iverilog -V
```

Check current directory:

```bash
pwd
```

Check project structure:

```bash
ls

ls rtl

ls tb
```
