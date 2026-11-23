# Tarea 4 – Componente Práctico Simulado
## Arquitectura de Computadores (Course Code: 202016893)

---

### COVER PAGE

**Course:** Computer Architecture  
**Code:** 202016893  
**Assignment Name:** Task 4 – Simulated Practical Component  
**Student’s Full Name:** [Student's Full Name]  
**Student ID / Identification:** [Document Number / ID]  
**Group Number:** [Group Number]  
**Tutor:** [Tutor's Name]  
**Institution:** Universidad Nacional Abierta y a Distancia (UNAD)  
**School:** Escuela de Ciencias Básicas, Tecnología e Ingeniería (ECBTI)  
**Program:** Systems Engineering  
**Date:** November 2026  

---

### 1. INTRODUCTION

The low-level programming paradigm allows software engineers to directly interact with processor hardware, bypassing the abstractions introduced by modern operating systems and high-level virtual machines. In the context of the x86 processor architecture, Assembly language serves as the foundational bridge between computational logic and the physical execution units of the Central Processing Unit (CPU). 

This academic report documents the design, implementation, and verification of three specialized assembly language programs developed under the MASM/TASM syntax and simulated using the DOSBox 16-bit real-mode execution environment within Visual Studio Code. The three exercises address critical architectural principles: direct 8-bit hexadecimal arithmetic with hardware-level Carry Flag control (ADD and SUB instructions), bitwise logic manipulation using Boolean masks (AND, OR, XOR) with 8-bit binary visual representations, and automatic iterative loops constructed via conditional branching and register decrementation (CMP, JNZ, LOOP).

In addition, each program adheres strictly to standard memory segmentation conventions (`.MODEL SMALL`, `.STACK`, `.DATA`, and `.CODE`) and interacts with peripheral hardware through DOS software interrupts (`INT 21H`). This work provides practical evidence of register allocation, flag register behaviors, and operating system handoff procedures via interrupt function `4CH`.

---

### 2. OBJECTIVES

#### 2.1 General Objective
To design, implement, and validate assembly language programs using simulation environments, demonstrating the operational principles of computer architecture, processor registers, arithmetic-logic flags, and system interrupts in x86-based microprocessors.

#### 2.2 Specific Objectives
1. To implement an 8-bit hexadecimal arithmetic calculator directly over CPU general-purpose registers (AL, BL), accurately tracking the arithmetic carry and borrow conditions through the processor’s Carry Flag (CF).
2. To apply Boolean logic masks (AND, OR, XOR) to user-supplied byte inputs, displaying the resulting bit transformations in an 8-bit binary representation to visualize CPU logic gate operations.
3. To construct an automated base-16 counter traversing values from `0h` to `Fh` through conditional jumps (`CMP`, `JNZ`) and register manipulation without requiring external iterative constructs.
4. To implement standard DOS interrupt calls (`INT 21H`) for keyboard capture (functions `01H`), console character output (function `02H`), string stream rendering (function `09H`), and termination control (function `4CH`).
5. To document the architectural impact of CPU register usage and software interrupts through a formal technical report and a live video demonstration.

---

### 3. TECHNICAL DEVELOPMENT AND EVIDENCE

#### 3.1 Repository Access
The complete source code, execution files, and technical documentation are available in the public GitHub repository:  
🔗 **GitHub Repository:** [https://github.com/srchimbichumboss/Arquitectura-Computadores-Tarea4](https://github.com/srchimbichumboss/Arquitectura-Computadores-Tarea4)

---

#### 3.2 Program 1: Direct Hexadecimal Arithmetic Calculator

##### A. Technical Description
Program 1 captures two one-byte hexadecimal values (range `00h` to `FFh`) and an arithmetic operator (`+` or `-`) from the standard keyboard input. The values are converted from ASCII characters into raw 8-bit numeric values and placed into CPU general-purpose registers `AL` and `BL`. The program executes native x86 machine instructions `ADD AL, BL` or `SUB AL, BL`. Following the operation, the status of the Carry Flag (CF) in the CPU `FLAGS` register is inspected using conditional jump instructions (`JC` - Jump if Carry). The program converts the resulting 8-bit value back to hexadecimal characters for console output and explicitly notifies the user whether a Carry (overflow on addition) or Borrow (underflow on subtraction) took place.

##### B. CPU Register Usage and Interrupt Specification
- `AX` (`AH` / `AL`): `AL` acts as the primary accumulator storing the first operand and the arithmetic result; `AH` holds the service numbers for DOS interrupt calls (`01h`, `02h`, `09h`, `4Ch`).
- `BX` (`BH` / `BL`): `BL` stores the second arithmetic operand.
- `CL`: Stores shift counts (4 bits) for nibble manipulation (`SHL`, `SHR`).
- `DX`: Holds data buffer pointers for string rendering via `INT 21H, AH=09h` and character payloads for `AH=02h`.
- `FLAGS (CF)`: Evaluated via `PUSHF`, `POPF`, and `JC` to identify overflow / borrow.

##### C. Complete Source Code (`programa1.asm`)
```asm
; ============================================================
; PROGRAMA 1: Calculadora de Aritmetica Hexadecimal Directa
; Arquitectura de Computadores 202016893 - UNAD
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
    ADD AL, BL                ; ADD directo en registros
    PUSHF                     ; Guardar flags
    PUSH AX
    LEA DX, msgR
    MOV AH, 09h
    INT 21h
    POP AX
    CALL ImprimirHexByte
    POPF
    JC SumaConCarry
    LEA DX, msgC0
    JMP MostrarFlag
SumaConCarry:
    LEA DX, msgC1
    JMP MostrarFlag

HacerResta:
    SUB AL, BL                ; SUB directo en registros
    PUSHF
    PUSH AX
    LEA DX, msgR
    MOV AH, 09h
    INT 21h
    POP AX
    CALL ImprimirHexByte
    POPF
    JC RestaConBorrow
    LEA DX, msgB0
    JMP MostrarFlag
RestaConBorrow:
    LEA DX, msgB1

MostrarFlag:
    MOV AH, 09h
    INT 21h

Fin:
    MOV AX, 4C00h
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

##### D. Operational Evidence and Test Cases
*Insert screenshot here showing successful compilation and execution of Program 1 with sample data (e.g., `3A + 1F = 59h (Carry = 0)` and `FF + 01 = 00h (Carry = 1)`).*

```text
[PASTE SCREENSHOT OF PROGRAM 1 EXECUTION HERE]
```

---

#### 3.3 Program 2: Logical Mask Operator (AND / OR / XOR)

##### A. Technical Description
Program 2 demonstrates the bit-level manipulation capabilities of the CPU Arithmetic Logic Unit (ALU). The user inputs an 8-bit byte in hexadecimal format and selects one of three Boolean operations:
1. `AND`: Clears/masks out specific control bits (forcing target bit positions to 0).
2. `OR`: Sets specific bits (forcing target bit positions to 1).
3. `XOR`: Inverts/toggles bit states.

The program reads a secondary mask byte from the user and applies the native machine instruction (`AND AL, BL`, `OR AL, BL`, or `XOR AL, BL`). To show the internal hardware gate behavior, the program implements a specialized iterative procedure (`ImprimirBinario`) that examines each bit using the `TEST` instruction with `80h` (Most Significant Bit test), shifting left (`SHL`) through all 8 positions to print the exact binary sequence (e.g., `10101111b`).

##### B. Complete Source Code (`programa2.asm`)
```asm
; ============================================================
; PROGRAMA 2: Operador de Mascaras Logicas (AND / OR / XOR)
; Arquitectura de Computadores 202016893 - UNAD
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

    ; Aplicar operacion logica
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
    AND AL, BL
    MOV result, AL
    JMP MostrarRes

OpOR:
    OR AL, BL
    MOV result, AL
    JMP MostrarRes

OpXOR:
    XOR AL, BL
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
    MOV AX, 4C00h
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
    TEST BL, 80h
    JZ BitCero
    MOV DL, '1'
BitCero:
    MOV AH, 02h
    INT 21h
    SHL BL, 1
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

##### C. Operational Evidence
*Insert screenshot here illustrating logic operations (e.g., input `B5h` with mask `0Fh` under `AND` operation yielding `00000101b`).*

```text
[PASTE SCREENSHOT OF PROGRAM 2 EXECUTION HERE]
```

---

#### 3.4 Program 3: Automatic Progressive Counter in Base 16

##### A. Technical Description
Program 3 illustrates repetitive program execution at machine level using CPU registers and branch instructions. The program does not rely on high-level loops; instead, it initializes register `CL` to `00h` (counter state) and `CH` to `10h` (16 total iterations). In each cycle, the numerical value in `CL` is checked against `9`:
- If `CL <= 9`: converted to ASCII digit by adding `'0'` (`30h`).
- If `CL > 9`: converted to ASCII uppercase letter (`A` through `F`) by adding `'A' - 10` (`37h`).

The character is printed via `INT 21H, AH=02h`. Register `CL` is incremented (`INC CL`), iteration counter `CH` is decremented (`DEC CH`), and compared to zero (`CMP CH, 0`). The conditional jump `JNZ Bucle` (Jump if Not Zero) maintains execution until all 16 hexadecimal digits (`0h` through `Fh`) are cleanly formatted on screen. Control is returned cleanly to DOS using `INT 21H, AH=4Ch`.

##### B. Complete Source Code (`programa3.asm`)
```asm
; ============================================================
; PROGRAMA 3: Contador Progresivo Automatico en Base 16
; Arquitectura de Computadores 202016893 - UNAD
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
    JNZ Bucle               ; JNZ: saltar si CH != 0

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

##### C. Operational Evidence
*Insert screenshot here showing automatic execution output: `0h , 1h , 2h , 3h , 4h , 5h , 6h , 7h , 8h , 9h , Ah , Bh , Ch , Dh , Eh , Fh` followed by `Conteo finalizado.`*

```text
[PASTE SCREENSHOT OF PROGRAM 3 EXECUTION HERE]
```

---

### 4. ONLINE VIDEO LINK

- **Demonstrated Program:** Program 3 (Automatic Progressive Counter in Base 16)  
- **Speaker:** [Student's Full Name]  
- **Video Platform:** [YouTube / Google Drive / Loom]  
- **Direct Public URL:** `[INSERT YOUR DIRECT PUBLIC VIDEO LINK HERE]`  
- **Video Content Summary:** The video shows the student on camera explaining the algorithm, CPU registers (`AX`, `BX`, `CX`, `DX`), the ASCII adjustment logic, the role of DOS interrupt `INT 21H` (functions `02H`, `09H`, `4CH`), and demonstrates live execution in real time without compilation errors.

---

### 5. TECHNICAL CONCLUSIONS

1. **Direct CPU register arithmetic minimizes memory bus latency:** Performing addition and subtraction operations directly within registers `AL` and `BL` executes in minimal CPU clock cycles, demonstrating that internal register operations represent the fastest memory tier in processor architecture, completely circumventing RAM access penalties during computation.
2. **Hardware flag control is vital for multi-byte numeric precision:** The hardware Carry Flag (CF) within the `FLAGS` register provides real-time detection of arithmetic boundaries (overflow upon addition past `FFh` or borrow upon subtraction below `00h`). Inspecting this flag via conditional jumps (`JC`) is indispensable for implementing higher-precision, multi-word arithmetic engines.
3. **Bitwise boolean instructions mirror physical logic gate primitives:** Instructions such as `AND`, `OR`, and `XOR` execute concurrent bit-by-bit transformations across all 8 bit positions of the operand simultaneously. This provides a direct programming mirror to physical silicon logic gates (bus masking, selective enabling, and parity inversions) inside the Arithmetic Logic Unit (ALU).
4. **Conditional branching replaces high-level abstraction loops:** In assembly language, iterative control structures are achieved by pairing evaluation instructions (`CMP`, `TEST`, `DEC`) with status flags (Zero Flag `ZF`) and conditional branches (`JNZ`, `JE`, `JBE`). This establishes that all high-level control loops (`while`, `for`) physically translate into flag-state tests and Instruction Pointer (`IP`) address manipulation.
5. **Operating system handoff requires standard interrupt vectors:** Software interrupts such as `INT 21H` constitute the architectural bridge between application-space code and operating-system services. Properly utilizing function `4CH` guarantees clean process de-allocation and stack restoration, preventing CPU lockups and ensuring system stability in protected and real-mode environments.

---

### 6. BIBLIOGRAPHIC REFERENCES (APA 7th Edition)

- Abel, P. (2001). *IBM PC assembly language and programming* (5th ed.). Prentice Hall.
- Irvine, K. R. (2019). *Assembly language for x86 processors* (8th ed.). Pearson.
- Microsoft Corporation. (2024). *MASM for x64 (ml64.exe) and x86 reference*. Microsoft Learn. https://learn.microsoft.com/en-us/cpp/assembler/masm/masm-reference
- Stallings, W. (2018). *Computer organization and architecture: Designing for performance* (11th ed.). Pearson Education.
- Universidad Nacional Abierta y a Distancia. (2026). *Guía de aprendizaje para el desarrollo del componente práctico – Tarea 4: Arquitectura de Computadores*. Vicerrectoría Académica y de Investigación (VIACI).
