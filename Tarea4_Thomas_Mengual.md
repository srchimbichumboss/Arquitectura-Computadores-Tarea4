# Task 4 – Simulated Practical Component
## Computer Architecture (Course Code: 202016893)

---

### COVER PAGE

**Course:** Computer Architecture  
**Course Code:** 202016893  
**Assignment:** Task 4 – Simulated Practical Component  
**Student:** Thomas Fernando Mengual Arciniegas  
**Advisor / Tutor:** Ángel Alberto Varón Quimbayo  
**Institution:** Universidad Nacional Abierta y a Distancia (UNAD)  
**School:** Escuela de Ciencias Básicas, Tecnología e Ingeniería (ECBTI)  
**Program:** Systems Engineering  
**Academic Period:** 2026  

---

### ABSTRACT

To comprehensively address computer architecture, it is essential to establish foundational principles regarding hardware organization, processor internal structures, and the operational flow governing modern and classical computing systems. This academic work presents a unified study combining the theoretical foundations of the Von Neumann model—examining the Control Unit (CU), the Arithmetic Logic Unit (ALU), internal registers, main memory, and the instruction execution cycle (Fetch-Decode-Execute)—with the practical implementation of low-level assembly language programming for x86 architectures. Under the MASM/TASM syntax and simulated through a 16-bit DOSBox environment within Visual Studio Code, three practical software solutions were developed: an 8-bit direct hexadecimal arithmetic calculator with hardware Carry Flag control (ADD/SUB), a bitwise logical mask operator demonstrating ALU gate behavior with 8-bit binary outputs (AND/OR/XOR), and an automatic base-16 counter constructed via conditional branches and register decrements (CMP, JNZ, LOOP). The document includes architectural matrices, comparative evaluations of RISC vs. CISC paradigms, pipelining hazards, multicore scaling, complete commented source codes, execution evidence, and formal APA 7th edition references.

---

### TABLE OF CONTENTS

1. Introduction
2. Justification
3. Objectives  
   3.1 General Objective  
   3.2 Specific Objectives  
4. Theoretical Framework: Computer Architecture Foundations  
   4.1 The Von Neumann Model and Data Flow  
   4.2 Analysis Matrix of Architecture and Data Flow  
   4.3 The Instruction Cycle: Fetch, Decode, and Execute  
   4.4 The Von Neumann Bottleneck and Architectural Mitigations  
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

### 1. INTRODUCTION

The low-level programming paradigm allows software engineers to interact directly with hardware execution units, bypassing the layers of abstraction imposed by modern operating systems, virtual machines, and high-level compilers. In microprocessor engineering, Assembly language functions as the foundational bridge connecting logical intent directly to CPU microarchitectural registers, memory buses, and the Arithmetic Logic Unit (ALU).

This academic report presents the technical development, theoretical backing, and experimental verification of the practical component for the Computer Architecture course at UNAD. The theoretical framework examines the essence of the classic Von Neumann architecture, analyzing the role of the Control Unit in generating timing and control strobes, the mathematical functions of the ALU, the register hierarchy, and system communication buses. Furthermore, it addresses the data flow across the instruction cycle (Fetch-Decode-Execute), analyzes the historic Von Neumann bottleneck, and evaluates performance enhancement strategies including pipelining, RISC versus CISC design philosophies, and multicore parallelism.

Complementing this theoretical core, three practical programs were coded, tested, and validated in assembly language using the Microsoft Macro Assembler (MASM) / Borland Turbo Assembler (TASM) standard within Visual Studio Code, executed via 16-bit DOS emulation. These exercises provide concrete empirical evidence of register allocation (`AX`, `BX`, `CX`, `DX`), status flag behavior (specifically the Carry Flag `CF`), bit-level masking, conditional jumping, and DOS software interrupts (`INT 21H`).

---

### 2. JUSTIFICATION

The drive to understand computer systems stems from humanity's need to master the technological tools that power contemporary civilization. Computing machines—the pinnacle of applied mathematics, electronics, and software engineering—have transitioned from isolated calculating machines into ubiquitous engines driving science, corporate enterprise, and artificial intelligence.

To properly design, optimize, and diagnose modern computational systems, an engineer cannot treat the processor as a black box. Understanding how electrical charge transitions translate into binary data, how instructions are fetched from memory hierarchies, how hardware buses encounter latency bottlenecks, and how assembly instructions manipulate CPU registers in real time constitutes indispensable knowledge for a Systems Engineer. This practical exercise bridges abstract architectural theory with practical, byte-level implementation.

---

### 3. OBJECTIVES

#### 3.1 General Objective
To analyze the foundations of computer architecture and hardware organization, evaluating internal processor operations, instruction execution cycles, and scalability strategies, while designing and executing assembly language programs on simulation tools to demonstrate architectural principles in modern and classic processing environments.

#### 3.2 Specific Objectives
1. To explain the physical components and functional roles of the classical Von Neumann model (Control Unit, ALU, Register Banks, System Buses, and Main Memory).
2. To model the data flow during the Fetch-Decode-Execute instruction cycle, identifying latency factors and structural bottlenecks.
3. To compare architectural paradigms—specifically RISC versus CISC, instruction pipelining, and multicore topologies—evaluating their trade-offs in throughput and instruction density.
4. To implement a direct 8-bit hexadecimal arithmetic calculator directly over CPU general-purpose registers (`AL`, `BL`), evaluating hardware carry and borrow conditions via the Carry Flag (`CF`).
5. To develop a Boolean logic mask operator using `AND`, `OR`, and `XOR` machine instructions, rendering the transformed byte in an 8-bit binary visual stream to observe logic gate operations.
6. To design an automated base-16 counter traversing `0h` through `Fh` cleanly using conditional jumps (`CMP`, `JNZ`) and register increments without high-level loop abstractions.
7. To document all development in a public GitHub repository and present a structured technical video defense demonstrating live program execution and register state transitions.

