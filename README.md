# Carry Skip Adder (CSKA) with CLA Blocks – Verilog Design

This project implements a **Carry Skip Adder (CSKA)** architecture in Verilog HDL, using **Carry Lookahead Adder (CLA) blocks** for faster carry computation. The design is fully modular and verified through a dedicated testbench. It demonstrates hierarchical design, modular adder composition, and efficient simulation practices.

---

## 📦 Project Structure

| File Name       | Description                                      |
|-----------------|--------------------------------------------------|
| `cla_block.v`   | Parameterized CLA block used as submodule        |
| `cska_top.v`    | Top-level CSKA adder composed of CLA blocks      |
| `tb_cska.v`     | Testbench to validate various input scenarios    |

---

## 🧠 Design Explanation

### 🧮 What is a CSKA?

A **Carry Select Adder** improves delay over ripple-carry adders by precomputing sum values with both carry-in = 0 and carry-in = 1 in parallel blocks. Once the actual carry-in is known, the correct sum is selected.

### ⚙️ Architecture Overview

- The CSKA is split into multiple **CLA blocks** of equal or varying width.
- Each CLA block computes the sum and carry-out in parallel.
- A **multiplexer** is used to select between precomputed sums based on the carry-in from the previous stage.
- This design significantly reduces the critical path delay in wide-bit adders.

### 🧩 Modular Components

- **CLA Block (`cla_block.v`)**:
  - Takes two `WIDTH`-bit inputs and a carry-in.
  - Outputs `WIDTH`-bit sum and carry-out.
  - Propagate signal (`P_block`) for internal carry control.

- **CSKA Top Module (`cska_top.v`)**:
  - Combines multiple CLA blocks to form a complete N-bit adder.
  - Select logic manages carry flow and selection per block.

---

## 🧪 Testbench Overview (`tb_cska.v`)

The testbench simulates various input combinations, edge cases, and verifies:

- Correct sum and carry-out for random and boundary values.
- Propagation of carry between blocks.
- Functionality under various block width configurations.

### 🧰 Features

- Uses `$random`, `$display` for visibility.
- Includes waveform dumping for simulation in GTKWave/EPWave.
- Synchronous and repeatable behavior with multiple test iterations.

---

## ▶️ Simulation Instructions

### On EDA Playground / Local Simulator

1. Paste `cla_block.v`, `cska_top.v`, and `tb_cska.v` in respective tabs/files.
2. Use **Icarus Verilog**, **VCS**, or **ModelSim**.
3. Run simulation to observe correctness and timing.
4. Use `$dumpfile` output in GTKWave for waveform tracing.

### Example CLI Commands (if simulating locally):

```bash
iverilog -o cska_test cla_block.v cska_top.v tb_cska.v
vvp cska_test
gtkwave dump.vcd
