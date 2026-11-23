# REPORT DRAFT — Task 4: Simulated Practical Component

> [!NOTE]
> This is a draft/outline. Replace `[YOUR NAME]`, `[DATE]`, `[VIDEO LINK]`, and add your screenshots before converting to PDF.

---

## Cover Page

- **University:** Universidad Nacional Abierta y a Distancia – UNAD
- **School:** Escuela de Ciencias Básicas, Tecnología e Ingeniería – ECBTI
- **Program:** Systems Engineering
- **Course:** Computer Architecture – 202016893
- **Assignment:** Task 4 – Simulated Practical Component
- **Student:** [YOUR FULL NAME]
- **Date:** [DATE]

---

## 1. Introduction

This report presents the development and execution of three assembly language programs designed to demonstrate fundamental concepts of computer architecture at the processor level. Using the MASM/TASM assembler within Visual Studio Code, each program exercises a different aspect of the x86 instruction set: direct arithmetic operations on CPU registers, Boolean logic masking with bitwise instructions, and automatic counting through conditional jumps and loop structures. The practical component reinforces the theoretical understanding of how the processor manipulates data at the register and binary level through the DOS interrupt system (INT 21H).

---

## 2. General Objective

To design, code, and execute assembly language programs using simulation tools, demonstrating the practical application of architectural principles in x86 processors.

### Specific Objectives

1. To implement direct hexadecimal arithmetic (ADD/SUB) on CPU general-purpose registers, controlling the Carry Flag.
2. To apply Boolean logic masks (AND, OR, XOR) to a data byte and display the transformed result in 8-bit binary format.
3. To build an automatic hexadecimal counter (0h–Fh) using conditional jumps (CMP, JNZ) and register manipulation.
4. To understand and use DOS system interrupts (INT 21H) for keyboard input and screen output.
5. To document the development process with source code, execution evidence, and technical conclusions.

---

## 3. Technical Development and Evidence

### 3.1 Program 1: Direct Hexadecimal Arithmetic Calculator

**Description:** This program reads two one-byte hexadecimal values and an arithmetic operator (+ or −) from the keyboard. It loads both operands into CPU registers AL and BL, then executes the native ADD or SUB instruction. The result is displayed in hexadecimal format, and the program checks the Carry Flag (CF) to report whether a carry (in addition) or borrow (in subtraction) occurred.

**Key registers used:** AL (first operand and result), BL (second operand), CL (bit shifting for nibble conversion), DL (character output).

**Interrupts used:**
- INT 21H, function 01H — Read a character from keyboard with echo.
- INT 21H, function 02H — Display a single character on screen.
- INT 21H, function 09H — Display a string terminated by '$'.
- INT 21H, function 4CH — Terminate program and return control to the OS.

**Complete source code:**

```asm
; (Paste the full content of programa1.asm here)
```

**Execution evidence:**

> [!IMPORTANT]
> Insert your screenshots here showing: compilation without errors + execution with test data (e.g., 3A + 1F = 59h, Carry=0).

---

### 3.2 Program 2: Logical Mask Operator (AND / OR / XOR)

**Description:** This program receives a data byte in hexadecimal format, allows the user to select a Boolean operation (AND to clear bits, OR to set bits, XOR to toggle bits), and a mask byte. It applies the chosen bitwise instruction directly on the CPU registers and prints both the original data and the result in 8-bit binary format, demonstrating processor behavior at the logic gate level.

**Key registers used:** AL (data byte and result), BL (mask byte), CL (bit counter for binary display).

**Interrupts used:** INT 21H functions 01H, 02H, 09H, and 4CH (same as Program 1).

**Complete source code:**

```asm
; (Paste the full content of programa2.asm here)
```

**Execution evidence:**

> [!IMPORTANT]
> Insert your screenshots here showing: execution with test data (e.g., B5 AND 0F = 00000101b).

---

### 3.3 Program 3: Automatic Progressive Counter in Base 16

**Description:** This program implements a loop using conditional jumps (CMP, JNZ) and register increment/decrement (INC, DEC) to automatically count and display all 16 hexadecimal digits from 0h to Fh on the command screen. No user input is required; the counter runs automatically upon execution.

**Key registers used:** CL (current counter value, 0 to 15), CH (iteration limit, decremented each cycle), AL/DL (character conversion and output).

**Instructions demonstrated:** INC (increment), DEC (decrement), CMP (compare), JNZ (Jump if Not Zero), JBE (Jump if Below or Equal).

**Complete source code:**

```asm
; (Paste the full content of programa3.asm here)
```

**Execution evidence:**

> [!IMPORTANT]
> Insert your screenshots here showing the output: 0h, 1h, 2h, 3h, 4h, 5h, 6h, 7h, 8h, 9h, Ah, Bh, Ch, Dh, Eh, Fh

---

## 4. Online Video Link

**Selected program for video demonstration:** Program [1 / 2 / 3]

🔗 **Video URL:** [PASTE YOUR YOUTUBE OR GOOGLE DRIVE LINK HERE]

---

## 5. Technical Conclusions

1. **Register-level arithmetic demonstrates CPU efficiency.** By loading operands directly into registers AL and BL and executing ADD or SUB, the processor performs the calculation in a single clock cycle without accessing main memory, illustrating why registers are the fastest storage in the memory hierarchy.

2. **The Carry Flag provides essential overflow detection.** After each arithmetic operation, the processor automatically sets or clears the CF bit in the FLAGS register, enabling the program to detect when an 8-bit result exceeds the FFh boundary — a critical mechanism for multi-byte arithmetic in real-world applications.

3. **Bitwise Boolean instructions reveal logic gate behavior.** The AND, OR, and XOR instructions operate on individual bits simultaneously across all 8 positions of a byte, mirroring the behavior of physical AND, OR, and XOR logic gates inside the ALU (Arithmetic Logic Unit) of the processor.

4. **Conditional jumps replace high-level control structures.** Unlike high-level languages that use `for` or `while` loops, assembly relies on CMP to set condition flags and JNZ/JE to redirect execution flow, demonstrating that all program control ultimately reduces to flag comparisons and instruction pointer manipulation at the hardware level.

5. **DOS interrupt INT 21H serves as the bridge between software and hardware.** Each function of INT 21H (01H for input, 02H/09H for output, 4CH for termination) triggers a software interrupt that transfers control to the operating system kernel, showing how user programs communicate with I/O devices through a standardized system call interface rather than accessing hardware directly.

---

## 6. Bibliographic References

Irvine, K. R. (2019). *Assembly language for x86 processors* (8th ed.). Pearson.

Stallings, W. (2018). *Computer organization and architecture: Designing for performance* (11th ed.). Pearson.

Abel, P. (2001). *IBM PC assembly language and programming* (5th ed.). Prentice Hall.

Microsoft. (n.d.). *MASM reference*. Microsoft Learn. https://learn.microsoft.com/en-us/cpp/assembler/masm/masm-reference

Universidad Nacional Abierta y a Distancia. (2026). *Guía para el desarrollo del componente práctico – Tarea 4*. UNAD Virtual Campus.