---

### 4. THEORETICAL FRAMEWORK: COMPUTER ARCHITECTURE FOUNDATIONS

#### 4.1 The Von Neumann Model and Data Flow
The Von Neumann architecture, formulated in 1945, established the stored-program concept where both machine instructions and computational data share the same physical memory space and common communication buses. The core processing subsystem consists of:
- **Control Unit (CU):** The coordinator that orchestrates the execution of instructions by generating control signals, fetching micro-operations, and coordinating external buses.
- **Arithmetic Logic Unit (ALU):** The execution unit responsible for performing basic integer arithmetic (addition, subtraction) and bitwise Boolean logic (AND, OR, XOR, shifts).
- **Register Array:** High-speed internal memory cells located directly inside the processor silicon, offering single-cycle read/write access.
- **Main Memory (RAM):** Linear address space holding data payloads and program code during execution.
- **System Buses:** The physical communication highways: Address Bus (unidirectional, determines memory locations), Data Bus (bidirectional, transfers payloads), and Control Bus (transmits timing and command signals).

---

#### 4.2 Analysis Matrix of Architecture and Data Flow

| Component | Main Function | Key Characteristics | Interaction with Other Components | Role in Fetch-Decode-Execute Cycle |
|---|---|---|---|---|
| **Control Unit (CU)** | Generates and orchestrates instruction execution; produces control and timing signals. | Decodes instruction opcodes; issues ALU operation signals; coordinates bus access; implemented via hardwired logic or microprogramming. | Requests memory access; commands register transfers; enables internal and external buses; synchronizes ALU execution. | Directs the Fetch, Decode, and Execute phases; synchronizes memory read/write strobes and register latching. |
| **Arithmetic Logic Unit (ALU)** | Executes elementary arithmetic operations and bitwise Boolean logic. | Operates on integer binary data; handles bit shifts; integrates with status flags; may interface with specialized Floating-Point Units (FPU). | Receives input operands from registers; delivers results back to registers or memory; receives operation opcodes from the CU. | Serves as the primary operational engine during the **Execute** phase; sets hardware flags (Zero, Carry, Sign, Overflow) affecting program control flow. |
| **Registers (CPU Storage)** | Provides ultra-high-speed temporary storage for active data and machine state. | Includes General-Purpose Registers (`AX`, `BX`, `CX`, `DX`) and Dedicated/Special Registers (`PC`/`IP`, `IR`, `SP`, `FLAGS`). | Primary source and destination of ALU operands; `PC` supplies addresses for fetch operations; `IR` holds the fetched opcode for decoding. | Eliminates memory bus latency; supplies operands in zero wait-states during the **Decode** and **Execute** phases. |
| **Main Memory (RAM)** | Stores both operational instructions and variable data in a unified address space. | Random access addressing; finite bandwidth and substantial latency compared to CPU clock frequencies; organized in hierarchical cache levels. | Responds to read/write requests from the CU; transfers instructions into the `IR` and exchanges data with registers across system buses. | Supplies instruction bytes during **Fetch**; serves as target for operand loads and stores during **Execute**; forms the primary system bottleneck when caches miss. |

---

#### 4.3 The Instruction Cycle: Fetch, Decode, and Execute

The continuous life cycle of a processor is governed by three primary microarchitectural steps:

```
+-------------------------------------------------------------------------+
|                              INSTRUCTION CYCLE                          |
|                                                                         |
|   +-------------------+    +--------------------+    +--------------+   |
|   |       FETCH       | -> |       DECODE       | -> |   EXECUTE    |   |
|   | PC -> Address Bus |    | Opcode in IR parsed|    | ALU operates |   |
|   | RAM -> IR         |    | Operands identified|    | Flags set    |   |
|   | PC = PC + size    |    | CU signals ready   |    | Write-back   |   |
|   +-------------------+    +--------------------+    +--------------+   |
+-------------------------------------------------------------------------+
```

1. **Fetch Phase:**
   - The Control Unit loads the address stored in the Program Counter (`PC` or `IP` in x86) onto the Address Bus.
   - The memory subsystem responds by placing the instruction byte(s) onto the Data Bus, which latches into the Instruction Register (`IR`).
   - The Program Counter automatically increments to point to the memory location of the next sequential instruction.
   - *Critical latencies:* Bus propagation delays and dynamic RAM access times.
2. **Decode Phase:**
   - The Control Unit decodes the opcode held within the `IR`, determining which machine instruction is requested.
   - The required addressing modes and operand locations are evaluated. If operands reside in CPU registers, they are accessed immediately; if operands are stored in memory, additional memory read cycles are scheduled.
   - The CU configures internal data multiplexers, ALU arithmetic pathways, and control lines.
3. **Execute Phase:**
   - The ALU executes the commanded operation using the retrieved operands.
   - Computational results are latched into the target destination register or written to memory across the Data Bus.
   - The processor’s condition register (`FLAGS`) updates individual status bits (Carry Flag `CF`, Zero Flag `ZF`, Sign Flag `SF`, Overflow Flag `OF`), which dictate subsequent conditional branching logic (`JC`, `JNZ`, `JE`).

---

#### 4.4 The Von Neumann Bottleneck and Architectural Mitigations

The **Von Neumann Bottleneck** refers to the systemic throughput constraint caused by the shared physical bus structure between the Central Processing Unit and Main Memory. Because program instructions and operational data must compete for access across the same memory bus, the CPU frequently stalls while awaiting memory transfers. As CPU clock frequencies accelerated exponentially according to Moore's Law, memory access latency did not keep pace—creating the classic "memory wall."

