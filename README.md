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

* __Segmento de datos:__
  * Es representado por _.data_ y por _.bss_.
    * La sección _.data_ se utiliza para declarar la región de memoria, donde los elementos datos se almacenan para el programa.
      * Esta sección no se puede expandir después de que se declaran los elementos de datos y permanece estática en todo el programa.
    * La sección _.bss_ también es una sección de memoria estática que contiene buffers para que los datos se declaren más tarde en el programa.
      * Esta memoria intermedia esta llena de ceros.
* __Segmento de código:__
  * Es representado por _.text_.
    * Esto define un área en la memoria que almacena los códigos de instrucción.
      * Esta también es un área fija.
* __Pila__
  * Este segmento contiene valores de datos pasados a funciones y procedimientos dentro del programa.
## Registros ##
El hecho de que se puedan realizar operaciones en el procesador implica el realizar un procesamiento de los datos. Estos datos ocasionalmente se pueden almacenar en memoria y se puede acceder a ellos desde un registro. Sin embargo, leer datos y almacenarlos en la memoria ralentiza el procesador, ya que implica procesos complicados de enviar la solicitud a través del bus de control y obtener los datos a través del mismo canal.

Para optimizar las operaciones del procesador, el mismo incluye algunas regiones de almacenamiento, llamados registros.

Los registros almacenan datos para su procesamiento sin tener que acceder a la memoria. El chip del procesador incorpora un número limitado de registros.

Existen 10 registros de procesador de 32 bits y 6 registros en la arquitectura IA-32. Estos registros están agrupados de la siguiente manera:

* Registros Generales.
  * Registros de Datos.
  * Registros de Apuntadores.
  * Registros de Índice.
* Registros de Control.
* Registros de Segmento.

### Registros de Datos ###
4 Registros de 32 bits son usados para Aritmética, Lógica y otras operaciones. Esos registros de 32 bits pueden ser usados de 3 maneras:
* Como un registro datos completo de 32 bits:
  * __EAX__
  * __EBX__
  * __ECX__
  * __EDX__
* Como registro a la mitad de capacidad, es decir 16 bits:
  * __AX__
  * __BX__
  * __CX__
  * __DX__
* Como registros de 6 bits:
  * __AH__
  * __AL__
  * __BH__
  * __BL__
  * __CH__
  * __CL__
  * __DH__
  * __DL__
Por lo que estos registros cuentan con un propósito especifico que es el siguiente:
* __AX__ siendo el acumulador primario, es usado en entrada/salida y en operaciones aritméticas. Un ejemplo de esto es realizar la operación Multiplicación que va a a ser almacenada en el registro _EAX_, _AX_ o _AL_ de acuerdo al tamaño de la operación.
* __BX__ es conocido como el registro base, ya que puede utilizarse para usar direccionamiento indexado.
* __CX__ es conocido como el registro contador, ya que los registros _ECX_, _CX_ almacenan el contador para bucles en operaciones iterativas.
* __DX__ es conocido como el registro de datos. También se utiliza en operaciones de entrada/salida.También se usa con el registro _AX_ junto con _DX_ para multiplicar y dividir operaciones que involucran valores grandes.
### Registros de Apuntadores ###
El registro de apuntadores son registros de 32 bits son:
* __EIP__
* __ESP__
* __EBP__

Y los registros correspondientes a 16 bits son:

* __IP__
* __SP__
* __BP__

De los cuales hay tres categorías de registros de apuntadores, los cuales son:
* __Apuntador de Instrucciones__ _Instruction Pointer (IP)_ El registro _IP_ de 16 bits almacena la dirección de desplazamiento de la siguiente instrucción que se ejecutara. _IP_ en asociación con el registro _CS_ (como _CS_: _IP_) proporciona la dirección completa de la instrucción actual en el segmento de código.
* __Apuntador de Pila__ _Stack Pointer (SP)_ El registro _SP_ de 16 bits provee el valor dentro de la pila de programa. _SP_ en asociación con el registro _SS_ (SS: SP) se refiere a la posición actual de los datos o la dirección dentro de la pila de programa.
* __Apuntador de Base__ _Base Pointer (BP)_ El registro _BS_ de 16 bits ayuda principalmente a hacer referencia a las variables de parámetro que se pasan a subrutina. La dirección en el registro _SS_ se combina con el desplazamiento en _BP_ para obtener la ubicación del parámetro. _BP_ también se puede combinar con los registros _DI_, _SI_ como registro base para direccionamiento especial.

### Registros de Índice ###
Los registros de índice 32 bits son:
* __ESI__
* __EDI__

Y los registros correspondientes a 16 bits son:
* __SI__
* __DI__

