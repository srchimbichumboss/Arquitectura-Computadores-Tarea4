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
