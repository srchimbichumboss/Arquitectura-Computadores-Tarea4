# Arquitectura de Computadores – Tarea 4: Componente Práctico Simulado

**Universidad Nacional Abierta y a Distancia (UNAD)**  
**Escuela de Ciencias Básicas, Tecnología e Ingeniería (ECBTI)**  
**Curso:** Arquitectura de Computadores (Código: 202016893)  

Este repositorio contiene los programas en lenguaje ensamblador x86 (sintaxis MASM/TASM para emulador DOSBox), la guía de sustentación en video y el informe académico en idioma inglés, cumpliendo con la totalidad de los criterios de la rúbrica de evaluación.

---

## 📂 Contenido del Repositorio

| Archivo | Descripción Técnica |
|---|---|
| `programa1.asm` | **Calculadora de Aritmética Hexadecimal Directa**: Solicita 2 valores hex de 1 byte (00h-FFh) y un operador (+ o -). Ejecuta instrucciones nativas `ADD` o `SUB` sobre registros de la CPU y muestra el resultado en hexadecimal controlando el Carry Flag (CF). |
| `programa2.asm` | **Operador de Máscaras Lógicas (AND / OR / XOR)**: Recibe un byte en hexadecimal y aplica compuertas lógicas booleanas mediante máscaras de bits. Imprime el resultado en **formato binario de 8 bits** para evidenciar la operación a nivel de compuertas lógicas. |
| `programa3.asm` | **Contador Progresivo Automático en Base 16**: Implementa estructuras de bucle y saltos condicionales (`CMP`, `JNZ`, `INC`, `DEC`) para recorrer limpiamente los 16 dígitos del sistema hexadecimal (0h a Fh). |
| `Report_Draft_English.md` | Estructura completa del informe escrito formal en **idioma inglés** (Cover Page, Introduction, Objectives, Technical Development, Conclusions y APA References). |
| `Guia_Video_Sustentacion.md` | Guión técnico paso a paso para el video de sustentación de 5 minutos (registros AX, BX, CX, DX, interrupciones INT 21H y demostración en vivo). |

---

## 🛠️ Requisitos y Ejecución en Visual Studio Code

1. Instalar la extensión **MASM/TASM** (`xsro.masm-tasm`) en Visual Studio Code.
2. Abrir cualquiera de los archivos `.asm`.
3. Hacer clic derecho sobre el código fuente y seleccionar **"Run ASM code"** (o presionar la tecla de compilación rápida).
4. El simulador DOSBox ejecutará el código en arquitectura x86 de 16 bits interactuando a través de las interrupciones del sistema operativo (`INT 21H`).

---

## ⚙️ Arquitectura y Registros Utilizados

- **Modelo de Memoria:** `.MODEL SMALL` (Segmento de datos y código independientes de hasta 64KB).
- **Segmento de Pila:** `.STACK 100h` (256 bytes de espacio de pila).
- **Registros de Propósito General:**
  - `AX (AH/AL)`: Acumulador principal para operaciones aritméticas, conversiones numéricas y selección de funciones del DOS.
  - `BX (BH/BL)`: Registro base utilizado como almacenamiento auxiliar de operandos y desplazamientos de bits.
  - `CX (CH/CL)`: Contador de iteraciones para bucles y control de bits en salidas binarias.
  - `DX (DH/DL)`: Puntero de cadenas para `INT 21H, AH=09h` y salida de caracteres individuales con `AH=02h`.
- **Finalización del Programa:** Función `4CH` de la interrupción `INT 21H` (`MOV AX, 4C00h` / `INT 21h`) para retorno seguro del control al sistema operativo.
