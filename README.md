# 32-Bit Arithmetic Logic Unit (ALU) Using Verilog HDL

A synthesizable combinational 32-bit ALU implemented in Verilog-2001, with a self-checking testbench, architecture diagram, project report, and automated simulation workflow.

## Project team
- **Student 1:** Abbas
- **Student 2:** Muhammad Rizvi
- **Department:** Electronics and Communication
- **Institute:** National Institute of Technology SGR
- **Course:** Advanced Computer Architecture

## Repository structure
```text
32-bit-ALU-using-verilog/
├── .github/workflows/iverilog.yml
├── docs/block_diagram.svg
├── report/project_report.md
├── rtl/alu_32bit.v
├── tb/tb_alu_32bit.v
├── sim/simulation_output.txt
├── scripts/README.md
├── .gitignore
├── Makefile
├── PROJECT_INFO.md
├── run_sim.bat
└── run_sim.sh
```

## Supported operations
| Opcode | Operation | Description |
|---|---|---|
| 0000 | ADD | A + B |
| 0001 | SUB | A - B |
| 0010 | AND | Bitwise AND |
| 0011 | OR | Bitwise OR |
| 0100 | XOR | Bitwise XOR |
| 0101 | NOT | Bitwise NOT of A |
| 0110 | SLL | Logical left shift |
| 0111 | SRL | Logical right shift |
| 1000 | SRA | Arithmetic right shift |
| 1001 | SLT | Signed less-than |

Status outputs: zero, carry, overflow, and negative.

## Run simulation
Install Icarus Verilog, then execute:
```bash
make test
```
On Windows run `run_sim.bat`; on Linux/macOS run `sh run_sim.sh`.

The testbench prints PASS/FAIL checks and exits with a failure status if a check fails. The current `sim/simulation_output.txt` is a placeholder, not a claimed passing log.

## Automated verification
GitHub Actions in `.github/workflows/iverilog.yml` installs Icarus Verilog, compiles the RTL and testbench, and runs the simulation on pushes and pull requests. Check the **Actions** tab for the actual result.

## Documentation
- [Project information](PROJECT_INFO.md)
- [Project report](report/project_report.md)
- [Block diagram](docs/block_diagram.svg)

## References
1. IEEE Std 1364-2005, *IEEE Standard for Verilog Hardware Description Language*.
2. Icarus Verilog documentation: https://steveicarus.github.io/iverilog/
3. AMD Vivado Synthesis User Guide: https://docs.amd.com/r/en-US/ug901-vivado-synthesis