Son utilizados para un direccionamiento indexado y ocasionalmente se utiliza para para sumar y restar. Existen dos conjuntos de apuntadores de índice.
* __Índice de Origen__ _Source Index (SI)_ Se utilizan como índice de origen para una operación de cadenas.
* __Índice de Destino__ _Destination Index (DI)_ Se utilizan como índice de destino para una operación de cadenas.
### Registro de Control ###
El registro de apuntador de instrucción de 32 bits y el registro de banderas de 32 bits combinados se consideran registros de control.

Muchas instrucciones implican comparaciones y cálculos matemáticos y cambian el estado de las banderas y algunas otras instrucciones condicionales prueban el valor de estos indicadores de estado para llevar el flujo de control a otra ubicación.

Los bits de banderas más comunes es:
* __Bandera de Desbordamiento__ _Overflow Flag (OF)_ Indica que alguna operación aritmética supero los limites numéricos de lo cual seria superar el límite del bit más a la izquierda.
* __Bandera de Dirección__ _Direction Flag (DF)_ Determina la dirección para mover o evaluar datos de cadenas.
  * _DF=0_ La dirección de la cadena es de izquierda a derecha.
  * _DF=1_ La dirección de la cadena es de derecha a izquierda.
* __Bandera de Interrupción__ _Interruption Flag (IF)_ Determina si las interrupciones externas, como la entrada del teclado, u otras, deben ignorarse o procesarse. Deshabilita la interrupción externa cuando el valor es 0 y habilita las interrupciones cuando se establece en 1.
* __Bandera de Trampa__ _Tramp Flag (TF)_ Permite configurar el funcionamiento del procesador en modo de un solo paso. El programa DEBUG que usamos establece la bandera de trampa, por lo que podríamos recorrer la ejecución una instrucción a la vez.
* __Bandera de Signo__ _Sing Flag (SF)_ Estable el signo de una operación aritmética dado por el bit a la izquierda (bit más significativo) por lo que _0_ es un valor positivo y _1_ es un valor negativo.
* __Bandera Cero__ _Zero Flag (ZF)_ Esta bandera lo único que busca es encenderse en caso de que el resultado aritmetico sea cero _0_ es un valor cuyo resultado no es cero, _1_ es un valor cuyo resultado es cero.
* __Bandera Auxiliar de Acarreo__ _Auxiliary Carry Flag (AF)_ Contiene el acarreo del bit 3 al bit 4 después de una operación aritmética; utilizado para aritmética especializada. El AF se establece cuando una operación aritmética de 1 byte provoca un acarreo del bit 3 al bit 4.
* __Bandera de Paridad__ _Parity Flag (PF)_ Indica el número total de 1-bits en el resultado obtenido de una operación aritmética. Indica _1_ si es impar y _0_ si es par.
* __Bandera de Acarreo__ _Carry Flag (CF)_ Contiene el acarreo de 0 o 1 de un bit (bit más significativo) después de una operación aritmética. También almacena el contenido del último bit de una operación de cambio o rotación.

La tabla quedaría representada como:

| Bandera       |    |    |    |    | O  | D  | I | T | S | Z |   | A |   | P |   | C |
| ------------- | -- | -- | -- | -- | -- | -- | - | - | - | - | - | - | - | - | - | - |
| Número de bit | 15 | 14 | 13 | 12 | 11 | 10 | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
### Registros de Segmento ###
Los segmentos son áreas específicas en un programa para contener datos, código y pila. Hay tres segmentos principales:
* __Segmento de Código__ Contiene todas las instrucciones a ejecutar. Un registro de segmento de código de 16 bits o registro _CS_ almacena la dirección de inicio del segmento de código.
* __Segmento de Datos__ Contiene datos, constantes y áreas de trabajo. Un registro segmento de datos de 16 bits o registro _DS_ almacena la dirección de inicio del segmento de datos.
* __Segmento de Pila__ Contiene los datos y el retorno de direcciones de procedimientos o subrutinas. Se implementa como la estructura de datos Pila _(LIFO Last Input First Output)_.

Además de los registros DS, CS y SS, existen otros registros de segmento extra: ES (segmento extra), FS y GS, que proporcionan segmentos adicionales para almacenar datos.