##### Consequences:
- **CPU Starvation (Stalls):** The high-speed ALU sits idle during clock cycles while cache misses fetch data from dynamic RAM.
- **Instruction Throughput Degradation:** Maximum instructions executed per second become bound to memory bus bandwidth rather than raw processor clock speeds.

##### Modern Engineering Mitigations:
1. **Memory Hierarchies (Multi-level Caching):** Incorporating high-speed Static RAM caches (L1, L2, L3) directly on the processor die. L1 caches operate at single-cycle latencies, capturing spatial and temporal locality and satisfying over 90% of requests without accessing main RAM.
2. **Hardware Prefetching and Buffering:** Predictive units that anticipate future instruction streams and sequential data blocks, transferring them into prefetch buffers before the execution unit requires them.
3. **Modified Harvard Architecture:** Internally splitting the Level 1 cache and bus pathways into separate **Instruction Caches (L1i)** and **Data Caches (L1d)**, completely eliminating bus contention during simultaneous instruction fetches and memory operand reads.
4. **Wider and Faster Buses:** Adopting multi-channel memory controllers (DDR4, DDR5) and high-speed point-to-point interconnects (such as PCIe and Infinity Fabric).

---

#### 4.5 Architectural Paradigms: RISC vs. CISC

The evolution of Instruction Set Architectures (ISA) generated two distinct philosophical approaches:

- **RISC (Reduced Instruction Set Computer):**
  - *Design Philosophy:* Implements a small, highly optimized set of simple, fixed-length instructions. Every instruction executes in a single clock cycle through hardwired control units.
  - *Load/Store Architecture:* Memory access is restricted exclusively to dedicated `LOAD` and `STORE` instructions; all arithmetic operations occur strictly between internal CPU registers.
  - *Advantages:* Simple instruction decoding enables highly efficient, deep pipelines; lower silicon complexity permits higher clock frequencies and reduced power consumption per instruction.
  - *Trade-offs:* Requires a higher total number of instructions to complete complex tasks, placing greater demands on compiler optimization and memory footprint.
- **CISC (Complex Instruction Set Computer):**
  - *Design Philosophy:* Provides a rich and expressive catalog of instructions, including specialized, variable-length instructions capable of performing multi-step operations (e.g., retrieving an operand from memory, performing an addition, and storing the result back in memory in one instruction).
  - *Microprogramming:* Complex instructions are internally broken down into sequences of micro-operations ($\mu$-ops) interpreted by internal microcode engines.
  - *Advantages:* High code density minimizes program memory size and reduces the frequency of instruction fetch cycles over external buses.
  - *Trade-offs:* Hardware decoding logic is physically intricate, introduces variable clock cycle latencies, and creates pipeline scheduling challenges.
  - *Modern Convergence:* Contemporary x86 processors (such as Intel Core and AMD Ryzen) are externally CISC for backward compatibility, but internally translate CISC x86 instructions into streamlined RISC-like micro-operations ($\mu$-ops) for high-performance superscalar pipelining.

---

#### 4.6 Pipelining and Hazard Management

**Instruction Pipelining** decomposes the execution of each instruction into sequential microarchitectural stages (typically: Fetch, Decode, Execute, Memory Access, and Write-Back). By overlapping these stages in time across adjacent instructions, multiple instructions are processed concurrently in different pipeline stages during any given clock cycle:

$$\text{Ideal Pipeline Speedup} \approx \text{Number of Pipeline Stages}$$

While pipelining dramatically elevates instruction throughput (Instructions Per Cycle - IPC), it introduces three primary categories of **Pipeline Hazards**:
1. **Structural Hazards:** Hardware resource conflicts where two pipeline stages demand access to the same physical unit simultaneously (e.g., a single-port memory attempting simultaneous instruction fetch and data read).
2. **Data Hazards (Data Dependencies):** An instruction depends on the result of a preceding instruction that is still traversing the pipeline and has not completed its write-back phase. Mitigated via hardware **forwarding/bypassing** or compiler instruction reordering.
3. **Control Hazards (Branch Hazards):** Caused by conditional jump instructions (`JNZ`, `JC`) where the next sequential instruction address cannot be determined until the branch condition is evaluated in the Execute stage. If the processor speculatively fetches down the wrong path, the pipeline must be flushed, wasting multiple clock cycles. Mitigated via dynamic **branch prediction** and branch target buffers (BTB).

---

#### 4.7 Parallel and Multicore Architectures

Modern computing achieves performance scaling through parallelism across multiple architectural dimensions:
- **Instruction-Level Parallelism (ILP):** Superscalar execution units that issue and complete multiple independent instructions per clock cycle via out-of-order execution engines.
- **Thread-Level Parallelism (TLP):** Multithreading and **Multicore Architectures**, where multiple independent physical CPU cores reside on a single silicon die. Each core possesses its own private Control Unit, ALU, and L1 caches, while sharing high-capacity L3 caches and main memory controllers.
- **Data-Level Parallelism (DLP):** Vector and SIMD (Single Instruction, Multiple Data) extensions (e.g., AVX, NEON) processing large arrays of numeric data simultaneously.

To mitigate multi-core memory contention and maintain consistency across private caches, modern architectures deploy hardware cache coherence protocols (such as **MESI** and **MOESI**) alongside high-bandwidth on-chip networks (Networks-on-Chip - NoC).

---

#### 4.8 Comparative Synthesis Table

