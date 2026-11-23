# Prácticas en Ensamblador x86 - Tarea 4

Trabajo del componente práctico simulado para el curso **Arquitectura de Computadores (202016893)** de la UNAD.

**Estudiante:** Thomas Fernando Mengual Arciniegas  
**Tutor:** Ángel Alberto Varón Quimbayo  
**Ingeniería de Sistemas - 2026**

---

## 💻 Contenido del repositorio

Contiene los 3 programas pedidos por la guía para compilar con MASM / TASM en DOSBox:

1. **`programa1.asm` (Calculadora Hexadecimal):**  
   Pide 2 números en hexadecimal de 2 dígitos y la operación (`+` o `-`). Hace la suma o resta directamente en registros de la CPU y muestra el resultado indicando si hubo Carry (`Carry = 1`) o Borrow en la resta.

2. **`programa2.asm` (Máscaras Lógicas):**  
   Pide un dato en hexadecimal y una máscara. Permite elegir entre `AND`, `OR` y `XOR`. Muestra el dato original, la máscara y el resultado en formato binario de 8 bits para ver cómo cambian los bits con las compuertas lógicas.

3. **`programa3.asm` (Contador en Base 16):**  
   Cuenta automáticamente de `0h` a `Fh` en pantalla sin pedir datos al usuario. Usa comparaciones (`CMP`), saltos (`JNZ`) e incrementos (`INC`) para hacer el bucle.

---

## 🛠️ Cómo compilar y correr en VS Code

1. Instalar la extensión **MASM/TASM** de VS Code (`xsro.masm-tasm`).
2. Abrir cualquiera de los archivos `.asm`.
3. Dar clic derecho en el código y presionar **"Run ASM code"**.
4. Se abre la ventana de DOSBox automáticamente y corre el programa.

---

## 📹 Video de sustentación
- **Enlace del video:** [https://canva.link/tjoiogn9x39q4w7](https://canva.link/tjoiogn9x39q4w7)

---

## 👤 Autor
Thomas Fernando Mengual Arciniegas  
GitHub: [@srchimbichumboss](https://github.com/srchimbichumboss)
