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
