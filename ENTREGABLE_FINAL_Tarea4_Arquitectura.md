# Task 4 – Simulated Practical Component
## Computer Architecture (Course Code: 202016893)

**Author / Student:** Thomas Fernando Mengual Arciniegas  
**Advisor / Tutor:** Ángel Alberto Varón Quimbayo  
**Institution:** Universidad Nacional Abierta y a Distancia (UNAD)  
**School:** Escuela de Ciencias Básicas, Tecnología e Ingeniería (ECBTI)  
**Program:** Systems Engineering  
**Academic Period:** 2026  

---

### Abstract
To comprehensively address computer architecture, it is essential to establish foundational principles regarding hardware organization, processor internal structures, and the operational flow governing modern and classical computing systems. This academic work presents a unified study combining the theoretical foundations of the Von Neumann model—examining the Control Unit (CU), the Arithmetic Logic Unit (ALU), internal registers, main memory, and the instruction execution cycle (Fetch-Decode-Execute)—with the practical implementation of low-level assembly language programming for x86 architectures. Under the MASM/TASM syntax and simulated through a 16-bit DOSBox environment within Visual Studio Code, three practical software solutions were developed: an 8-bit direct hexadecimal arithmetic calculator with hardware Carry Flag control (ADD/SUB), a bitwise logical mask operator demonstrating ALU gate behavior with 8-bit binary outputs (AND/OR/XOR), and an automatic base-16 counter constructed via conditional branches and register decrements (CMP, JNZ, LOOP). The document includes architectural matrices, comparative evaluations of RISC vs. CISC paradigms, pipelining hazards, multicore scaling, complete commented source codes, execution evidence, and formal APA 7th edition references.

**Keywords:** Computer Architecture, Von Neumann Bottleneck, x86 Assembly, MASM/TASM, CPU Registers, Arithmetic Logic Unit, DOSBox, Interrupt 21H, Carry Flag.

---

### Table Of Contents
1. Introduction
2. Justification
3. Objectives  
    3.1 General Objective  
    3.2 Specific Objectives  
4. Theoretical Framework: Computer Architecture Foundations  
    4.1 The Von Neumann Model and Data Flow  
    4.2 Analysis Matrix of Architecture and Data Flow  
    4.3 The Instruction Cycle: Fetch, Decode, and Execute  
    4.4 The Von Neumann Bottleneck and Modern Mitigations  
    4.5 Architectural Paradigms: RISC vs. CISC  
    4.6 Pipelining and Hazard Management  
    4.7 Parallel and Multicore Architectures  
    4.8 Comparative Synthesis Table  
5. Practical Component: Technical Development and Evidence  
    5.1 Public Repository Access on GitHub  
    5.2 Program 1: Direct Hexadecimal Arithmetic Calculator (`programa1.asm`)  
    5.3 Program 2: Logical Mask Operator – AND / OR / XOR (`programa2.asm`)  
    5.4 Program 3: Automatic Progressive Counter in Base 16 (`programa3.asm`)  
6. Online Video Demonstration Link  
7. Technical Conclusions  
8. Bibliographic References (APA 7th Edition)  

---

### 1. Introduction
The low-level programming paradigm allows software engineers to interact directly with hardware execution units, bypassing the layers of abstraction imposed by modern operating systems, virtual machines, and high-level compilers. In microprocessor engineering, Assembly language functions as the foundational bridge connecting logical intent directly to CPU microarchitectural registers, memory buses, and the Arithmetic Logic Unit (ALU).

This academic report presents the technical development, theoretical backing, and experimental verification of the practical component for the Computer Architecture course at UNAD. The theoretical framework examines the essence of the classic Von Neumann architecture, analyzing the role of the Control Unit in generating timing and control strobes, the mathematical functions of the ALU, the register hierarchy, and system communication buses. Furthermore, it addresses the data flow across the instruction cycle (Fetch-Decode-Execute), analyzes the historic Von Neumann bottleneck, and evaluates performance enhancement strategies including pipelining, RISC versus CISC design philosophies, and multicore parallelism.

Complementing this theoretical core, three practical programs were coded, tested, and validated in assembly language using the Microsoft Macro Assembler (MASM) / Borland Turbo Assembler (TASM) standard within Visual Studio Code, executed via 16-bit DOS emulation. These exercises provide concrete empirical evidence of register allocation (AX, BX, CX, DX), status flag behavior (specifically the Carry Flag CF), bit-level masking, conditional jumping, and DOS software interrupts (INT 21H).

