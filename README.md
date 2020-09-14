# Tutorial de sintaxis NASM #
NASM es un lenguaje de bajo nivel, tambien conocido como lenguaje ensamblador, en el cual cuenta con un set de instrucciones el cual interactua directamente con la arquitectura del procesador y con el sistema operativo, por otro lado NASM es un lenguaje de arquitectura de 32 bits, por lo que en un futuro u hoy en día programar en arquitectura de 32 bits ya no es estandar.

Este lenguaje de programación es compatible en Sistemas Operativos como Windows y Linux. (Como escritor lo estoy programando y trabajando sobre un sistema Linux)

## Ensamblador y secciones del mismo ##
Un programa de ensamblador es dividido en tres secciones

* Sección data
* Sección bss
* Sección text

### Seccion data ###

Es usado para declarar constantes o datos inicializados. Estos datos no cambian durante la ejecución. Se puede declarar varios valores constantes, nombre de archivo, tamaño de un buffer, entre otras cosas.

La sintaxis para declarar la seccion de data es:
```nasm
  section.data
```
### Sección bss ###

Es usado para declarar variables.

La sintaxis para declarar la seccion de bss es:
```nasm
  section.bss
```
### Sección text ###
Es usado para guardar el código actual. Esa sección debe comenzar con la declaración __global _start__, la cual le dice al kernel donde comienza la ejecución del programa.

La sintaxis para declarar la seccion de text es:
```nasm
  section.text
    global _start
  _start:
```
## Comentarios ##
Si bien esto puede ser o no relevante el como escribir comentarios en Nasm, es importante que la escritura de los mismos en ensamblador te ayudan mucho para saber que estas haciendo en el lenguaje.

```nasm
  ; Esto es un comentario en NASM
```
__Ejemplo__
```nasm
  add eaxm ebx  ; adds ebx a eax
```
## Declaración de Lenguaje Ensamblador ##
Los programas en lenguaje ensamblador constan de tres tipos de declaraciones
* Instrucciones o instrucciones ejecutables
* Directivas de ensamblador o pseudo-operaciones
* Macros

__Las Intrucciones ejecutables o simples Instrucciones__ le dicen al procesador que hacer. Cada instrucción consiste de un código de operación (opcode). Cada instrucción ejecutable genera una instrucción en lenguaje máquina.

__Las directivas de ensamblador o pseudo-operaciones__ le da información al ensamblador sobre los diversos aspectos del proceso de esamblaje. Estos no son ejecutables y no generan instrucciones en lenguaje máquina.

__Macros__ son básicamente un mecanismo de sustitución de texto.

## Sintaxis de declaraciones en Lenguaje Ensamblador ##
El formato del lenguaje es el siguiente:
```nasm
  [etiqueta]  menmonic  [orandos] [;comentarios]
```
Los campos en el corchetes son opcionales. Una instrucción básica tiene dos partes, la primera es el nombre de la instrucción (o la mnemonic), la cual se va a ejecutar, y la segunda son los operandos o los parametros del comando.

Siguiendo la receta de cocina, el ejemplo:
```nasm
  INC COUNT           ; Incrementa la variable de memoria COUNT

  MOV TOTAL, 48       ; Transfiere el valor 48 en la variable
                      ; de memoria

  ADD AH, BH          ; Add el contenido de el registro BH
                      ; al registro AH

  AND MASK1, 128      ; Realiza la operación and en la
                      ; variable MASK y 128

  ADD MARKS, 10       ; Add 10 a la variable MARK

  MOV AL, 10          ; Transfiere el valor 10 al registro AL
```

## Hola mundo ##
Un ejemplo claro del lenguaje ensamblador es el clasico Hola mundo:
```nasm
  section .text
    global _start       ; Debe ser usado para linkear el archivo

  _start:               ; Le dice a ld el punto de entrada
    mov     edx,len     ; Tamanio del mensaje
    mov     ecx,msg     ; Mensaje a escribir
    mov     ebx,1       ; Descriptor de archivo (stdout)
    mov     eax,4       ; Callsystem number (sys_write)
    int     0x80        ; Call kernel

    mov     eax,1       ; Callsystem number (sys_exit)
    int     0x80        ; Call kernel
  section .data
  msg db  "Hello, World!", 0xa  ; String de salida
  len equ $ - msg               ; Tamanio del string
```

## Compilar y linkear un programa Ensamblador en NASM ##
A continuación te muestro como se guarda un archivo en Nasm y como linkear el archivo para este se vuelva un binario

__Importante__
* El archivo de nasm es generalmente almacenado o guardado con la extensión .asm
* Verificar si el cursor/posición de la terminal es donde esta el archivo asm
* Para compilar se puede hacer lo siguiente:
```bash
  # Linux
  nasm -f elf <file>.asm
  # Salida de <file>.o
  # Procederemos a linkear
  ld -m elf_i386 <file>.o -s -o <nombre-binario>
```
## Segmentos de memoria ##
El modelo de memoria segmentada divide la memoria del sistema en grupos de segmentos independientes referenciados por punteros ubicados en el registro de segmento. Cada segmento se utiliza para contener un tipo de dato específico. Un segmento se utiliza para contener códigos de instrucciones, otro segmento almacena los elementos de datos y un tercer segmento mantiene la pila del programa.

Entonces:
*__Segmento de datos:__
** Es representado por _.data_ y por _.bss_.
*** La sección _.data_ se utiliza para declarar la región de memoria, donde los elementos datos se almacenan para el programa.
**** Esta sección no se puede expandir después de que se declaran los elementos de datos y permanece estática en todo el programa.
*** La sección _.bss_ también es una sección de memoria estática que contiene buffers para que los datos se declaren más tarde en el programa.
**** Esta memoria intermedia esta llena de ceros.
*__Segmento de código:__
** Es representado por _.text_.
*** Esto define un área en la memoria que almacena los códigos de instrucción.
**** Esta también es un área fija.
*__Pila__
** Este segmento contiene valores de datos pasados a funciones y procedimientos dentro del programa.
