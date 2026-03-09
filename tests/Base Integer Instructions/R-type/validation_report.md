# RV32I Validation Report

**Description:** This document provides a brief timeline of the verification tests performed and their respective outcomes for the **R-type instruction set**. It tracks the progress of hardware validation within the 5-stage pipeline to ensure architectural correctness.
## Methodology
Verification is performed by comparing the theoretical behavior of an ideal reference model against the actual processor design. 
Beyond verifying the **basic logical operations** of each instruction, these tests focus heavily on **pipeline hazard management** and **data forwarding logic**.
To ensure architectural integrity, the most frequently monitored signals include: **Control signals** from the Control Unit, **Mux Selector signals** from the Forwarding Unit, **Flush/Stall signals** from the Hazard Detection Unit.


## Validation Table 

| Instruction | **ADD** | **SUB** | **XOR** | **OR** | **AND** | **SLL** | **SRL** | **SRA** | **SLT** | **SLTU** |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Status** | ✅ PASS | ✅ PASS | 🟡 PENDING | 🟡 PENDING | ✅ PASS | 🟡 PENDING | 🟡 PENDING | 🟡 PENDING | 🟡 PENDING | 🟡 PENDING |

**Final Tests Status:** 🟡 **PENDING** 