__Un ejemplo de uso de registros en general puede ser el siguiente:__
```nasm
  section .text
    global _start                 ; Comienzo del header para linkear y funcione

  _start:                         ; Inicio
    mov edx,  len                 ; Tamanio de la salida
    mov ecx,  msg                 ; Mensaje a escribir
    mov ebx,  1                   ; Descriptor de archivo (stdout)
    mov eax,  4                   ; Callsystem (sys_write)
    int 0x80                      ; Call kernel

    mov edx,  9                   ; Tamanio de la salida
    mov ecx,  s2                  ; Mensaje a escribir
    mov ebx,  1                   ; Descriptor de archivo (stdout)
    mov eax,  4                   ; Callsystem (sys_write)
    int 0x80                      ; Call kernel
    mov     eax,1                 ; Callsystem number (sys_exit)
    int     0x80                  ; Call kernel
  section .data
    msg db  "Display 9 estrellas",0xa ; Mensaje
    len equ $ - msg                   ; Tamanio de msg
    s2  times 9 db  "*"               ; 9 veces *
```
## Llamadas al Sistema ##
Ahora bien el saber y conocer acerca de algunas llamadas al sistemas. Estas llamadas siguen diversos pasos necesarios para poder escribir, leer, abrir o cerrar descriptores de archivos.

__Pasos a seguir para realizar llamadas a sistema__
* Poner el número de la llamada al sistema en el registro _EAX_.
* Almacena los argumentos de la llamada al sistema con los registros _EBX_, _ECX_, etc.
* Llama la interrupción de sistema _0x80_.
* El valor de retorno es almacenado generalmente en el registro _EAX_.

Las llamadas al sistema utilizan seis registros que almacenan los argumentos. Estos son _EBX_, _ECX_, _EDX_, _ESI_, _EDI_ y _EBP_. Estos registros toman un argumento consecutivo, es decir, al inicio _EAX_ obtiene la llamada a sistema de lo que necesita ejecutar el programa, consecutivamente obtiene el argumento _EBX_, posteriormente si hay más argumentos se sigue consecutivamente a _ECX_ y así hasta _EDI_.

__Ejemplo de la llamada sys\_exit__
```nasm
  mov eax,  1         ; Callsystem (sys_exit)
  int 0x80            ; Call kernel
```
__Ejempo de la llamada sys\_write__
```nasm
  mov edx,  4         ; Tamanio del mensaje
  mov ecx,  msg       ; Mensaje
  mov ebx,  1         ; Descriptor de archivo (stdout)
  mov eax,  4         ; Callsystem (sys_write)
  int 0x80            ; Call kernel
```
Todas las llamadas al sistema se enumeran en _/usr/include/asm/unistd.h_ junto a su valor numérico, este valor se pone en el registro _EAX_, la estructura es la siguiente:

| _EAX_ | Nombre    | _EBX_ | _ECX_ | _EDX_ | _ESX_ | _EDI_ |
| ----- | ------    | ----- | ----- | ----- | ----- | ----- |
|   1   | sys\_exit | int   |       |       |       |       |
|   2   | sys\_fork | struct pt_reg |       |       |       |       |
|   3   | sys\_read | unsigned int | char * | size_t |   |   |
|   4   | sys\_write | unsigned int | const char * | size_t |   |   |
|   5   | sys\_open | const char * | int | int |    |    |
|   6   | sys\_close | int   |       |       |       |       |

__Ejemplo de uso de llamadas al sistema__
```nasm
  section .data
    usrMsg  db  "Por favor ingresa un número: "     ; Mensaje 1
    lUsr  equ $-usrMsg                              ; Tamanio de mensaje 1
    dispMsg db  "Número ingresado: "                ; Mensaje 2
    lDisp equ $-dispMsg                             ; Tamanio de mensaje 2

  section .bss                                      ; Variables
    num resb  5

  section .text
    global _start

  _start:
  ; Para escribir seguiremos la receta de sys_write, tipo_salida(stdout), cons_char*, size_t
    mov eax,  4                                     ; sys_write
    mov ebx,  1                                     ; stdout
    mov ecx,  usrMsg                                ; Mensaje
    mov edx,  lUsr                                  ; Tamanio mensaje
    int 0x80                                        ; Call kernel

  ; Almacenaremos la lectura de teclado.
    mov eax,  3                                     ; sys_read
    mov ebx,  2                                     ; stdin
    mov ecx,  num                                   ; Lectura en num
    mov edx,  5                                     ; 5 bytes 1 de signo
    int 0x80                                        ; Call kernel

  ; Mostrar el segundo mensaje
    mov eax,  4                                     ; sys_write
    mov ebx,  1                                     ; stdout
    mov ecx,  dispMsg                               ; Mensaje
    mov edx,  lDisp                                 ; Tamanio mensaje
    int 0x80                                        ; Call kernel

  ; Mostrar el valor de lectura
    mov eax,  4                                     ; sys_write
    mov ebx,  1                                     ; stdout
    mov ecx,  num                                   ; Mensaje
    mov edx,  5                                     ; Tamanio mensaje
    int 0x80                                        ; Call kernel

  ; Salida del programa correctamente 0
    mov eax,  1                                     ; sys_exit
    mov ebx,  0                                     ; exit 0;
    int 0x80
```
