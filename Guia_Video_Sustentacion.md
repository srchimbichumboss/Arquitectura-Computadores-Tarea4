# 🎥 Guía para tu Video de Sustentación (Máx. 5 min)

> [!IMPORTANT]
> Debes **aparecer en cámara mostrando tu rostro** durante todo el video. Puedes compartir pantalla al mismo tiempo.

---

## ¿Qué programa elegir?

Te recomiendo el **Programa 3 (Contador Hexadecimal)** porque es el más fácil de explicar y el más visual. Pero puedes elegir cualquiera.

---

## Guión paso a paso (Programa 3 recomendado)

### INTRO (~30 segundos)
> *"Buenas, mi nombre es [TU NOMBRE], del curso de Arquitectura de Computadores. Voy a sustentar el Programa 3: Contador Progresivo Automático en Base 16."*

### PARTE 1: ¿Qué hace el programa? (~30 seg)
> *"Este programa cuenta automáticamente desde 0h hasta Fh, mostrando en pantalla los 16 dígitos del sistema hexadecimal: 0, 1, 2... hasta 9, y luego A, B, C, D, E, F."*

### PARTE 2: Estructura del código (~1 min)
> *"El programa usa la estructura estándar de MASM: `.MODEL SMALL` para usar un segmento de datos y uno de código, `.STACK 100h` para reservar la pila, `.DATA` donde declaro los mensajes de texto, y `.CODE` donde va la lógica del programa."*

### PARTE 3: Los registros (~1 min)
Explica esto:

| Registro | Qué es | Para qué se usa aquí |
|----------|--------|---------------------|
| **CL** | Parte baja del registro CX | Guarda el valor actual del contador (0 a 15) |
| **CH** | Parte alta del registro CX | Lleva la cuenta de cuántas iteraciones faltan (16 total) |
| **AL** | Parte baja del registro AX (acumulador) | Se usa para convertir el número a carácter ASCII |
| **DL** | Parte baja del registro DX | Contiene el carácter que se va a imprimir en pantalla |
| **AH** | Parte alta del registro AX | Se carga con el número de función de la interrupción |

> *"Uso el registro CL como mi contador, que empieza en 0. CH lo uso como límite, con valor 16 decimal que es 10h. AL lo uso para convertir cada número a su carácter, y DL es donde pongo el carácter que quiero imprimir."*

### PARTE 4: Las instrucciones clave (~1 min)
Explica qué hace cada una:

| Instrucción | Qué significa | Qué hace |
|-------------|--------------|----------|
| `INC CL` | **Increment** | Le suma 1 al contador CL |
| `DEC CH` | **Decrement** | Le resta 1 al límite CH |
| `CMP CH, 0` | **Compare** | Compara CH con cero y activa las banderas (flags) del procesador |
| `JNZ Bucle` | **Jump if Not Zero** | Si CH NO es cero, salta de vuelta al inicio del bucle para repetir |
| `JBE` | **Jump if Below or Equal** | Salta si el valor es menor o igual (para decidir si es dígito 0-9 o letra A-F) |
| `CMP AL, 9` | Compare | Compara el valor actual con 9 para saber si es número o letra |

> *"El bucle funciona así: primero comparo si el valor es menor o igual a 9 con CMP. Si lo es, le sumo el código ASCII del '0'. Si es mayor que 9, le sumo el código de 'A' menos 10 para convertirlo a letra. Luego imprimo, incremento CL, decremento CH, y si CH no es cero, el JNZ me devuelve al inicio del bucle."*

### PARTE 5: Las interrupciones (~1 min)
Explica esto:

| Interrupción | Función | Qué hace en español |
|-------------|---------|-------------------|
| `INT 21h, AH=02h` | Escribir carácter | Imprime en pantalla el carácter que está en DL |
| `INT 21h, AH=09h` | Escribir cadena | Imprime un mensaje de texto completo (terminado en `$`) |
| `INT 21h, AH=4Ch` | Terminar programa | Cierra el programa y devuelve el control al sistema operativo DOS |

> *"INT 21h es la interrupción principal de DOS para entrada y salida. Cuando cargo AH con 02h y llamo INT 21h, el sistema imprime el carácter que esté en DL. Con AH=09h imprime una cadena de texto completa. Y al final, AH=4Ch es obligatorio para terminar correctamente el programa y devolver el control al sistema operativo."*

### PARTE 6: Ejecución en vivo (~30 seg)
> *"Ahora voy a ejecutar el programa..."*
> *(Clic derecho → Run ASM code → se abre DOSBox → se ve el resultado)*
> *"Como pueden ver, el contador muestra correctamente los 16 dígitos hexadecimales de 0h hasta Fh. El programa termina limpiamente con la función 4Ch."*

### CIERRE (~15 seg)
> *"En conclusión, este programa demuestra cómo el procesador puede implementar estructuras de repetición usando comparaciones y saltos condicionales a nivel de hardware, sin necesidad de estructuras de alto nivel. Gracias."*

---

## 📚 Qué significa cada cosa (para que entiendas)

### ¿Qué es un registro?
Es una **pequeña memoria ultrarrápida dentro del procesador**. Es como una cajita donde el CPU guarda temporalmente los datos con los que está trabajando. Son mucho más rápidos que la RAM.

### ¿Qué es INT 21h?
Es una **interrupción de software**. Cuando tu programa necesita hacer algo que depende del sistema operativo (como leer del teclado o imprimir en pantalla), no puede hacerlo directamente. Entonces "interrumpe" al sistema operativo con `INT 21h` y le dice qué necesita mediante el número de función en AH.

### ¿Qué es el Carry Flag?
Es un **bit dentro del registro de banderas (FLAGS)** del procesador. Se enciende automáticamente cuando una suma produce un resultado mayor a lo que cabe en 8 bits (255 / FFh), o cuando una resta da negativo. Es como la "llevada" cuando sumas en papel.

### ¿Qué es una máscara de bits?
Es un **patrón de unos y ceros** que se usa para modificar bits específicos de un dato:
- **AND** con 0 → apaga ese bit (lo pone en 0)
- **OR** con 1 → enciende ese bit (lo pone en 1)  
- **XOR** con 1 → invierte ese bit (si era 0 pasa a 1 y viceversa)

### ¿Qué es `.MODEL SMALL`?
Le dice al ensamblador que el programa va a usar **un solo segmento de datos y un solo segmento de código**, cada uno de máximo 64KB. Es el modelo más común para programas DOS pequeños.

### ¿Qué es `4Ch`?
Es la función de INT 21h que **termina el programa** correctamente. Sin esto, el programa no devuelve el control a DOS y se puede colgar.