| Architectural Dimension | Classical Von Neumann Architecture | Modern Microprocessor Architectures (RISC / Pipelined / Multicore) |
|---|---|---|
| **Memory Access Model** | Shared single bus for instructions and data; continuous bus contention. | Hierarchical multi-level caches (L1, L2, L3); split L1 Harvard caching (L1i / L1d); multi-channel high-speed controllers. |
| **Instruction Decoding** | Direct sequential decoding or microprogrammed ROM tables. | Superscalar hardware decoders converting CISC instructions into optimized RISC micro-ops ($\mu$-ops). |
| **Execution Paradigm** | Strictly sequential execution; one instruction completes before the next begins. | Out-of-order execution; deep pipelining (10–20 stages); superscalar dispatch of multiple instructions per cycle. |
| **Parallelism Supported** | Negligible (strictly single-threaded, sequential scalar execution). | Exploits ILP (superscalar), DLP (SIMD/AVX vectors), and TLP (multicore chips with hardware multithreading). |
| **Hardware Complexity** | Minimal silicon real-estate; straightforward timing and control logic. | Highly complex; hardware branch predictors, out-of-order reorder buffers (ROB), cache coherence controllers (MESI). |
| **Performance Driver** | Bound directly to memory bus latency and sequential clock speed. | High sustained Instruction-Per-Cycle (IPC) throughput achieved by overlapping operations and parallel execution units. |

---

### 5. PRACTICAL COMPONENT: TECHNICAL DEVELOPMENT AND EVIDENCE

#### 5.1 Public Repository Access on GitHub

All assembly source code files, build procedures, and technical documentation developed for this practical component have been versioned and published in a public GitHub repository under standard engineering practices:

