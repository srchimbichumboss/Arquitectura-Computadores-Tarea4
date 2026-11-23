.MODEL SMALL
.STACK 100h

.DATA
    msg1    DB 13,10,'== CONTADOR PROGRESIVO EN BASE 16 ==',13,10,13,10
    DB     'Contando de 0h a Fh:',13,10,13,10,'$'
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
        MOV CL, 0              ; CL = valor actual  (inicia en 0h)
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
        JE  FinBucle

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