---

### 2. Justification
The drive to understand computer systems stems from humanity's need to master the technological tools that power contemporary civilization. Computing machines—the pinnacle of applied mathematics, electronics, and software engineering—have transitioned from isolated calculating machines into ubiquitous engines driving science, corporate enterprise, and artificial intelligence.

To properly design, optimize, and diagnose modern computational systems, an engineer cannot treat the processor as a black box. Understanding how electrical charge transitions translate into binary data, how instructions are fetched from memory hierarchies, how hardware buses encounter latency bottlenecks, and how assembly instructions manipulate CPU registers in real time constitutes indispensable knowledge for a Systems Engineer. This practical exercise bridges abstract architectural theory with practical, byte-level implementation.

---

### 3. Objectives

#### 3.1 General Objective
To analyze the foundations of computer architecture and hardware organization, evaluating internal processor operations, instruction execution cycles, and scalability strategies, while designing and executing assembly language programs on simulation tools to demonstrate architectural principles in modern and classic processing environments.

#### 3.2 Specific Objectives
- To explain the physical components and functional roles of the classical Von Neumann model (Control Unit, ALU, Register Banks, System Buses, and Main Memory).
- To model the data flow during the Fetch-Decode-Execute instruction cycle, identifying latency factors and structural bottlenecks.
- To compare architectural paradigms—specifically RISC versus CISC, instruction pipelining, and multicore topologies—evaluating their trade-offs in throughput and instruction density.
- To implement a direct 8-bit hexadecimal arithmetic calculator directly over CPU general-purpose registers (AL, BL), evaluating hardware carry and borrow conditions via the Carry Flag (CF).
- To develop a Boolean logic mask operator using AND, OR, and XOR machine instructions, rendering the transformed byte in an 8-bit binary visual stream to observe logic gate operations.
- To design an automated base-16 counter traversing 0h through Fh cleanly using conditional jumps (CMP, JNZ) and register increments without high-level loop abstractions.
- To document all development in a public GitHub repository and present a structured technical video defense demonstrating live program execution and register state transitions.

---

### 4. Theoretical Framework: Architecture and Data Flow Analysis Matrix

| Component | Main Function | Key Characteristics | Interaction with Other Components | Role in Fetch-Decode-Execute Cycle |
|---|---|---|---|---|
| **Control Unit (CU)** | Generates and orchestrates instruction execution; produces control and timing signals. | Decodes opcodes; issues ALU operation signals; coordinates bus access; hardwired or microprogrammed. | Requests memory access; commands register transfers; enables internal and external buses; coordinates ALU. | Directs Fetch, Decode, and Execute phases; synchronizes memory read/write strobes and register latching. |
| **Arithmetic Logic Unit (ALU)** | Executes elementary arithmetic operations and bitwise Boolean logic. | Operates on integer binary data; handles bit shifts; integrates status flags; interfaces with FPU units. | Receives input operands from registers; delivers results back; receives operation signals from the CU. | Serves as the primary operational engine during Execute; sets hardware flags (Zero, Carry, Sign, Overflow). |
| **Registers (CPU Storage)** | Provides ultra-high-speed temporary storage for active data and state. | Includes General-Purpose (AX, BX, CX, DX) and Special-Purpose (PC/IP, IR, SP, FLAGS) registers. | Primary source and destination of ALU operands; PC supplies fetch address; IR holds opcode. | Eliminates memory bus latency; supplies operands in zero wait-states during Decode and Execute. |
| **Main Memory (RAM)** | Stores instructions and variable data in a unified linear address space. | Random access; finite bandwidth and substantial latency compared to CPU clock; organized in cache hierarchies. | Responds to read/write requests from CU; transfers instructions into IR; exchanges data with registers. | Supplies instruction bytes during Fetch; serves as target for operand loads and stores during Execute. |

#### The Von Neumann Bottleneck and Mitigations
The Von Neumann bottleneck refers to the shared single bus between CPU and memory for instructions and data. Mitigations include:
1. **Memory Hierarchy & Caches (L1, L2, L3):** Minimizes memory bus latency.
2. **Prefetching & Buffers:** Anticipates incoming instructions.
3. **Wider Buses & High-speed Interfaces:** Increases data throughput.
4. **Modified Harvard Architecture:** Splits instruction and data caches.
5. **Pipelining (Fetch, Decode, Execute, Memory, Write-Back):** Overlaps stages to maximize throughput.
6. **Parallel and Multicore Architectures:** Implements ILP, TLP, and DLP with hardware cache coherence (MESI/MOESI).