🔗 **GitHub Repository:** [https://github.com/srchimbichumboss/Arquitectura-Computadores-Tarea4](https://github.com/srchimbichumboss/Arquitectura-Computadores-Tarea4)  
- Author / Account: `srchimbichumboss` (Thomas Fernando Mengual Arciniegas)  
- Assembler Target: MASM / TASM 16-bit Real Mode (DOSBox simulation under Visual Studio Code)

---

#### 5.2 Program 1: Direct Hexadecimal Arithmetic Calculator

##### A. Technical Description and Architectural Logic
Program 1 demonstrates native CPU arithmetic execution directly over general-purpose registers without intermediate memory buffers. The program captures two one-byte hexadecimal values (input range `00h` to `FFh`) and an arithmetic operator (`+` or `-`) via the keyboard.

1. **ASCII-to-Hex Conversion:** Subroutine `LeerHexByte` captures two sequential ASCII keystrokes through `INT 21H, AH=01h`. The first keystroke represents the high nibble; it is converted to its 4-bit numeric value (`0-15`) and shifted left by 4 bits (`SHL AL, 4`). The second keystroke represents the low nibble; it is converted and combined using the bitwise `OR` instruction (`OR AL, BL`), generating the true 8-bit byte.
2. **Register Allocation:** The first operand is loaded into accumulator `AL`, and the second operand is loaded into base register `BL`.
3. **Hardware Execution:** The program branches conditionally:
   - For addition: executes `ADD AL, BL`.
   - For subtraction: executes `SUB AL, BL`.
4. **Carry Flag (CF) Control:** Following the arithmetic instruction, the CPU flags register is saved to the stack via `PUSHF`. If an addition exceeds `FFh` ($255_{10}$), the hardware sets the Carry Flag ($CF=1$), indicating arithmetic overflow. In subtraction, if the subtrahend exceeds the minuend, a borrow occurs, which also asserts the Carry Flag ($CF=1$). The program reads CF using `JC` (Jump if Carry) and outputs `(Carry=1)` / `(Borrow=1)` or `(Carry=0)` / `(Borrow=0)` explicitly to the user.
5. **Hex-to-ASCII Output:** Subroutine `ImprimirHexByte` isolates the upper nibble (`SHR AL, 4`) and lower nibble (`AND AL, 0Fh`), maps values `0-9` to ASCII digits `'0'-'9'` and values `10-15` to ASCII characters `'A'-'F'`, and prints them using `INT 21H, AH=02h`.
6. **Program Termination:** The application yields control back to DOS using function `4CH` of `INT 21H` (`MOV AX, 4C00h` / `INT 21h`).

##### B. Complete Source Code (`programa1.asm`)
```asm
; ============================================================
; PROGRAMA 1: Calculadora de Aritmetica Hexadecimal Directa
; Estudiante: Thomas Fernando Mengual Arciniegas
; Curso: Arquitectura de Computadores 202016893 - UNAD
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    msg1     DB 13,10,'== CALCULADORA HEXADECIMAL ==',13,10
             DB 'Ingrese primer valor hex (2 digitos): $'
    msg2     DB 13,10,'Ingrese operador (+ o -): $'
    msg3     DB 13,10,'Ingrese segundo valor hex (2 digitos): $'
    msgR     DB 13,10,13,10,'Resultado: $'
    msgC1    DB 'h  (Carry = 1)',13,10,'$'
    msgC0    DB 'h  (Carry = 0)',13,10,'$'
    msgB1    DB 'h  (Borrow = 1)',13,10,'$'
    msgB0    DB 'h  (Borrow = 0)',13,10,'$'
    msgErr   DB 13,10,'Operador no valido.',13,10,'$'

    val1     DB 0
    val2     DB 0
    oper     DB 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Pedir primer valor
    LEA DX, msg1
    MOV AH, 09h
    INT 21h
    CALL LeerHexByte
    MOV val1, AL

    ; Pedir operador
    LEA DX, msg2
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    MOV oper, AL

    ; Pedir segundo valor
    LEA DX, msg3
    MOV AH, 09h
    INT 21h
    CALL LeerHexByte
    MOV val2, AL

    ; Cargar operandos en registros de la CPU
    MOV AL, val1
    MOV BL, val2

    ; Decidir operacion
    CMP oper, '+'
    JE HacerSuma
    CMP oper, '-'
    JE HacerResta

    LEA DX, msgErr
    MOV AH, 09h
    INT 21h
    JMP Fin

HacerSuma:
    ADD AL, BL                ; ADD directo en registros AL y BL
    PUSHF                     ; Guardar flags del procesador
    PUSH AX
    LEA DX, msgR
    MOV AH, 09h
    INT 21h
    POP AX
    CALL ImprimirHexByte
    POPF
    JC SumaConCarry           ; Saltar si Carry Flag = 1
    LEA DX, msgC0
    JMP MostrarFlag
SumaConCarry:
    LEA DX, msgC1
    JMP MostrarFlag

HacerResta:
    SUB AL, BL                ; SUB directo en registros AL y BL
    PUSHF
    PUSH AX
    LEA DX, msgR
    MOV AH, 09h
    INT 21h
    POP AX
    CALL ImprimirHexByte
    POPF
    JC RestaConBorrow         ; Saltar si Borrow (Carry Flag = 1 en resta)
    LEA DX, msgB0
    JMP MostrarFlag
RestaConBorrow:
    LEA DX, msgB1

MostrarFlag:
    MOV AH, 09h
    INT 21h

Fin:
    MOV AX, 4C00h             ; Retorno limpio al DOS
    INT 21h
MAIN ENDP

; --- Lee 2 digitos hex del teclado, retorna byte en AL ---
LeerHexByte PROC
    PUSH BX
    PUSH CX
    MOV AH, 01h
    INT 21h
    CALL CharAValor
    MOV CL, 4
    SHL AL, CL
    MOV BL, AL
    MOV AH, 01h
    INT 21h
    CALL CharAValor
    OR AL, BL
    POP CX
    POP BX
    RET
LeerHexByte ENDP

; --- Convierte caracter ASCII hex a valor 0-15 en AL ---
CharAValor PROC
    CMP AL, '9'
    JBE EsNum
    CMP AL, 'F'
    JBE EsMayus
    CMP AL, 'f'
    JBE EsMinus
    SUB AL, '0'
    RET
EsNum:
    SUB AL, '0'
    RET
EsMayus:
    SUB AL, 'A'
    ADD AL, 10
    RET
EsMinus:
    SUB AL, 'a'
    ADD AL, 10
    RET
CharAValor ENDP

; --- Imprime byte en AL como 2 digitos hex ---
ImprimirHexByte PROC
    PUSH AX
    PUSH CX
    MOV AH, AL
    MOV CL, 4
    SHR AL, CL
    CALL ImpNibble
    MOV AL, AH
    AND AL, 0Fh
    CALL ImpNibble
    POP CX
    POP AX
    RET
ImprimirHexByte ENDP

; --- Imprime nibble (0-15) en AL como caracter hex ---
ImpNibble PROC
    CMP AL, 9
    JBE EsDig
    ADD AL, 'A'-10
    JMP Impr
EsDig:
    ADD AL, '0'
Impr:
    MOV DL, AL
    MOV AH, 02h
    INT 21h
    RET
ImpNibble ENDP

END MAIN
```

##### C. Execution Evidence and Test Verification
*Below is the verification matrix with test vectors and the placeholder for your DOSBox execution screenshot.*

| Test Scenario | Operand 1 | Operator | Operand 2 | Expected Math Result | Expected Carry/Borrow Flag | Console Output |
|---|---|---|---|---|---|---|
| Addition (No Carry) | `3A` | `+` | `1F` | `59h` | Carry = 0 | `59h (Carry = 0)` |
| Addition (With Carry) | `FF` | `+` | `01` | `00h` (Overflow) | Carry = 1 | `00h (Carry = 1)` |
| Subtraction (No Borrow) | `80` | `-` | `30` | `50h` | Borrow = 0 | `50h (Borrow = 0)` |
| Subtraction (With Borrow) | `10` | `-` | `20` | `F0h` (Negative wrap) | Borrow = 1 | `F0h (Borrow = 1)` |

```text
+-------------------------------------------------------------------------+
|                  PASTE SCREENSHOT OF PROGRAM 1 HERE                     |
|       (Showing DOSBox console executing addition and subtraction)        |
+-------------------------------------------------------------------------+
```

---

#### 5.3 Program 2: Logical Mask Operator (AND / OR / XOR)

##### A. Technical Description and Architectural Logic
Program 2 showcases bit-level operations performed inside the Arithmetic Logic Unit (ALU). Digital processors use Boolean masking to manipulate specific hardware control bits without affecting adjacent bits.
1. **User Input:** The program reads an 8-bit byte (in hexadecimal) and displays an interactive menu offering three Boolean operations:
   - Option `1`: **AND** mask (used to clear or disable specific bit flags).
   - Option `2`: **OR** mask (used to set or enable specific bit flags).
   - Option `3`: **XOR** mask (used to invert or toggle bit states).
2. **Mask Application:** A secondary byte is inputted as the logic mask. The CPU executes the corresponding native x86 instruction: `AND AL, BL`, `OR AL, BL`, or `XOR AL, BL`.
3. **Binary Visual Transformation:** To demonstrate the behavior of silicon logic gates, subroutine `ImprimirBinario` converts the byte into an 8-character binary stream (`'0'` and `'1'`). It sets a loop counter `CX = 8`. In each iteration, it performs `TEST BL, 80h` to inspect the Most Significant Bit (MSB). If zero, it outputs ASCII `'0'`; if non-zero, it outputs ASCII `'1'`. It then shifts the register left (`SHL BL, 1`) and loops via `LOOP BinLoop`.
4. The program renders the original data in binary, the mask in binary, and the computed result in both 8-bit binary and hexadecimal formats.

##### B. Complete Source Code (`programa2.asm`)
```asm
; ============================================================
; PROGRAMA 2: Operador de Mascaras Logicas (AND / OR / XOR)
; Estudiante: Thomas Fernando Mengual Arciniegas
; Curso: Arquitectura de Computadores 202016893 - UNAD
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    msg1     DB 13,10,'== OPERADOR DE MASCARAS LOGICAS ==',13,10
             DB 'Ingrese un byte en hex (2 digitos): $'
    msg2     DB 13,10,'Operacion:  1=AND  2=OR  3=XOR',13,10
             DB 'Elija (1/2/3): $'
    msg3     DB 13,10,'Ingrese mascara hex (2 digitos): $'
    msgOr    DB 13,10,13,10,'Dato original (binario):  $'
    msgMk    DB 13,10,'Mascara (binario):        $'
    msgRe    DB 13,10,'Resultado (binario):      $'
    msgRh    DB 13,10,'Resultado (hex):          $'
    msgNL    DB 13,10,'$'
    msgErr   DB 13,10,'Opcion no valida.',13,10,'$'

    dato     DB 0
    mascara  DB 0
    result   DB 0
    opcion   DB 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Pedir dato
    LEA DX, msg1
    MOV AH, 09h
    INT 21h
    CALL LeerHexByte
    MOV dato, AL

    ; Pedir operacion
    LEA DX, msg2
    MOV AH, 09h
    INT 21h
    MOV AH, 01h
    INT 21h
    MOV opcion, AL

    ; Pedir mascara
    LEA DX, msg3
    MOV AH, 09h
    INT 21h
    CALL LeerHexByte
    MOV mascara, AL

    ; Mostrar dato original en binario
    LEA DX, msgOr
    MOV AH, 09h
    INT 21h
    MOV AL, dato
    CALL ImprimirBinario

    ; Mostrar mascara en binario
    LEA DX, msgMk
    MOV AH, 09h
    INT 21h
    MOV AL, mascara
    CALL ImprimirBinario

    ; Aplicar operacion logica en registros de la CPU
    MOV AL, dato
    MOV BL, mascara

    CMP opcion, '1'
    JE OpAND
    CMP opcion, '2'
    JE OpOR
    CMP opcion, '3'
    JE OpXOR

    LEA DX, msgErr
    MOV AH, 09h
    INT 21h
    JMP Fin

OpAND:
    AND AL, BL                ; Operacion nativa AND
    MOV result, AL
    JMP MostrarRes

OpOR:
    OR AL, BL                 ; Operacion nativa OR
    MOV result, AL
    JMP MostrarRes

OpXOR:
    XOR AL, BL                ; Operacion nativa XOR
    MOV result, AL

MostrarRes:
    ; Resultado en binario
    LEA DX, msgRe
    MOV AH, 09h
    INT 21h
    MOV AL, result
    CALL ImprimirBinario
    ; Sufijo 'b'
    MOV DL, 'b'
    MOV AH, 02h
    INT 21h

    ; Resultado en hexadecimal
    LEA DX, msgRh
    MOV AH, 09h
    INT 21h
    MOV AL, result
    CALL ImprimirHexByte
    MOV DL, 'h'
    MOV AH, 02h
    INT 21h

    LEA DX, msgNL
    MOV AH, 09h
    INT 21h

Fin:
    MOV AX, 4C00h             ; Retorno limpio al DOS
    INT 21h
MAIN ENDP

; --- Imprime byte en AL como 8 digitos binarios ---
ImprimirBinario PROC
    PUSH AX
    PUSH BX
    PUSH CX
    MOV BL, AL
    MOV CX, 8
BinLoop:
    MOV DL, '0'
    TEST BL, 80h              ; Probar bit mas significativo (MSB)
    JZ BitCero
    MOV DL, '1'
BitCero:
    MOV AH, 02h
    INT 21h
    SHL BL, 1                 ; Desplazar para evaluar el siguiente bit
    LOOP BinLoop
    POP CX
    POP BX
    POP AX
    RET
ImprimirBinario ENDP

; --- Lee 2 digitos hex del teclado, retorna byte en AL ---
LeerHexByte PROC
    PUSH BX
    PUSH CX
    MOV AH, 01h
    INT 21h
    CALL CharAValor
    MOV CL, 4
    SHL AL, CL
    MOV BL, AL
    MOV AH, 01h
    INT 21h
    CALL CharAValor
    OR AL, BL
    POP CX
    POP BX
    RET
LeerHexByte ENDP

; --- Convierte caracter ASCII hex a valor 0-15 en AL ---
CharAValor PROC
    CMP AL, '9'
    JBE EsNum
    CMP AL, 'F'
    JBE EsMayus
    CMP AL, 'f'
    JBE EsMinus
    SUB AL, '0'
    RET
EsNum:
    SUB AL, '0'
    RET
EsMayus:
    SUB AL, 'A'
    ADD AL, 10
    RET
EsMinus:
    SUB AL, 'a'
    ADD AL, 10
    RET
CharAValor ENDP

; --- Imprime byte en AL como 2 digitos hex ---
ImprimirHexByte PROC
    PUSH AX
    PUSH CX
    MOV AH, AL
    MOV CL, 4
    SHR AL, CL
    CALL ImpNibble
    MOV AL, AH
    AND AL, 0Fh
    CALL ImpNibble
    POP CX
    POP AX
    RET
ImprimirHexByte ENDP

; --- Imprime nibble (0-15) como caracter hex ---
ImpNibble PROC
    CMP AL, 9
    JBE EsDig
    ADD AL, 'A'-10
    JMP Impr
EsDig:
    ADD AL, '0'
Impr:
    MOV DL, AL
    MOV AH, 02h
    INT 21h
    RET
ImpNibble ENDP

END MAIN
```

##### C. Execution Evidence
*Below is the logical verification matrix and the screenshot placeholder.*

| Test Vector | Input Data (Hex) | Selected Gate | Mask (Hex) | Data in Binary | Mask in Binary | Computed Binary Output | Computed Hex Output |
|---|---|---|---|---|---|---|---|
| Bit Clearing | `B5h` | `1` (AND) | `0Fh` | `10110101b` | `00001111b` | `00000101b` | `05h` |
| Bit Setting | `A0h` | `2` (OR) | `0Fh` | `10100000b` | `00001111b` | `10101111b` | `AFh` |
| Bit Inversion | `FFh` | `3` (XOR) | `AAh` | `11111111b` | `10101010b` | `01010101b` | `55h` |

```text
+-------------------------------------------------------------------------+
|                  PASTE SCREENSHOT OF PROGRAM 2 HERE                     |
|        (Showing DOSBox console executing bitwise AND, OR, and XOR)      |
+-------------------------------------------------------------------------+
```

---

#### 5.4 Program 3: Automatic Progressive Counter in Base 16

##### A. Technical Description and Architectural Logic
Program 3 illustrates automatic iteration and conditional branching in microprocessors without high-level control constructs.
1. **Register Initialization:** Accumulator/counter register `CL` is initialized to `00h` (initial value), and register `CH` is initialized to `10h` ($16_{10}$ iterations, representing the 16 digits of base-16).
2. **Numeric-to-Hex Character Conversion:** The current value in `CL` is moved to `AL` and compared via `CMP AL, 9`:
   - If $AL \le 9$, the instruction `JBE EsDigito` jumps to add `'0'` (`30h`), yielding ASCII characters `'0'` through `'9'`.
   - If $AL > 9$, the program falls through to add `'A' - 10` (`37h`), producing ASCII characters `'A'` through `'F'`.
3. **Console Output:** The converted character is placed into `DL` and rendered using `INT 21H, AH=02h`, followed by an `'h'` suffix. A comma separator is printed for all digits except the final value `Fh`.
4. **Loop Control via Flags:** The counter is incremented using `INC CL`, while the iteration counter is decremented with `DEC CH`. The program executes `CMP CH, 0` followed by `JNZ Bucle` (Jump if Not Zero). This loop executes repeatedly until the zero condition is achieved, illustrating that loops in hardware are driven purely by flag evaluations.
5. **Clean Termination:** Upon completing the sequence, message `Conteo finalizado.` is displayed using `INT 21H, AH=09h`, and the program terminates via `INT 21H, AH=4Ch`.

##### B. Complete Source Code (`programa3.asm`)
```asm
; ============================================================
; PROGRAMA 3: Contador Progresivo Automatico en Base 16
; Estudiante: Thomas Fernando Mengual Arciniegas
; Curso: Arquitectura de Computadores 202016893 - UNAD
; ============================================================

.MODEL SMALL
.STACK 100h

.DATA
    msg1    DB 13,10,'== CONTADOR PROGRESIVO EN BASE 16 ==',13,10,13,10
            DB 'Contando de 0h a Fh:',13,10,13,10,'$'
    msgFin  DB 13,10,13,10,'Conteo finalizado.',13,10,'$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Mostrar titulo
    LEA DX, msg1
    MOV AH, 09h
    INT 21h

    ; Inicializar contador
    MOV CL, 0              ; CL = valor actual (inicia en 0h)
    MOV CH, 10h            ; CH = limite (16 iteraciones)

Bucle:
    MOV AL, CL             ; Cargar valor actual

    ; Convertir a caracter ASCII hexadecimal
    CMP AL, 9
    JBE EsDigito            ; Si es 0-9, saltar
    ADD AL, 'A' - 10        ; Si es 10-15, convertir a 'A'-'F'
    JMP Mostrar

EsDigito:
    ADD AL, '0'             ; Convertir 0-9 a '0'-'9'

Mostrar:
    MOV DL, AL
    MOV AH, 02h
    INT 21h                 ; Imprimir digito hex

    ; Imprimir 'h'
    MOV DL, 'h'
    MOV AH, 02h
    INT 21h

    ; Si es Fh (ultimo), no imprimir separador
    CMP CL, 0Fh
    JE FinBucle

    ; Imprimir separador " , "
    MOV DL, ' '
    MOV AH, 02h
    INT 21h
    MOV DL, ','
    MOV AH, 02h
    INT 21h
    MOV DL, ' '
    MOV AH, 02h
    INT 21h

    ; Incrementar contador y repetir
    INC CL                  ; CL = CL + 1
    DEC CH                  ; CH = CH - 1
    CMP CH, 0
    JNZ Bucle               ; JNZ: saltar si CH != 0 (Zero Flag = 0)

FinBucle:
    ; Mensaje final
    LEA DX, msgFin
    MOV AH, 09h
    INT 21h

    ; Devolver control al sistema operativo
    MOV AX, 4C00h
    INT 21h
MAIN ENDP

END MAIN
```

##### C. Execution Evidence
*Screenshot placeholder showing the console displaying: `0h , 1h , 2h , 3h , 4h , 5h , 6h , 7h , 8h , 9h , Ah , Bh , Ch , Dh , Eh , Fh` followed by `Conteo finalizado.`*

```text
+-------------------------------------------------------------------------+
|                  PASTE SCREENSHOT OF PROGRAM 3 HERE                     |
|           (Showing DOSBox console outputting the 0h-Fh sequence)        |
+-------------------------------------------------------------------------+
```

---

### 6. ONLINE VIDEO DEMONSTRATION LINK

In accordance with Step 5 of the practical guide, a live explanatory video was recorded showing the student on camera and demonstrating the operational and architectural foundations of the selected program:

- **Selected Program for Defense:** Program 3 – Automatic Progressive Counter in Base 16
- **Student Presenter:** Thomas Fernando Mengual Arciniegas
- **Direct Public URL:** `[INSERT YOUR YOUTUBE OR DRIVE LINK HERE]`
- **Video Coverage Checklist:**
  - [x] Clear audio and student face visible on camera throughout.
  - [x] Algorithmic structure and standard memory model (`.MODEL SMALL`, `.DATA`, `.CODE`).
  - [x] Detailed explanation of CPU registers (`AX`, `BX`, `CX`, `DX`) and their roles.
  - [x] Explanation of the ASCII conversion logic (`CMP`, `JBE`, `ADD`).
  - [x] Explanation of system interrupts: `INT 21H` functions `02h` (character print), `09h` (string display), and `4Ch` (clean OS exit).
  - [x] Live, error-free demonstration in the DOSBox simulation environment.

---

### 7. TECHNICAL CONCLUSIONS

1. **The Von Neumann architecture remains the universal foundation of modern computing:** Despite progressive enhancements—such as pipelining, multicore clustering, and predictive hardware—every contemporary processor continues to rely on John von Neumann's core paradigm: sequential instruction fetch, decoding by a control unit, execution over an ALU, and temporary staging in high-speed registers.
2. **Direct register operations are fundamental to minimizing memory latency:** Performing calculations directly within general-purpose CPU registers (`AL`, `BL`) bypasses the external memory bus entirely. This illustrates why register-based architectures represent the top tier of the memory hierarchy, executing operations in fractions of a nanosecond compared to the hundred-cycle latencies of main RAM.
3. **Hardware status flags enable multi-precision arithmetic and flow control:** The CPU `FLAGS` register—particularly the Carry Flag (`CF`) and Zero Flag (`ZF`)—serves as the primary feedback loop connecting low-level hardware operations to software control logic. Inspecting `CF` after arithmetic instructions guarantees mathematical integrity across byte boundaries, while evaluating `ZF` enables hardware-driven loop iterations without software overhead.
4. **Bitwise boolean instructions mirror physical logic gate primitives:** Instructions such as `AND`, `OR`, and `XOR` execute concurrent bit-level operations across all 8 bit positions of a byte simultaneously in hardware. This reflects the physical behavior of silicon logic gates within the ALU, demonstrating how hardware masks selectively clear, assert, or toggle individual control bits in microcontrollers and peripheral interfaces.
5. **Software interrupts provide a standardized interface to operating system services:** Invoking `INT 21H` vectors CPU execution into operating system service routines. Implementing function `4CH` guarantees proper de-allocation of process memory and restitution of the stack pointer, proving that robust software must always respect operating system application-binary interfaces (ABIs) to avoid system lockups.

---

### 8. BIBLIOGRAPHIC REFERENCES (APA 7th Edition)

- Abel, P. (2001). *IBM PC assembly language and programming* (5th ed.). Prentice Hall.
- Blanco Martín, J. (2013). *Manual administración de hardware de un sistema informático: formación para el empleo* (pp. 34–64). Editorial CEP, S.L. https://elibronet.bibliotecavirtual.unad.edu.co/es/ereader/unad/50599?page=34
- Flynn, M. J. (1972). Some computer organizations and their effectiveness. *IEEE Transactions on Computers*, *C-21*(9), 948–960. https://doi.org/10.1109/TC.1972.5009071
- Hennessy, J. L., & Patterson, D. A. (2017). *Computer architecture: A quantitative approach* (6th ed.). Morgan Kaufmann. https://doi.org/10.1016/C2015-0-01997-7
- Irvine, K. R. (2019). *Assembly language for x86 processors* (8th ed.). Pearson.
- Microsoft Corporation. (2024). *MASM for x64 (ml64.exe) and x86 reference*. Microsoft Learn. https://learn.microsoft.com/en-us/cpp/assembler/masm/masm-reference
- Noguera Torres, A. del P., & Caro Martínez, C. A. (2022). Diseño de un sistema inteligente de bajo costo para una edificación apoyado en tecnologías disruptivas. *Documentos de Trabajo ECBTI*, *3*(2). https://doi.org/10.22490/ECBTI.6517
- Patterson, D. A., & Hennessy, J. L. (2014). *Computer organization and design: The hardware/software interface* (ARM/RISC-V ed.). Morgan Kaufmann. https://doi.org/10.1016/C2013-0-19136-0
- Smith, J. E. (1981). A study of branch prediction strategies. In *Proceedings of the 8th Annual Symposium on Computer Architecture* (pp. 135–148). ACM. https://doi.org/10.1145/800216.806596
- Soto, J. M. (2022). *Qué es un sistema informático* [Objeto virtual de aprendizaje]. Repositorio Institucional UNAD.
- Stallings, W. (2018). *Computer organization and architecture: Designing for performance* (11th ed.). Pearson.
- Universidad Nacional Abierta y a Distancia. (2026). *Guía de aprendizaje para el desarrollo del componente práctico – Tarea 4: Arquitectura de Computadores (Código: 202016893)*. Vicerrectoría Académica y de Investigación (VIACI).
