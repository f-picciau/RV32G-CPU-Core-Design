# RV32I Validation Report

**Description:** This document provides a brief timeline of the verification tests performed and their respective outcomes for the **I-type instruction set**. It tracks the progress of hardware validation within the 5-stage pipeline to ensure architectural correctness.
## Methodology
Verification is performed by comparing the theoretical behavior of an ideal reference model against the actual processor design. 
Beyond verifying the **basic logical operations** of each instruction, these tests focus heavily on **pipeline hazard management** and **data forwarding logic**.
To ensure architectural integrity, the most frequently monitored signals include: **Control signals** from the Control Unit, **Mux Selector signals** from the Forwarding Unit, **Flush/Stall signals** from the Hazard Detection Unit.


## Validation Table 

| Instruction | **ADDI** | **ANDI** | **JALR** | **LB** | **LBU** | **LH** | **LHU** | **LW** | **ORI** | **SLLI** | **SLTI** | **SLTIU** | **SRAI** | **SRLI** | **XORI** |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Status** | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS | ✅ PASS |


## Problems solved
### 1. Load Instruction Resolution
The issue was traced to the incorrect propagation of control signals in the later stages of the pipeline.

Correction: The funct3 signals were correctly rewired within the EX/MEM register.

Result: This ensures that the Memory stage correctly identifies the specific load type (e.g., lw, lh, lb) and accurately processes the data coming from the Data Memory before passing it to the Write-Back stage.

### 2. JALR Instruction Resolution
**PC Propagation**: The PC is now passed through the ID/EX register to the Execute stage. This enables the hardware to calculate the return address (PC + 4) in the Execute stage, which is then routed through the pipeline for eventual write-back into the register file.

**Adder Management**: The logic for the Adder in the Instruction Decode stage was rewritten. This Adder is now correctly shared between Branch and Jump instructions, ensuring the target address is calculated without resource conflicts.

**Integrated Control and Hazard Management**: The Control Unit, Forwarding Unit, and Hazard Detection Unit were modified to incorporate a dedicated jump signal. This enables the processor to resolve forwarding dependencies for registers still traversing the pipeline and ensures robust hazard management.















The tests exposed two major problems involving the load instruction and the jump and link register instruction.
The load instruction has been solved by rewiring correctly the funct3 signals in the EX/MEM register.
The jalr instruction has been solved by rewriting the logic for the jump instructions, modifying multiple modules like: Control Unit, Forwarding Unit, Hazard Detection Unit, Instruction Decode, Execute Stage and ID/EX Register. The signals modified include the PC passed to the Execute Stage to calculate PC + 4 to enable the write back in the registers and the jump signal added, which enables a better management of the Adder shared by branch and jump in the decode and of various modules that enable to rewrite the Program Counter.



## Additional tests
Additional deep tests on jalr has been made.               

**Tests Status:** ✅ **PASSED** 
