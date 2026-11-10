# Project Report: Design and Implementation of a 32-Bit ALU Using Verilog HDL

## 1. Aim
To design, implement, and verify a 32-bit combinational Arithmetic Logic Unit (ALU) using Verilog HDL.

## 2. Objectives
- Implement arithmetic and bitwise operations on 32-bit operands.
- Implement logical and arithmetic shift operations.
- Generate zero, carry, overflow, and negative status flags.
- Verify operation results with a self-checking testbench and benchmark vectors.

## 3. Architecture and block explanation
The complete conceptual block diagram is provided in `../docs/block_diagram.svg`.
- **Operand inputs:** supply 32-bit values A and B.
- **Opcode/control input:** `alu_sel[3:0]` selects the required operation.
- **Arithmetic unit:** performs addition and subtraction and derives carry/overflow.
- **Logic unit:** performs AND, OR, XOR, and NOT.
- **Shifter:** performs left, logical-right, and arithmetic-right shifts using B[4:0].
- **Comparator:** performs signed less-than comparison.
- **Result selection:** routes the selected operation to the 32-bit result.
- **Flag logic:** derives zero and negative from result and carry/overflow for arithmetic.

## 4. Important code sections
- `case (alu_sel)`: operation decoder and result selection.
- `ext={1'b0,a}+{1'b0,b}`: 33-bit intermediate addition preserves carry-out.
- `ext={1'b0,a}+{1'b0,~b}+33'd1`: subtraction using two's complement.
- Signed overflow equations detect signed overflow.
- `$signed(a) >>> b[4:0]`: arithmetic right shift preserves sign.
- `assign zero` and `assign negative`: generate status flags.

## 5. Verification and benchmark tests
The testbench checks arithmetic, logic, shifts, signed comparisons, invalid opcode behavior, and selected flags.

| Operation | A | B | Expected result |
|---|---:|---:|---:|
| ADD | 10 | 5 | 15 |
| SUB | 20 | 7 | 13 |
| AND | A5A5F0F0 | 0F0FFF00 | 0505F000 |
| OR | A5A5F0F0 | 0F0FFF00 | AFAFFFF0 |
| XOR | A5A5F0F0 | 0F0FFF00 | AAAA0FF0 |
| SLL | 00000001 | 4 | 00000010 |
| SRL | 80000000 | 4 | 08000000 |
| SRA | 80000000 | 4 | F8000000 |
| SLT signed | FFFFFFFF | 00000001 | 00000001 |

Run `make test`. The testbench prints PASS/FAIL and exits nonzero if a check fails.

## 6. Applications
ALUs are fundamental datapath components in CPUs and microcontrollers. They support instruction execution, address/index calculations, bit manipulation, branch comparisons, and embedded digital systems. This project is an educational standalone combinational ALU, not a complete processor.

## 7. Short survey and comparison
A ripple-carry ALU shares a compact adder structure but carry delay grows with operand width. Carry-lookahead, carry-select, and parallel-prefix adders can reduce carry delay at the cost of extra area and wiring. Processor ALUs may add multiply/divide, rotates, additional condition codes, and pipeline integration. This project prioritizes clarity and straightforward functional simulation rather than maximum frequency. The actual mapped adder architecture depends on the synthesis tool and target device.

## 8. Conclusion
A 32-bit combinational ALU was implemented in Verilog with ten operations and four status outputs. A self-checking testbench provides reproducible functional verification. Future extensions include parameterization, additional operations, constrained-random testing, and synthesis/timing comparison.

## 9. Student details
- **Student 1:** Abbas
- **Student 2:** Muhammad Rizvi
- **Course:** Advanced Computer Architecture
- **Department:** Electronics and Communication
- **Institute:** National Institute of Technology SGR
- **Submission deadline:** 11 November 2026