---

### 5. Practical Component: Technical Development and Evidence

#### 5.1 Public Repository Access on GitHub
- **URL:** [https://github.com/srchimbichumboss/Arquitectura-Computadores-Tarea4](https://github.com/srchimbichumboss/Arquitectura-Computadores-Tarea4)
- **Author:** Thomas Fernando Mengual Arciniegas (`srchimbichumboss`)
- **Environment:** MASM / TASM 16-bit Real Mode via DOSBox under VS Code

#### 5.2 Program 1: Direct Hexadecimal Arithmetic Calculator (`programa1.asm`)
Demonstrates direct 8-bit arithmetic execution in CPU registers (AL, BL) with hardware Carry Flag (CF) control.

**Verification Matrix:**
| Test Scenario | Operand 1 | Operator | Operand 2 | Expected Math Result | Expected Carry/Borrow Flag | Console Output |
|---|---|---|---|---|---|---|
| Addition (No Carry) | 3A | + | 1F | 59h | Carry = 0 | 59h (Carry = 0) |
| Addition (With Carry) | FF | + | 01 | 00h (Overflow) | Carry = 1 | 00h (Carry = 1) |
| Subtraction (No Borrow) | 80 | - | 30 | 50h | Borrow = 0 | 50h (Borrow = 0) |
| Subtraction (With Borrow) | 10 | - | 20 | F0h (Negative wrap) | Borrow = 1 | F0h (Borrow = 1) |

#### 5.3 Program 2: Logical Mask Operator (`programa2.asm`)
Demonstrates bitwise operations (AND, OR, XOR) inside the ALU with full 8-bit binary output streaming.

**Verification Matrix:**
| Test Vector | Input Data (Hex) | Selected Gate | Mask (Hex) | Data in Binary | Mask in Binary | Computed Binary Output | Computed Hex Output |
|---|---|---|---|---|---|---|---|
| Bit Clearing | B5h | 1 (AND) | 0Fh | 10110101b | 00001111b | 00000101b | 05h |
| Bit Setting | A0h | 2 (OR) | 0Fh | 10100000b | 00001111b | 10101111b | AFh |
| Bit Inversion | FFh | 3 (XOR) | AAh | 11111111b | 10101010b | 01010101b | 55h |

#### 5.4 Program 3: Automatic Progressive Counter in Base 16 (`programa3.asm`)
Demonstrates iteration, flag evaluation, and conditional branching (`CMP`, `JNZ`, `INC`, `DEC`) traversing 0h through Fh without user intervention.

---

### 6. Online Video Demonstration Link
- **Direct Video URL (Sustentación):** [https://canva.link/tjoiogn9x39q4w7](https://canva.link/tjoiogn9x39q4w7)

---

### 7. Technical Conclusions
1. The Von Neumann architecture remains the universal foundation of modern computing.
2. Direct register operations minimize memory bus latency.
3. Hardware status flags enable multi-precision arithmetic and flow control.
4. Bitwise Boolean instructions mirror physical logic gate primitives.
5. Software interrupts (INT 21H) provide standardized interfaces to operating system services.

---

### 8. Bibliographic References (APA 7th Edition)
- Blanco Martín, J. (2013). *Manual administración de hardware de un sistema informático*. Editorial CEP.
- Flynn, M. J. (1972). Some computer organizations and their effectiveness. *IEEE Transactions on Computers*, C-21(9), 948–960.
- Hennessy, J. L., & Patterson, D. A. (2017). *Computer Architecture: A Quantitative Approach* (6th ed.). Morgan Kaufmann.
- Noguera Torres, A. del P., & Caro Martínez, C. A. (2022). Diseño de un sistema inteligente de bajo costo. *Documentos de Trabajo ECBTI*, 3(2).
- Patterson, D. A., & Hennessy, J. L. (2014). *Computer Organization and Design: The Hardware/Software Interface*. Morgan Kaufmann.
- Smith, J. E. (1981). A study of branch prediction strategies. *ISCA*, 135–148.
- Stallings, W. (2018). *Computer Organization and Architecture* (11th ed.). Pearson.
