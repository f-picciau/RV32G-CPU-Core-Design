# RV32I Validation Report

**Description:** This document provides a brief timeline of the verification tests performed and their respective outcomes for the **R-type instruction set**. It tracks the progress of hardware validation within the 5-stage pipeline to ensure architectural correctness.
## Methodology
Verification is performed by comparing the theoretical behavior of an ideal reference model against the actual processor design. 
Beyond verifying the **basic logical operations** of each instruction, these tests focus heavily on **pipeline hazard management** and **data forwarding logic**.
To ensure architectural integrity, the most frequently monitored signals include: **Control signals** from the Control Unit, **Mux Selector signals** from the Forwarding Unit, **Flush/Stall signals** from the Hazard Detection Unit.


## Validation Table 

| Instruction | **ADD** | **SUB** | **XOR** | **OR** | **AND** | **SLL** | **SRL** | **SRA** | **SLT** | **SLTU** |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Status** | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS |


## Tests on Forwarding Unit

| Instructions | Comments |
| :--- | :---: | 
| @00000000 | - |
| 80000093 | addi x1, x0, -2048   (x1 = -2048) |
| 7ff00113 | addi x2, x0, 2047    (x2 = 2047) |
| 002081b3 | add  x3, x1, x2      (x3 = -1) |
| 40118233 | sub  x4, x3, x1      (x4 = 2047) |
| 0041f2b3 | and  x5, x3, x4      (x5 = 2047) |
| 0012e333 | or   x6, x5, x1      (x6 = -1)  |
| 006243b3 | xor  x7, x4, x6      (x7 = -2048) |
| 00500213 | addi x4, x0, 5     (x4 = 5) |
| 00409433 | sll  x8, x1, x4    (x8 = -2048 << 5 = -65536) |
| 01f00213 | addi x4, x0, 31    (x4 = 31) |
| 004454b3 | srl  x9, x8, x4    (x9 = 0xFFFF0000 >> 31 = 1) |
| 4043d533 | sra  x10, x7, x4   (x10 = -2048 >>> 31 = -1) |
| 00a3a5b3 | slt  x11, x7, x10  (x11 = -2048 < -1 = 1) |
| 00753633 | sltu x12, x10, x7  (x12 = -1 < -2048 unsigned = 0) |

Completed successfully a stress test for every RV32I Instruction and for Forwarding logic.                 

**Tests Status:** ✅ **PASSED** 
