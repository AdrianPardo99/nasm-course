# Tutorial de sintaxis NASM
NASM es un lenguaje de bajo nivel, tambien conocido como lenguaje ensamblador, en el cual cuenta con un set de instrucciones el cual interactua directamente con la arquitectura del procesador y con el sistema operativo, por otro lado NASM es un lenguaje de arquitectura de 32 bits, por lo que en un futuro u hoy en día programar en arquitectura de 32 bits ya no es estandar.

Este lenguaje de programación es compatible en Sistemas Operativos como Windows y Linux. (Como escritor lo estoy programando y trabajando sobre un sistema Linux)

## Ensamblador y secciones del mismo
Un programa de ensamblador es dividido en tres secciones

* Sección data
* Sección bss
* Sección text

### Sección data

Es usado para declarar constantes o datos inicializados. Estos datos no cambian durante la ejecución. Se puede declarar varios valores constantes, nombre de archivo, tamaño de un buffer, entre otras cosas.

La sintaxis para declarar la sección de data es:
```nasm
  section .data
```
### Sección bss

Es usado para declarar variables.

La sintaxis para declarar la sección de bss es:
```nasm
  section .bss
```
### Sección text
Es usado para guardar el código actual. Esa sección debe comenzar con la declaración __global _start__, la cual le dice al kernel donde comienza la ejecución del programa.

La sintaxis para declarar la sección de text es:
```nasm
  section .text
    global _start
  _start:
```
## Comentarios
Si bien esto puede ser o no relevante el como escribir comentarios en Nasm, es importante que la escritura de los mismos en ensamblador te ayudan mucho para saber que estas haciendo en el lenguaje.

```nasm
  ; Esto es un comentario en NASM
```
__Ejemplo__
```nasm
  add eax ebx  ; adds ebx a eax
```
## Declaración de Lenguaje Ensamblador
Los programas en lenguaje ensamblador constan de tres tipos de declaraciones
* Instrucciones o instrucciones ejecutables
* Directivas de ensamblador o pseudo-operaciones
* Macros

__Las Intrucciones ejecutables o simples Instrucciones__ le dicen al procesador que hacer. Cada instrucción consiste de un código de operación (opcode). Cada instrucción ejecutable genera una instrucción en lenguaje máquina.

__Las directivas de ensamblador o pseudo-operaciones__ le da información al ensamblador sobre los diversos aspectos del proceso de esamblaje. Estos no son ejecutables y no generan instrucciones en lenguaje máquina.

__Macros__ son básicamente un mecanismo de sustitución de texto.

## Sintaxis de declaraciones en Lenguaje Ensamblador
El formato del lenguaje es el siguiente:
```nasm
  [etiqueta]  menmonic  [operandos] [;comentarios]
```
Los campos en el corchetes son opcionales. Una instrucción básica tiene dos partes, la primera es el nombre de la instrucción (o la menmonic), la cual se va a ejecutar, y la segunda son los operandos o los parametros del comando.

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

## Hola mundo
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

## Compilar y linkear un programa Ensamblador en NASM
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
## Segmentos de memoria
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
## Registros
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

### Registros de Datos
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
### Registros de Apuntadores
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

### Registros de Índice
Los registros de índice 32 bits son:
* __ESI__
* __EDI__

Y los registros correspondientes a 16 bits son:
* __SI__
* __DI__

Son utilizados para un direccionamiento indexado y ocasionalmente se utiliza para para sumar y restar. Existen dos conjuntos de apuntadores de índice.
* __Índice de Origen__ _Source Index (SI)_ Se utilizan como índice de origen para una operación de cadenas.
* __Índice de Destino__ _Destination Index (DI)_ Se utilizan como índice de destino para una operación de cadenas.
### Registro de Control
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

| Bandera       |  _X_  | _X_   | _X_   | _X_   | O  | D  | I | T | S | Z |  _X_ | A | _X_  | P | _X_  | C |
| ------------- | -- | -- | -- | -- | -- | -- | - | - | - | - | - | - | - | - | - | - |
| Número de bit | 15 | 14 | 13 | 12 | 11 | 10 | 9 | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |


__X__: Sin uso
### Registros de Segmento
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
## Llamadas al Sistema
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
__Ejemplo de la llamada sys\_write__
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
## Modos de direccionamiento
La mayoría de las instrucciones requieren que se procesen operandos. Una dirección de operando proporciona la ubicación, donde se almacenan los datos a procesar. Algunas instrucciones no requieren un operando, mientras que otras instrucciones pueden requerir uno, dos o tres operandos.

Cuando una instrucción requiere dos operandos, el primer operando es generalmente el destino, que contiene datos en un registro o ubicación de memoria y el segundo operando es la fuente. La fuente contiene los datos a entregar (__direccionamiento inmediato__) o la dirección (__en el registro o en la memoria__) de los datos. Generalmente, los datos de origen permanecen inalterados después de la operación.

Existen 3 modos de direccionamiento:
* __Registro de Direcciones__
* __Direccionamiento Inmediato__
* __Direccionamiento de Memoria__

### Direccionamiento Inmediato
Una operando inmediato tiene un valor constante o una expresión. Cuando una instrucción con dos operandos usa direccionamiento inmediato, el primer operando puede ser un registro o una ubicación de memoria, y el segundo operando es una constante inmediata. El primer operando define la longitud de los datos.

__Ejemplo:__
```nasm
  BYTE_VALUE  bd  150 ; Un byte definido
  WORD_VALUE  bd  300 ; Una palabra definida
  ADD BYTE_VALUE, 65  ; Un operando inmediato de suma
  MOV AX, 0x45        ; Constante inmediata 0x45 es transferida a AX
```
### Direccionamiento de Memoria (Directo)
Cuando los operandos se especifican en el modo de direccionamiento de memoria, se requiere acceso directo a la memoria principal, generalmente al segmento de datos. Esta forma de abordar da como resultado un procesamiento de datos más lento. Para localizar la ubicación exacta de los datos en la memoria, necesitamos la dirección de inicio del segmento, que normalmente se encuentra en el registro __DS__ y un valor de compensación. Este valor de compensación también se denomina dirección efectiva.

En el direccionamiento de memoria directo, uno de los operandos se refiere a una ubicación de memoria y el otro operando hace referencia a un registro.

__Ejemplo:__
```nasm
  ADD BYTE_VALUE, DL  ; Agrega el registro en la ubicación de la memoria
  MOV BX, BYTE_VALUE  ; El operando de la memoria se agrega al registro
```
#### Direccionamiento de Compensación (Directa)#
Este modo de direccionamiento utiliza los operadores aritméticos para modificar una dirección. Por ejemplo, observe las siguientes definiciones que definen tablas de datos:

__Ejemplo:__
```nasm
  BYTE_TABLE  db  14, 15, 22, 45      ; Tabla de bytes
  WORD_TABLE  db  134, 345, 564, 123  ; Tabla de palabras
```
Las siguientes operaciones acceden a los datos de las tablas en la memoria en registros:
__Ejemplo:__
```nasm
  MOV CL, BYTE_TABLE[2]	  ; Obtiene el 3er elemento de la tabla de bytes
  MOV CL, BYTE_TABLE + 2	; Obtiene el 3er elemento de la tabla de bytes
  MOV CX, WORD_TABLE[3]	  ; Obtiene el 4to elemento de la tabla de palabras
  MOV CX, WORD_TABLE + 3	; Obtiene el 4to elemento de la tabla de palabras
```
### Direccionamiento de Memoria (Indirecto)
Este modo de direccionamiento utiliza la capacidad de la computadora de Segmento: direccionamiento de compensación . Generalmente, los registros base __EBX__, __EBP__ (o __BX__, __BP__) y los registros de índice (__DI__, __SI__), codificados entre corchetes para referencias de memoria, se utilizan para este propósito.

El direccionamiento indirecto se usa generalmente para variables que contienen varios elementos como matrices. La dirección de inicio de la matriz se almacena, digamos, en el registro __EBX__.

El siguiente fragmento de código muestra cómo acceder a diferentes elementos de la variable.
__Ejemplo__
```nasm
  MY_TABLE TIMES 10 DW 0  ; Aloja 10 pabras de 2 bytes cada una inicializada con 0
  MOV EBX, [MY_TABLE]     ; Direccionamiento efectivo de MY_TABLE a EBX
  MOV [EBX], 110          ; MY_TABLE[0] = 110
  ADD EBX, 2              ; EBX = EBX +2
  MOV [EBX], 123          ; MY_TABLE[1] = 123
```
### Instrucción MOV
__MOV__ se utiliza para mover datos de un espacio de almacenamiento a otro.

__Ejemplo:__
```nasm
  ; Estructura.
  MOV destino,  fuente
```
__Esta instrucción tiene las siguientes estructuras.__
```nasm
  MOV registro,  registro
  MOV registro,  valor-inmediato
  MOV memoria,   valor-inmediato
  MOV registro,  memoria
  MOV memoria,   registro
```
Destaquemos lo siguiente:
* Ambos operandos de _MOV_ deben ser del mismo tamaño
* El valor del operando fuente permanece sin cambios

En algunas ocasiones _MOV_ puede tener algunas ambigüedades, las cuales se pueden solucionarse si se usa un formato especifico de convención o el siguiente:
```nasm
  MOV  EBX, [MY_TABLE]  ; EBX=MY_TABLE[0]
  MOV  [EBX], 110	      ; MY_TABLE[0] = 110
```
No está claro si desea mover un equivalente en bytes o un equivalente en palabra del número 110. En tales casos, es aconsejable utilizar un especificador de tipo.

La siguiente tabla muestra algunos de los especificadores de tipo comunes:

| Especificador de tipo | Bytes |
| --------------------- | ----- |
|          BYTE         |   1   |
|          WORD         |   2   |
|         DWORD         |   4   |
|         QWORD         |   8   |
|         TBYTE         |  10   |

Un ejemplo de esta sección es la siguiente:
```nasm
  section .text
    global  _start

  _start:
    ; Escritura de Luis Slobotzky
    mov eax,  4
    mov ebx,  1
    mov ecx,  msg
    mov edx,  lMsg
    int 0x80

    mov [msg],  dword "Jose"

    ; Escritura de Jose Slobotzky
    mov eax,  4
    mov ebx,  1
    mov ecx,  msg
    mov edx,  lMsg
    int 0x80

    mov eax,  1
    mov ebx,  0
    int 0x80

  section .data
    msg db  "Luis Slobotzky ",0xA
    lMsg  equ $-msg
```
## Variables
NASM proporciona varias directivas definidas para reservar espacio de almacenamiento para variables. La directiva define ensamblador se utiliza para la asignación de espacio de almacenamiento. Se puede utilizar para reservar e inicializar uno o más bytes.

### Asignación de espacio de almacenamiento para datos inicializados
La sintaxis de la declaración de asignación de almacenamiento para datos inicializados es:
```nasm
  [variable]    directiva-definicion    valor-inicial   [,valor-inicial]...
```
Donde, variable es el identificador de cada espacio de almacenamiento. El ensamblador asocia un valor de compensación para cada nombre de variable definido en el segmento de datos.

Hay cinco formas básicas de la directiva define:

| Directiva | Propósito de definición | Bytes |
| --------- | ----------------------- | ----- |
|    DB     |         Bytes           |   1   |
|    DW     |         Palabras        |   2   |
|    DD     |       Palabra Doble     |   4   |
|    DQ     |       Palabra Cuádruple |   8   |
|    TB     |     Diez Bytes          |  10   |

__Ejemplo__
```nasm
  selection   DB  'y'
  numero		  DW  12345
  nNumero	    DW  -12345
  numeroG	    DQ  123456789
  real1	      DD  1.234
  real2	      DQ  123.456
```
Tenemos que considerar lo siguiente:
* Cada byte de carácter se almacena como su valor ASCII en hexadecimal. (Limite de 1 byte es hasta 0xFF)
* Cada valor decimal se convierte automáticamente a su equivalente binario de 16 bits y se almacena como un número hexadecimal.
* El procesador utiliza el orden de bytes little-endian.
* Los números negativos se convierten a su representación en complemento a 2
* Los números de coma flotante cortos y largos se representan utilizando 32 o 64 bits, respectivamente.
### Asignación de espacio de almacenamiento para datos no inicializados
Las directivas de reserva se utilizan para reservar espacio para datos no inicializados. Las directivas de reserva toman un solo operando que especifica el número de unidades de espacio que se reservarán. Cada define-directive tiene una reserve-directive relacionada.

Hay cinco formas básicas de la directiva de reserva:

| Directiva | Propósito de definición |
| --------- | ----------------------- |
|    RESB   |           Bytes         |
|    RESW   |           Palabras      |
|    RESD   |       Palabra Doble     |
|    RESQ   |       Palabra Cuadruple |
|    REST   |        10 Bytes         |

### Múltiples definiciones
Puede tener varias declaraciones de definición de datos en un programa.

__Ejemplo__
```nasm
  desc      DB  'Y'       ; ASCII de y = 0x79
  number1   DW  12345     ; 12345D = 0x3039
  number2   DD  12345679  ; 123456789D = 0x75BCD15
```
El ensamblador asigna memoria contigua para múltiples definiciones de variables.
### Múltiples inicializaciones
La directiva __TIMES__ permite múltiples inicializaciones con el mismo valor. Por ejemplo, una matriz denominada marcas de tamaño 9 se puede definir e inicializar a cero utilizando la siguiente declaración:

__Ejemplo__
```nasm
  marks  TIMES  9  DW  0
```
La directiva _TIMES_ es útil para definir matrices y tablas. El siguiente programa muestra 9 asteriscos en la pantalla:
```nasm
  section .data
    stars   times 9 db '*'
    lstars  equ $-stars
    endl  db  0x0A

  section	.text
    global  _start:

  _start:
    mov eax,  4
    mov ebx,  1
    mov ecx,  stars
    mov edx,  lstars
    int 0x80

    mov eax,  4
    mov ebx,  1
    mov ecx,  endl
    mov edx,  1
    int 0x80

    mov eax,  1
    mov ebx,  0
    int 0x80
```
## Constantes
El ensamblador de NASM tiene la utilidad de crear y definir constantes las cuales son utilizadas en la escritura de programas, por ello existen tres distintas formas las cuales son llamadas por disintas directivas del lenguaje siendo las siguientes:
* __EQU__
* __\%assing__
* __\%define__

### Directiva EQU
La directiva _EQU_ es usada para definir constantes las cuales comúnmente contienen números enteros.

__Estructura__
```nasm
  constant_name equ expresion-value
```
__Ejemplo__
```nasm
  total_muestra equ 100
```
Lo cual podemos usar este bloque de código de la siguiente forma:
```nasm
  mov ecx,  total_muestra
  cmp eax,  total_muestra
```
Otra forma de aplicar la directiva de _EQU_ es:
```nasm
  tam   equ 20
  largo equ 10
  area  equ tam*largo
```
Lo cual puede servir mucho para saber que _area_ contendrá un valor de 200.

__Un ejemplo programado puede ser el siguiente:__
```nasm
  section .data
    ; Definimos las salidas del programa std_out, std_in,
    ; sys_write, sys_exit
    stdout    equ 1
    stdin     equ 0
    sys_exit  equ 1
    sys_write equ 4

    ; Otros valores
    msg1  db  "Hola, saludos!",0x0A
    lmsg1 equ $-msg1
    msg2  db  "Bienvenido al mundo de",0x0A
    lmsg2 equ $-msg2
    msg3  db  "la programación en ensamblador desde Linux!",0x0A
    lmsg3 equ $-msg3
  section .text
    global  _start

  _start:
    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg1
    mov edx,  lmsg1
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg2
    mov edx,  lmsg2
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg3
    mov edx,  lmsg3
    int 0x80

    mov eax,  sys_exit
    mov ebx,  0
    int 0x80
```
### Directiva \%assing
Parecida a _EQU_ para definir un valor numérico, pero a diferencia de _EQU_, esta directiva permite realizar redefinición de los valores más adelante.

__Estructura__
```nasm
  %assing cons_name value
```
__Ejemplo__
```nasm
  %assing total 10
```
Más tarde durante la ejecución podremos modificarlo:
```nasm
  %assing total 20
```
_Nota:_ Esta directiva es sensitiva a mayúsculas y minúsculas.
### Directiva \%define
La directiva permite definir tanto constantes numéricas como de cadenas de caracteres. Esta directiva es similar a \#define en C.

__Estructura__
```nasm
  %define var_name  value
```
__Por ejemplo, puede definir la constante PTR como:__
```nasm
  %define PTR [EBP+4]
```
_Importante respecto al ejemplo y al código de ejemplo:_
* El código anterior reemplaza _PTR_ por [_EBP_ + 4].
* Esta directiva también permite la redefinición y distingue entre mayúsculas y minúsculas.

## Instrucciones Aritméticas
Estas instrucciones te permiten manipular operaciones en los registros y variables dependiendo el caso, por otro lado esto nos permite realizar operaciones las cuales ayudan a solucionar 1 o más problemas, sea el curioso ejemplo de una calculadora.

### Instrucción INC
La instrucción _INC_ se utiliza para incrementar un operando en uno. Funciona en un solo operando que puede estar en un registro o en la memoria.

__Estructura__
```nasm
  INC destino
```
El operando _destino_ puede ser de 8 bits, 16 bits o 32 bits.
__Ejemplo__
```nasm
  INC EBX   ; Incremento del registro de 32 bits
  INC DL    ; Incremento del registro de 8 bits
  INC [con] ; Incremento de la variable con
```
### Instrucción DEC
La instrucción _DEC_ se utiliza para reducir un operando en uno. Funciona en un solo operando que puede estar en un registro o en la memoria.

__Estructura__
```nasm
  DEC destino
```
Mismo caso que _INC_ el operando _destino_ puede ser de 8 bits, 16 bits o 32 bits.
__Ejemplo__
```nasm
  section .data
    coun  dw  0
    value dw  15

  section .text
    inc [coun]
    dec [value]

    mov ebx,  coun
    inc word  [ebx]

    mov esi,  value
    dec byte  [esi]
```
### Instrucción ADD y SUB
Las instrucciones _ADD_ y _SUB_ se utilizan para realizar una simple suma / resta de datos binarios en tamaño de byte, palabra y palabra doble, es decir, para sumar o restar operandos de 8, 16 o 32 bits, respectivamente.

__Estructura__
```nasm
  ADD destino,  fuente
  SUB destino,  fuente
```
Estas dos instrucciones pueden tener lugar entre:
* Registro a registro.
* Memoria a registro.
* Registro a memoria.
* Registro a dato/valor constante.
* Memoria a dato/valor constante.

Sin embargo, al igual que otras instrucciones, las operaciones de memoria a memoria no son posibles utilizando las instrucciones _ADD_ o _SUB_. Una operación de estas dos instrucciones establece o borra las banderas de desbordamiento y acarreo.

__Ejemplo__
```nasm
  ; El siguiente ejemplo pedirá dos dígitos al usuario,
  ; almacenará los dígitos en el registro EAX y EBX,
  ; respectivamente, sumará los valores, almacenará
  ; el resultado en una ubicación de memoria 'res'
  ; y finalmente mostrará el resultado.
  section .data
    ; Definimos las salidas del programa std_out, std_in,
    ; sys_write, sys_exit, sys_read
    stdout    equ 1
    stdin     equ 0
    sys_exit  equ 1
    sys_write equ 4
    sys_read  equ 3

    ; Otros valores constantes seran
    msg1  db  "Ingresa los primeros digitos: "
    lmsg1 equ $-msg1

    msg2  db  "Ingresa los siguientes digitos: "
    lmsg2 equ $-msg2

    msg3  db  "La suma es: "
    lmsg3 equ $-msg3

  section .bss
    n1  resb  2
    n2  resb  2
    r   resb  1

  section .text
    global  _start

  _start:
    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg1
    mov edx,  lmsg1
    int 0x80

    mov eax,  sys_read
    mov ebx,  stdin
    mov ecx,  n1
    mov edx,  2
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg2
    mov edx,  lmsg2
    int 0x80

    mov eax,  sys_read
    mov ebx,  stdin
    mov ecx,  n2
    mov edx,  2
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg3
    mov edx,  lmsg3
    int 0x80

    ; Primero usaremos mov para cada numero, despues
    ; Substraeremos el valor ascii '0' para convertir a decimal

    mov eax,  [n1]
    sub eax,  '0'

    mov ebx,  [n2]
    sub ebx,  '0'

    ; Despues haremos add eax, ebx
    add eax,  ebx

    ; Sumaremos '0'
    add eax,  '0'

    ; Almacenaremos en r
    mov [r],  eax

    ; Imprimiremos la suma:
    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  r
    mov edx,  1
    int 0x80

    mov eax,  sys_exit
    mov ebx,  0
    int 0x80
```
### Instrucción MUL e IMUL
Hay dos instrucciones para multiplicar datos binarios. La instrucción _MUL_ (Multiplicar) maneja datos sin firmar y la _IMUL_ (Multiplicar enteros) maneja datos firmados. Ambas instrucciones afectan a la bandera de transporte y desbordamiento.

__Estructura__
```nasm
  MUL   multiplicador
  IMUL  multiplicador
```
Multiplicando en ambos casos estará en un acumulador, dependiendo del tamaño del multiplicando y el multiplicador y el producto generado también se almacena en dos registros dependiendo del tamaño de los operandos. La siguiente sección explica las instrucciones _MUL_ con tres casos diferentes

1. __Cuando se multiplican dos bytes:__ El multiplicando está en el registro _AL_ y el multiplicador es un byte en la memoria o en otro registro. El producto está en _AX_. Los 8 bits de orden superior del producto se almacenan en _AH_ y los 8 bits de orden inferior se almacenan en _AL_.

![primera-aritmetica](./imgsReadme/arithmetic1.jpg)

2. __Cuando se multiplican dos valores de una palabra:__ El multiplicando debe estar en el registro _AX_ y el multiplicador es una palabra en la memoria u otro registro. Por ejemplo, para una instrucción como _MUL_ _DX_, debe almacenar el multiplicador en _DX_ y el multiplicando en _AX_. El producto resultante es una palabra doble, que necesitará dos registros. La parte de orden superior (más a la izquierda) se almacena en _DX_ y la parte de orden inferior (más a la derecha) se almacena en _AX_.

![segunda-aritmetica](./imgsReadme/arithmetic2.jpg)

3. __Cuando se multiplican dos valores de palabras dobles:__ Cuando se multiplican dos valores de dos palabras, el multiplicando debe estar en _EAX_ y el multiplicador es un valor de dos palabras almacenado en la memoria o en otro registro. El producto generado se almacena en los registros _EDX_: _EAX_, es decir, los 32 bits de orden superior se almacenan en el registro _EDX_ y los 32 bits de orden inferior se almacenan en el registro _EAX_.

![tercera-aritmetica](./imgsReadme/arithmetic3.jpg)

__Ejemplo explicito__
```nasm
  MOV AL, 10
  MOV DL, 25
  MUL DL
  ...
  MOV DL, 0FFH	; DL= -1
  MOV AL, 0BEH	; AL = -66
  IMUL DL
```
__Ejemplo__
```nasm
  section .data
    ; Definimos las salidas del programa std_out,
    ; sys_write, sys_exit,
    stdout    equ 1
    sys_exit  equ 1
    sys_write equ 4
    msg1  db  "Primer valor: "
    lmsg1 equ $-msg1

    msg2  db  "Segundo valor: "
    lmsg2 equ $-msg2

    msg3  db  "La multiplicación es: "
    lmsg3 equ $-msg3

    endl  db  0xA
    lndl  equ $-endl

    n1    db  '3'
    ln1   equ $-n1

    n2    db  '2'
    ln2   equ $-n2

  section .bss
    r resb  1

  section .text
    global  _start

  _start:
    mov al, '3'
    sub al, '0'

    mov bl, '2'
    sub bl, '0'

    mul bl
    add al, '0'

    mov [r],  al

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg1
    mov edx,  lmsg1
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  n1
    mov edx,  ln1
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  endl
    mov edx,  lndl
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg2
    mov edx,  lmsg2
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  n2
    mov edx,  ln2
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  endl
    mov edx,  lndl
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg3
    mov edx,  lmsg3
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  r
    mov edx,  1
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  endl
    mov edx,  lndl
    int 0x80

    mov eax,  sys_exit
    mov ebx,  0
    int 0x80
```
### Instrucción DIV e IDIV
La operación de división genera dos elementos: un _cociente_ y un _residuo_. En caso de multiplicación, no se produce un desbordamiento porque se utilizan registros de doble longitud para mantener el producto. Sin embargo, en caso de división, puede producirse un desbordamiento. El procesador genera una interrupción si se produce un desbordamiento.

La instrucción _DIV_ (Divide) se usa para datos sin firmar y el _IDIV_ (Integer Divide) se usa para datos firmados.

__Estructura__
```nasm
  DIV   divisor
  IDIV  divisor
```
El dividendo está en un acumulador. Ambas instrucciones pueden funcionar con operandos de 8, 16 o 32 bits. La operación afecta a los seis indicadores de estado. La siguiente sección explica tres casos de división con diferente tamaño de operando.
1. __Cuando el divisor es de 1 byte:__ Se supone que el dividendo está en el registro _AX_ (16 bits). Después de la división, el cociente va al registro _AL_ y el resto al registro _AH_.

![cuarta-aritmetica](./imgsReadme/arithmetic4.jpg)

2. __Cuando el divisor es 1 palabra:__ Se supone que el dividendo tiene una longitud de 32 bits y está en los registros _DX_: _AX_. Los 16 bits de orden superior están en _DX_ y los 16 bits de orden inferior están en _AX_. Después de la división, el cociente de 16 bits va al registro _AX_ y el resto de 16 bits al registro _DX_.

![quinta-aritmetica](./imgsReadme/arithmetic5.jpg)

3. __Cuando el divisor es doble palabra:__ Se supone que el dividendo tiene una longitud de 64 bits y está en los registros _EDX_: _EAX_. Los 32 bits de orden superior están en _EDX_ y los 32 bits de orden inferior están en _EAX_. Después de la división, el cociente de 32 bits va al registro _EAX_ y el resto de 32 bits va al registro _EDX_.

![sexta-aritmetica](./imgsReadme/arithmetic6.jpg)

__Ejemplo__
```nasm
  section .data
    ; Definimos las salidas del programa std_out,
    ; sys_write, sys_exit,
    stdout    equ 1
    sys_exit  equ 1
    sys_write equ 4
    msg1  db  "Primer valor: "
    lmsg1 equ $-msg1

    msg2  db  "Segundo valor: "
    lmsg2 equ $-msg2

    msg3  db  "La división es: "
    lmsg3 equ $-msg3

    endl  db  0xA
    lndl  equ $-endl

    n1    db  '8'
    ln1   equ $-n1

    n2    db  '2'
    ln2   equ $-n2

  section .bss
    r resb  1

  section .text
    global  _start

  _start:
    mov al, '8'
    sub al, '0'

    mov bl, '2'
    sub bl, '0'

    div bl
    add ax, '0'

    mov [r],  al

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg1
    mov edx,  lmsg1
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  n1
    mov edx,  ln1
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  endl
    mov edx,  lndl
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg2
    mov edx,  lmsg2
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  n2
    mov edx,  ln2
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  endl
    mov edx,  lndl
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg3
    mov edx,  lmsg3
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  r
    mov edx,  1
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  endl
    mov edx,  lndl
    int 0x80

    mov eax,  sys_exit
    mov ebx,  0
    int 0x80
```
## Instrucciones Lógicas
El mismo procesador _x86_ que nos provee un set de instrucciones aritméticas, este igual nos puede proveer instrucciones que trabajan a nivel de bits y están son el set de instrucciones lógicas, las cuales son las siguientes:

| Instrucción | Formato |
| ----------- | ------- |
| _AND_       | _AND_ operando1, operando2 |
| _OR_        | _OR_ operando1, operando2 |
| _XOR_       | _XOR_ operando1, operando2 |
| _TEST_      | _TEST_ operando1, operando2 |
| _NOT_       | _NOT_ operando1 |

El primer operando en todos los casos podría estar en registro o en memoria. El segundo operando podría estar en el registro / memoria o en un valor inmediato (constante). Sin embargo, las operaciones de memoria a memoria no son posibles. Estas instrucciones comparan o hacen coincidir bits de los operandos y establecen las banderas _CF_, _OF_, _PF_, _SF_ y _ZF_.

### Instrucción AND
Al igual que un sistema digital esta realiza la operación bit a bit y después este almacena su resultado en el primer registro de la operación:

| Operandos | Valor en decimal | Valor binario |
| --------- | ---------------- | ------------- |
| Operando1 | 5                | 0101 |
| Operando2 | 3                | 0011 |
| Operando1 | 1                | 0001 |

Como podemos ver que al final de la operación el Operando1 en este caso podemos pensar en algún registro, es modificado de modo en que ahí se almacena los datos de la operación final.


Otros usos de la misma instrucción AND para la eliminación de bits o algunas otras operaciones, por ejemplo tenemos un valor N representado con la secuencia _xxxx xxxx_ y queremos comprobar si ese mismo valor es un valor potencia de <img src="https://render.githubusercontent.com/render/math?math=2^{M}"> donde _M_ es el valor entero de los bits que usa dicho valor, para ello podremos hacer lo siguiente
```nasm
  ; Ya con todo lo demas de los global previamente colocados
  mov al, 0x8
  mov bl, 0x8
  sub bl, 0x1
  and al, bl
  ; Por lo que sabemos que al hacer esta operación obtendremos
  ; 0 si el valor de N es una potencia de 2 por ejemplo este caso
```
Aplicando esta idea en registros y programado el programa quedaría como el siguiente:
```nasm
  ; El siguiente ejemplo pedirá un dígito al usuario,
  ; almacenará los dígitos en el registro EAX y EBX,
  ; respectivamente, and a los valores, almacenará
  ; el resultado en una ubicación de memoria 'res'
  ; y finalmente mostrará el resultado.
  section .data
    ; Definimos las salidas del programa std_out, std_in,
    ; sys_write, sys_exit, sys_read
    stdout    equ 1
    stdin     equ 0
    sys_exit  equ 1
    sys_write equ 4
    sys_read  equ 3

    ; Otros valores constantes seran
    msg1  db  "Ingresa el primer digito: "
    lmsg1 equ $-msg1

    msg3  db  "Es un valor potencia 2: "
    lmsg3 equ $-msg3

    msg2 db   0x0A,"Si es un valor 0 es un valor potencia 2",0x0A
    lmsg2 equ $-msg2

  section .bss
    n1  resb  2
    r   resb  1

  section .text
    global  _start

  _start:
    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg1
    mov edx,  lmsg1
    int 0x80

    mov eax,  sys_read
    mov ebx,  stdin
    mov ecx,  n1
    mov edx,  2
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg3
    mov edx,  lmsg3
    int 0x80

    ; Primero usaremos mov para cada numero, despues
    ; Substraeremos el valor ascii '0' para convertir a decimal

    mov eax,  [n1]
    sub eax,  '0'

    mov ebx,  [n1]
    sub ebx,  '0'
    sub ebx, 0x01

    ; Despues haremos and eax, ebx
    and eax,  ebx

    ; Sumaremos '0'
    add eax,  '0'

    ; Almacenaremos en r
    mov [r],  eax

    ; Imprimiremos la operación and:
    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  r
    mov edx,  1
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg2
    mov edx,  lmsg2
    int 0x80

    mov eax,  sys_exit
    mov ebx,  0
    int 0x80
```
### Intrucciones OR, XOR, NOT
Para el caso de estas operaciones realizan las mismas operaciones bit a bit en las cuales el _operando1_ es el que se ve modificado de acuerdo a lo que este pueda necesitar.

__OR__
```nasm
  mov eax,  0x05
  mov ebx,  0x02
  or  eax,  ebx
  ; Resultado de la operación:
  ; 0101 or 0010 = 0111 <=> 7
```
__XOR__
```nasm
  mov eax,  0x05
  mov ebx,  0x03
  xor  eax,  ebx
  ; Resultado de la operación:
  ; 0101 xor 0011 = 0100 <=> 4
```
__NOT__
```nasm
  mov eax,  0x05
  not eax
  ; Resultado de la operación
  ; not 0101 = 1010 <=> 0xFF 0xFF 0xFF 0xFA
  ;   por el tamaño del registro 32 bits o 4 bytes
```
### Instrucción TEST
La instrucción TEST funciona igual que la operación AND, pero a diferencia de la instrucción AND, no cambia el primer operando. Entonces, si necesitamos verificar si un número en un registro es par o impar, también podemos hacerlo usando la instrucción TEST sin cambiar el número original.
## Condicionales
La ejecución condicional en lenguaje ensamblador se logra mediante varias instrucciones de bucle y ramificación. Estas instrucciones pueden cambiar el flujo de control en un programa. La ejecución condicional se observa en dos escenarios:

| Tipo de condicional | Descripción |
| ------------------- | ----------- |
| Salto incondicional | Esto se realiza mediante la instrucción JMP. La ejecución condicional a menudo implica una transferencia de control a la dirección de una instrucción que no sigue la instrucción que se está ejecutando actualmente. La transferencia de control puede ser hacia adelante, para ejecutar un nuevo conjunto de instrucciones o hacia atrás, para volver a ejecutar los mismos pasos. |
| Salto condicional   | Esto se realiza mediante un conjunto de instrucciones de salto j condición dependiendo de la condición. Las instrucciones condicionales transfieren el control rompiendo el flujo secuencial y lo hacen cambiando el valor de compensación en IP. |

Por ello analizaremos la instrucción CMP.
### Instrucción CMP
La instrucción CMP compara dos operandos. Generalmente se usa en ejecución condicional. Esta instrucción básicamente resta un operando del otro para comparar si los operandos son iguales o no. No perturba los operandos de origen o destino. Se utiliza junto con la instrucción de salto condicional para la toma de decisiones.

__Sintaxis__
```nasm
  cmp destino, fuente
```
CMP compara dos campos de datos numéricos. El operando de destino puede estar en el registro o en la memoria. El operando de origen podría ser un registro, memoria o datos constantes (inmediatos).
__Ejemplo__
```nasm
  cmp DX, 00  ; Compara DX con el valor 0
  JE  L7      ; Si es real, salta a L7
  ; .
  ; .
  ; .
  L7: ; ...
```
CMP se utiliza a menudo para comparar si un valor de contador ha alcanzado el número de veces que se debe ejecutar un bucle. Considere la siguiente condición típica
```nasm
  INC	EDX
  CMP	EDX, 10	; Compara si el valor EDX esta en 10
  JLE	LP1     ; Si es menor igual a 10, salta a LP1
```
### Saltos incondicionales
Como se mencionó anteriormente, esto se realiza mediante la instrucción JMP. La ejecución condicional a menudo implica una transferencia de control a la dirección de una instrucción que no sigue la instrucción que se está ejecutando actualmente. La transferencia de control puede ser hacia adelante, para ejecutar un nuevo conjunto de instrucciones o hacia atrás, para volver a ejecutar los mismos pasos.

__Sintaxis__
```nasm
  JMP Etiqueta
```
__Ejemplo__
```nasm
  L1:
  ; Código y más código
  ; .
  ; .
  ; .
  JMP L1
```
### Saltos condicionales
Para estos casos el auxiliar _CMP_ puede realizar diversas operaciones de salto, por ello existen las siguientes instrucciones:

__A continuación se muestran las instrucciones de salto condicional que se utilizan en datos con signo utilizados para operaciones aritméticas__

| Instrucción | Descripción | Banderas |
| ----------- | ----------- | -------- |
| _JE_ / _JZ_ | Salta si es igual / Salta si es cero | _ZF_ |
| _JNE_ / _JNZ_ | Salta si es distinto / Salta si es distinto de cero | _ZF_ |
| _JG_ / _JNLE_ | Salta si es estrictamente mayor / Salta si no es menor o igual | _OF_, _SF_, _ZF_ |
| _JGE_ / _JNL_ | Salta si es mayor o igual / Salta si no es estrictamente menor | _OF_, _SF_ |
| _JL_ / _JNGE_ | Salta si es estrictamente menor / Salta si no es mayor o igual | _OF_, _SF_ |
| _JLE_ / _JNG_ | Salta si es menor o igual / Salta si no es estrictamente mayor | _OF_, _SF_, _ZF_ |

__A continuación se muestran las instrucciones de salto condicional que se utilizan en datos sin firmar utilizados para operaciones lógicas__

| Instrucciones | Descripción | Banderas |
| ------------- | ----------- | -------- |
| _JE_ / _JZ_ | Salta si es igual / Salta si es cero | _ZF_ |
| _JNE_ / _JNZ_ | Salta si es distinto / Salta si es distinto de cero | _ZF_ |
| _JA_ / _JNBE_ | Salta encima / Salta no por debajo o igual | _CF_, _ZF_ |
| _JAE_ / _JNB_ | Salta encima o igual / Salta no por debajo | _CF_ |
| _JB_ / _JNAE_ | Salta debajo / Salta no por encima o igual | _CF_ |
| _JBE_ / _JNA_ | Salta debajo o igual / Salta no por encima | _AF_, _CF_ |

__Las siguientes instrucciones de salto condicional tienen usos especiales y verifican el valor de las banderas__

| Instrucciones | Descripción | Banderas |
| ------------- | ----------- | -------- |
|   _JXCZ_      | Salta si _CX_ es cero | Ninguna |
|   _JC_        | Salta si Carry        | _CF_ |
|   _JNC_       | Salta sino Carry      | _CF_ |
|   _JO_        | Salta si Overflow     | _OF_ |
|   _JNO_       | Salta sino Overflow   | _OF_ |
| _JP_ / _JPE_  | Salta si Paridad / Salta si Paridad par | _PF_ |
| _JNP_ / _JPO_ | Salta si no Paridad / Salta si Paridad impar | _PF_ |
|   _JS_        | Salta si Signo (Valor negativo) | _SF_ |
|   _JNS_       | Salta sino Signo (Valor positivo) | _SF_ |

## Ciclos
Muchas veces podemos utilizar las instrucciones _JMP_ para realizar diversos ciclos de una condición especifica.

__Ejemplo__
```nasm
  mov CL, 10 ; Valor limite
  L1:
    ; Cuerpo de todo el código
    DEC CL  ; Decrementa en 1 el registro CL
    JNZ L1  ; Verifica si el registro CL es 0
```
Pero alternamente el procesador nos otorga una instrucción llamada: _LOOP_ que influye mucho para lo que conocemos como iteración de las instrucciones.

__Sintaxis__
```nasm
  loop etiqueta
```

Donde, __etiqueta__ es la etiqueta de destino que identifica la instrucción de destino como en las instrucciones de salto. La instrucción _LOOP_ asume que el registro _ECX_ contiene el recuento de bucles. Cuando se ejecuta la instrucción de bucle, el registro _ECX_ disminuye y el control salta a la etiqueta de destino, hasta que el valor del registro _ECX_, es decir, el contador alcanza el valor cero.

__Ejemplo__
```nasm
section .data
  ; Definimos las salidas del programa std_out, std_in,
  ; sys_write, sys_exit, sys_read
  std_out    equ 1
  std_in     equ 0
  sys_exit  equ 1
  sys_write equ 4
  sys_read  equ 3

  endl  db  0x0A
  lendl equ $endl

section .bss

  n1  resb  1

section .text
  global  _start

_start:
  mov ecx,  10
  mov eax,  '1'

l1:
  mov   [n1], eax
  mov   eax,  sys_write
  mov   ebx,  std_out
  push  ecx

  mov   ecx,  n1
  mov   edx,  1
  int   0x80

  mov   eax,  [n1]
  sub   eax,  '0'
  inc   eax
  add   eax,  '0'
  pop   ecx
  loop  l1
  ; end line
  mov   eax,  sys_write
  mov   ebx,  std_out
  mov   ecx,  endl
  mov   edx,  lendl
  int 0x80
  ; bye bye
  mov eax,  sys_exit
  mov ebx,  0
  int 0x80
```
## Números
Los datos numéricos generalmente se representan en sistema binario. Las instrucciones aritméticas operan sobre datos binarios. Cuando los números se muestran en la pantalla o se ingresan desde el teclado, están en formato ASCII.

Hasta ahora, hemos convertido estos datos de entrada en formato ASCII a binarios para cálculos aritméticos y hemos vuelto a convertir el resultado a binario.

Sin embargo, tales conversiones tienen una sobrecarga y la programación en lenguaje ensamblador permite procesar números de una manera más eficiente, en forma binaria. Los números decimales se pueden representar de dos formas:

* ASCII
* BCD (Binary Coded Decimal) (Decimal Codificado en Binario)

### Forma ASCII
En la representación ASCII, los números decimales se almacenan como una cadena de caracteres ASCII.

__Ejemplo__
```nasm
  1234
  ; Es equivalente a
  0x31	0x32	0x33	0x34
```
Hay cuatro instrucciones para procesar números en representación ASCII:
* AAA - Ajuste ASCII después de la adición
* AAS - Ajuste ASCII después de la sustracción
* AAM - Ajuste ASCII después de la multiplicación
* AAD - Ajuste ASCII antes de la división

Para realizar estas operaciones es necesario almacenar los datos en el registro _AL_

Un ejemplo aplicado de esto seria:
```nasm
; El siguiente ejemplo pedirá dos dígitos al usuario,
; respectivamente, restara los valores, almacenará
; el resultado en una ubicación de memoria 'r'
; y finalmente mostrará el resultado.
section .data
  ; Definimos las salidas del programa std_out, std_in,
  ; sys_write, sys_exit, sys_read
  stdout    equ 1
  stdin     equ 0
  sys_exit  equ 1
  sys_write equ 4
  sys_read  equ 3

  ; Otros valores constantes seran
  msg1  db  "Ingresa el primer digito: "
  lmsg1 equ $-msg1

  msg2  db  "Ingresa los siguiente digito: "
  lmsg2 equ $-msg2

  msg3  db  "La resta es: "
  lmsg3 equ $-msg3

section .bss
  n1  resb  2
  n2  resb  2
  r   resb  1

section .text
  global  _start

_start:
  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  msg1
  mov edx,  lmsg1
  int 0x80

  mov eax,  sys_read
  mov ebx,  stdin
  mov ecx,  n1
  mov edx,  2
  int 0x80

  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  msg2
  mov edx,  lmsg2
  int 0x80

  mov eax,  sys_read
  mov ebx,  stdin
  mov ecx,  n2
  mov edx,  2
  int 0x80

  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  msg3
  mov edx,  lmsg3
  int 0x80

  mov al,  [n1]

  mov bl,  [n2]
  sub al,   bl
  aas
  or  al,   0x30


  ; Almacenaremos en r
  mov [r],  ax

  ; Imprimiremos la suma:
  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  r
  mov edx,  1
  int 0x80

  mov eax,  sys_exit
  mov ebx,  0
  int 0x80
```
Pero esto solo permite trabajar con 1 solo dato por ello es mejor usar otro tipo de codificación que es la BCD para transformar nuestro string a un valor decimal.

### Forma BCD
Hay dos tipos de representación BCD:

* Representación BCD desempaquetada
* Representación BCD empaquetada

_Representación desempaquetada:_ cada byte almacena el equivalente binario de un dígito decimal.

__Ejemplo__
```nasm
  ; Con los números
  1234
  ; Es almacenado como:
  0x01 0x02 0x03 0x04
```
Hay dos instrucciones para procesar estos números

* AAM - Ajuste ASCII después de la multiplicación
* AAD - Ajuste ASCII antes de la división

Las cuatro instrucciones de ajuste ASCII, AAA, AAS, AAM y AAD, también se pueden utilizar con la representación BCD descomprimida. En la representación BCD empaquetada, cada dígito se almacena utilizando cuatro bits. Se empaquetan dos dígitos decimales en un byte.

__Ejemplo__
```nasm
  ; Con los números
  12
  ; Estos dos dígitos son representados
  0x34
```

Hay dos instrucciones para procesar estos números:

* DAA - Ajuste decimal después de la adición
* DAS − decimal Adjust After Subtraction

No hay soporte para multiplicación y división en representación BCD empaquetada.

## Strings (Cadenas de texto)

Ya hemos utilizado cadenas de longitud variable en nuestros ejemplos anteriores. Las cadenas de longitud variable pueden tener tantos caracteres como sea necesario. Generalmente, especificamos la longitud de la cadena por cualquiera de las siguientes dos formas:

* Almacenamiento explicito de nuestra cadena de datos
* Usando un centinela

Podemos almacenar la longitud de la cadena de forma explícita utilizando el símbolo de contador de ubicación $ que representa el valor actual del contador de ubicación.
__Ejemplo__
```nasm
  msg1  db  "Ingresa el primer digito: "
  lmsg1 equ $-msg1
```
Esto tiene un significado sencillo en el que se interpreta como:
```nasm
  msg1  db  "Ingresa el primer digito: "
  lmsg1 equ 26
```
Alternativamente, puede almacenar cadenas con un carácter centinela final para delimitar una cadena en lugar de almacenar la longitud de la cadena explícitamente. El carácter centinela debe ser un carácter especial que no aparezca dentro de una cadena.

__Ejemplo__
```nasm
  msg1 db "Ingresa el primer digito: ",0
```

Entonces con esto procederemos a realizar las siguientes operaciones o a su análisis.

### Instrucciones de String

Cada instrucción de cadena puede requerir un operando de origen, un operando de destino o ambos. Para segmentos de 32 bits, las instrucciones de cadena utilizan registros _ESI_ y _EDI_ para apuntar a los operandos de origen y destino, respectivamente.

Sin embargo, para los segmentos de 16 bits, los registros _SI_ y _DI_ se utilizan para apuntar al origen y al destino, respectivamente. Hay cinco instrucciones básicas para procesar cadenas.

* _MOVS_: esta instrucción mueve 1 byte, palabra o palabra doble de datos de una ubicación de memoria a otra.
* _LODS_: esta instrucción se carga desde la memoria. Si el operando es de un byte, se carga en el registro _AL_, si el operando es una palabra, se carga en el registro _AX_ y se carga una palabra doble en el registro _EAX_.
* _STOS_: esta instrucción almacena datos del registro (_AL_, _AX_ o _EAX_) en la memoria.
* _CMPS_: esta instrucción compara dos elementos de datos en la memoria. Los datos pueden tener un tamaño de byte, palabra o palabra doble.
* _SCAS_: esta instrucción compara el contenido de un registro (_AL_, _AX_ o _EAX_) con el contenido de un elemento en la memoria.

Cada una de las instrucciones anteriores tiene una versión de byte, palabra y palabra doble, y las instrucciones de cadena se pueden repetir utilizando un prefijo de repetición.

Estas instrucciones utilizan el par de registros _ES_: _DI_ y _DS_: _SI_, donde los registros _DI_ y _SI_ contienen direcciones de compensación válidas que se refieren a bytes almacenados en la memoria. _SI_ normalmente está asociado con _DS_ (segmento de datos) y _DI_ siempre está asociado con _ES_ (segmento extra).

Los registros _DS_: _SI_ (o _ESI_) y _ES_: _DI_ (o _EDI_) apuntan a los operandos de origen y destino, respectivamente. Se supone que el operando de origen está en _DS_: _SI_ (o _ESI_) y el operando de destino en _ES_: _DI_ (o _EDI_) en la memoria.

Para direcciones de 16 bits, se utilizan los registros _SI_ y _DI_, y para direcciones de 32 bits, se utilizan los registros _ESI_ y _EDI_.

La siguiente tabla representa la idea:

| Instrucción básica | Operación en | Operación de byte | Operación de palabra | Operación de palabra doble |
| ------------------ | ------------ | ----------------- | -------------------- | ------------ |
| _MOVS_ | _ES_:_DI_ / _DS_:_SI_ | _MOVSB_ | _MOVSW_ | _MOVSD_ |
| _LODS_ | _AX_ / _DS_:_SI_ | _LODSB_ | _LODSW_ | _LODSD_ |
| _STOS_ | _ES_:_DI_ / _AX_ | _STOSB_ | _STOSW_ | _STOSD_ |
| _CMPS_ | _DS_:_SI_ / _ES_:_DI_ | _CMPSB_ | _CMPSW_ | _CMPSD_ |
| _SCAS_ | _ES_:_DI_ / _AX_ | _SCASB_ | _SCASW_ | _SCASD_ |

### Prefijos de repetición
El prefijo _REP_, cuando se establece antes de una instrucción de cadena, por ejemplo, _REP_ _MOVSB_, provoca la repetición de la instrucción basada en un contador colocado en el registro _CX_. _REP_ ejecuta la instrucción, reduce _CX_ en 1 y comprueba si _CX_ es cero. Repite el procesamiento de la instrucción hasta que _CX_ sea cero.

La bandera de dirección _DF_ determinara la dirección del string:

* Usa _CLD_ (Bandera de dirección clara, _DF_=0) para realizar la operación de izquierda a derecha.
* Usa _STD_ (Bandera de establecer dirección, DF=1) para realizar la operacion de derecha a izquierda.

El prefijo _REP_ también tiene las siguientes variaciones:

* _REP_: Es la repetición incondicional. Repite la operación hasta que _CX_ sea cero.
* _REPE_ o _REPZ_: Es repetición condicional. Repite la operación mientras la bandera de cero indica igual / cero. Se detiene cuando _ZF_ indica no igual / cero o cuando _CX_ es cero.
* _REPNE_ o _REPNZ_: También es repetición condicional. Repite la operación mientras la bandera de cero indica no igual / cero. Se detiene cuando _ZF_ indica igual / cero o cuando _CX_ se reduce a cero.

## Arreglos
Como anteriormente podemos almacenar los datos de tal forma que tengamos variables individuales y en algunos casos del mismo tipo, pero en ocasiones podemos seccionar una variable con múltiples datos del mismo tipo, por tanto podemos realizar lo siguiente:
```nasm
  numeros dw  34, 45, 56, 67, 75, 89
```
De tal forma que la variable _numeros_ almacena 6 números de tipo _DW_ los cuales son equivalentes a 12 bytes en total de almacenamiento.

Otra forma de igual almacenar datos con un dato inicializado de forma fija, puede ser la siguiente:
```nasm
  init_a  times 8 dw 0
```
Como vemos en este ejemplo creamos un arreglo de 8 casillas que almacenan 0 en todas sus posiciones, añadiendo que hacemos uso del tipo _DW_ por tanto almacenamos o usamos 16 bytes en total.

__Ejemplo__
```nasm
  section .data
    ; Definimos las salidas del programa std_out, std_in,
    ; sys_write, sys_exit, sys_read
    stdout    equ 1
    stdin     equ 0
    sys_exit  equ 1
    sys_write equ 4
    sys_read  equ 3
    msg       db  "Resultado de la suma del array: "
    endl      db  0x0a
    lmsg      equ $-msg
    lendl     equ $-endl
    global x  ; Forma 3 de declarar un array
      x:      db  2
              db  4
              db  3
      sum:    db  0

  section .text
    global  _start

  _start:
    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg
    mov edx,  lmsg
    int 0x80

    mov eax,  3       ; Número de bytes del array
    mov ebx,  0       ; Registro que almacenara la suma
    mov ecx,  x       ; Punto de inicio del arreglo

  top:
    add ebx,  [ecx]
    add ecx,  1       ; Pasa a la siguiente posición
    dec eax           ; Decrementa eax para verificar si es 0
    jnz top

  hecho:
    add ebx,  '0'
    mov [sum],ebx     ; Mueve el valor del registro ebx a sum

  fin:
    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  sum
    mov edx,  1
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  endl
    mov edx,  lendl
    int 0x80

    mov eax,  sys_exit
    mov ebx,  0
    int 0x80
```

## Procedimientos o Subrutinas
Los procedimientos o subrutinas son muy importantes en el lenguaje ensamblador, ya que los programas en lenguaje ensamblador tienden a ser de gran tamaño. Los procedimientos se identifican con un nombre. A continuación de este nombre, se describe el cuerpo del procedimiento que realiza un trabajo bien definido. El final del procedimiento se indica mediante una declaración de devolución.

__Sintaxis__
```nasm
  procedimiento:
    ; Estructura del procedimiento
    ret
```

El procedimiento se llama desde otra función utilizando la instrucción _CALL_. La instrucción _CALL_ debe tener el nombre del procedimiento llamado como argumento como se muestra a continuación:

```nasm
  call procedimiento
```

El procedimiento llamado devuelve el control al procedimiento de llamada utilizando la instrucción _RET_.

__Ejemplo__
```nasm
  section .data
    ; Definimos las salidas del programa std_out, std_in,
    ; sys_write, sys_exit, sys_read
    stdout    equ 1
    stdin     equ 0
    sys_exit  equ 1
    sys_write equ 4
    sys_read  equ 3
    msg       db  "Resultado de la suma del array: "
    endl      db  0x0a
    lmsg      equ $-msg
    lendl     equ $-endl
    global x  ; Forma 3 de declarar un array
      x:      db  2
              db  4
              db  3
      sum:    db  0

  section .text
    global  _start

  _start:
    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  msg
    mov edx,  lmsg
    int 0x80

    mov eax,  3       ; Número de bytes del array
    mov ebx,  0       ; Registro que almacenara la suma
    mov ecx,  x       ; Punto de inicio del arreglo

  top:
    add ebx,  [ecx]
    add ecx,  1       ; Pasa a la siguiente posición
    dec eax           ; Decrementa eax para verificar si es 0
    jnz top

  hecho:
    add ebx,  '0'
    mov [sum],ebx     ; Mueve el valor del registro ebx a sum

  fin:
    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  sum
    mov edx,  1
    int 0x80

    mov eax,  sys_write
    mov ebx,  stdout
    mov ecx,  endl
    mov edx,  lendl
    int 0x80

    mov eax,  sys_exit
    mov ebx,  0
    int 0x80
```
### Estructra de datos Stack (Pila)
Una pila es una estructura de datos similar a una matriz en la memoria en la que los datos se pueden almacenar y eliminar de una ubicación llamada 'parte superior' de la pila. Los datos que deben almacenarse se 'empujan' a la pila y los datos que se van a recuperar se 'extraen' de la pila. Stack es una estructura de datos LIFO, es decir, los datos almacenados primero se recuperan en último lugar.

NASM proporciona dos instrucciones para las operaciones de pila: _PUSH_ y _POP_. Estas instrucciones tienen sintaxis como:

```nasm
  push  operando
  pop   dirección/registro
```

El espacio de memoria reservado en el segmento de la pila se utiliza para implementar la pila. Los registros _SS_ y _ESP_ (o _SP_) se utilizan para implementar la pila. La parte superior de la pila, que apunta al último elemento de datos insertado en la pila, es apuntada por el registro _SS_: _ESP_, donde el registro _SS_ apunta al comienzo del segmento de la pila y el _SP_ (o _ESP_) da el desplazamiento en el segmento de pila.

La implementación de la pila tiene las siguientes características:

* Solo se pueden guardar palabras o palabras dobles en la pila, no un byte.
* La pila crece en la dirección inversa, es decir, hacia la dirección de memoria inferior
* La parte superior de la pila apunta al último elemento insertado en la pila; apunta al byte más bajo de la última palabra insertada.

Como comentamos sobre el almacenamiento de los valores de los registros en la pila antes de usarlos para algún uso; se puede hacer de la siguiente manera

```nasm
  ; Guarda los registros AX y BX en la pila
  push  ax
  push  bx

  ; Usa los registros para otro proposito
  mov   ax, valor1
  mov   bx, valor2
  ; .....
  mov   valor1, ax
  mov   valor2, bx

  ; Devuelve a los valores originales
  pop   bx
  pop   ax
```

__Ejemplo__
```nasm
  section .data
    ; Definimos las salidas del programa std_out, std_in,
    ; sys_write, sys_exit, sys_read
    stdout    equ 1
    stdin     equ 0
    sys_exit  equ 1
    sys_write equ 4
    sys_read  equ 3
    achar     db '0'

  section .text
    global  _start

  _start:
    call    display
    mov     eax,  sys_exit
    mov     ebx,  0
    int     0x80

  display:
    mov     ecx,  256

  next:
    push    ecx
    mov     eax,  sys_write
    mov     ebx,  stdout
    mov     ecx,  achar
    mov     edx,  1
    int     0x80

    pop     ecx
    mov     dx,   [achar]
    cmp     byte [achar],0x0D
    inc     byte [achar]
    loop    next
    ret
```
## Recursión
Un procedimiento recursivo es aquel que se llama a sí mismo. Hay dos tipos de recursividad: directa e indirecta. En la recursividad directa, el procedimiento se llama a sí mismo y en la recursividad indirecta, el primer procedimiento llama a un segundo procedimiento, que a su vez llama al primer procedimiento.

La recursividad se pudo observar en numerosos algoritmos matemáticos.

__Ejemplo__

Considere el caso de calcular el factorial de un número. El factorial de un número viene dado por la ecuación:
```nasm
  Fact(n) = n * Fact(n-1) for (n>0)
```

__Ejemplo__
```nasm
  section .data
    ; Definimos las salidas del programa std_out, std_in,
    ; sys_write, sys_exit, sys_read
    stdout    equ 1
    stdin     equ 0
    sys_exit  equ 1
    sys_write equ 4
    sys_read  equ 3
    msg       db  "El factorial de 3 es: "
    endl      db  0x0a
    lmsg      equ $-msg
    lendl     equ $-endl

  section .bss
    fact   resb  1

  section .text
    global  _start


  _start:
    mov     bx, 3     ; Para el calculo del factorial de 3
    call factorial
    add     ax, '0'
    mov     [fact],ax

    mov     eax,  sys_write
    mov     ebx,  stdout
    mov     ecx,  msg
    mov     edx,  lmsg
    int     0x80

    mov     eax,  sys_write
    mov     ebx,  stdout
    mov     ecx,  fact
    mov     edx,  1
    int     0x80

    mov     eax,  sys_write
    mov     ebx,  stdout
    mov     ecx,  endl
    mov     edx,  lendl
    int     0x80

    mov     eax,  sys_exit
    mov     ebx,  0
    int     0x80

  factorial:
    cmp     bl, 1
    jg      calcula
    mov     ax, 1
    ret

  calcula:
    dec     bl
    call    factorial
    inc     bl
    mul     bl        ; ax = al*bl
    ret
```
## Macros
Escribir una macro es otra forma de garantizar la programación modular en lenguaje ensamblador.

* Una macro es una secuencia de instrucciones, asignadas por un nombre y pueden usarse en cualquier parte del programa.
* En NASM, las macros se definen con las directivas \%macro y \%endmacro.
* La macro comienza con la directiva \%macro y termina con la directiva \%endmacro.

__Sintaxis__
```nasm
  %macro nombre_de_la_macro  numero_de_parametros
  ; Cuerpo de la macro
  %endmacro
```
_Donde:_

* _nombre\_de\_la\_macro_ es el nombre de la pequeña parte del modulo con la cual podremos trabajar
* _numero\_de\_parametros_ es la cantidad de parámetros que recibe la macro

Por ejemplo en algunos casos cuando realizamos algo múltiples veces podemos crear una macros la cual nos permita ahorrarnos tiempo de escritura de código.

__Ejemplo__
```nasm
  section .data
    ; Definimos las salidas del programa std_out, std_in,
    ; sys_write, sys_exit, sys_read
    stdout    equ 1
    stdin     equ 0
    sys_exit  equ 1
    sys_write equ 4
    sys_read  equ 3
    msg       db  "Hola programador",0x0A,0x0D
    lmsg      equ $-msg
    msg1      db  "Te saludo",0x0A,0x0D
    lmsg1     equ $-msg1
    msg2      db  "Desde la comodidad de solo escribir una sencilla macros",0x0A
    lmsg2     equ $-msg2

  section .text
    global  _start

  %macro  print_string  2
    mov   eax,  sys_write
    mov   ebx,  stdout
    mov   ecx,  %1        ; Primer parametro
    mov   edx,  %2        ; Segundo parametro
    int   0x80
  %endmacro

  _start:
    print_string  msg,  lmsg
    print_string  msg1, lmsg1
    print_string  msg2, lmsg2
    mov     eax,  sys_exit
    mov     ebx,  0
    int     0x80
```
## Gestión de archivos
El sistema considera cualquier dato de entrada o salida como flujo de bytes.

Hay tres flujos de archivos estándar:

* Entrada estándar (stdin)
* Salida estándar (stdout)
* Error estándar (stderr)

### Descriptor de archivo
Un descriptor de archivo es un entero de 16 bits asignado a un archivo como una identificación de archivo. Cuando se crea un archivo nuevo o se abre un archivo existente, el descriptor de archivo se utiliza para acceder al archivo.

Los números estándar de algunos flujos de archivos son los siguientes:
* stdin - 0
* stdout - 1
* stderr - 2

### Apuntador de archivos
Especifica la ubicación para una operación de lectura / escritura posterior en el archivo en términos de bytes. Cada archivo se considera una secuencia de bytes. Cada archivo abierto está asociado con un puntero de archivo que especifica un desplazamiento en bytes, relativo al comienzo del archivo. Cuando se abre un archivo, el puntero del archivo se establece en cero.

### Llamadas al sistema para manejo de archivos

| _eax_ | Nombre | _ebx_ | _ecx_ | _edx_ |
| ----- | ------ | ----- | ----- | ----- |
|   2   | sys\_fork | struct pt\_reg | - | - |
|   3   | sys\_read | unsigned int | char * | size\_t |
|   4   | sys\_write | unsigned int | const char * | size_t |
|   5   | sys\_open | const char * | int | int |
|   6   | sys\_close | unsigned int   | - | - |
|   8   | sys\_creat | const char * | int | - |
|   19  | sys\_lseek | unsigned int | off\_t | unsigned int |

Los pasos necesarios para utilizar las llamadas al sistema son los mismos, como comentamos anteriormente:

* Ponga el número de llamada del sistema en el registro _EAX_.
* Almacene los argumentos de la llamada al sistema en los registros _EBX_, _ECX_, etc.
* Llame a la interrupción correspondiente (_0x80_).
* El resultado generalmente se devuelve en el registro _EAX_.

La llamada al sistema devuelve el descriptor de archivo del archivo creado en el registro EAX, en caso de error, el código de error está en el registro EAX.

### Crear y abrir un archivo
Para crear y abrir un archivo, realice lo siguiente:
* Ponga la llamada al sistema _sys\_open()_ _5_, en el registro _EAX_.
* Ponga el nombre del archivo en el registro _EBX_.
* Ponga el modo de acceso a archivos en el registro _ECX_.
* Ponga los permisos del archivo en el registro _EDX_.

La llamada al sistema devuelve el descriptor de archivo del archivo creado en el registro _EAX_, en caso de error, el código de error está en el registro _EAX_.

Entre los modos de acceso a archivos, los más utilizados son:

* Solo lectura (0)
* Solo escritura (1)
* Lectura-escritura (2)

#### Leer de un archivo
Para leer algo desde un archivo se hace lo siguiente:

* Ponga la llamada al sistema _sys\_read()_ número _3_, en el registro _EAX_.
* Coloque el descriptor de archivo en el registro _EBX_.
* Ponga el puntero al búfer de entrada en el registro _ECX_.
* Coloque el tamaño del búfer, es decir, el número de bytes a leer, en el registro _EDX_.

La llamada al sistema devuelve el número de bytes leídos en el registro EAX, en caso de error, el código de error está en el registro EAX.

#### Escribir en un archivo
Para escribir en un archivo se hace lo siguiente:

* Ponga la llamada al sistema _sys\_write()_ número _4_, en el registro _EAX_.
* Coloque el descriptor de archivo en el registro _EBX_.
* Coloque el puntero en el búfer de salida en el registro _ECX_.
* Coloque el tamaño del búfer, es decir, el número de bytes a escribir, en el registro _EDX_.

La llamada al sistema devuelve el número real de bytes escritos en el registro _EAX_, en caso de error, el código de error está en el registro _EAX_.

#### Cerrar un archivo
Para cerrar el flujo del archivo se hace lo siguiente:

* Ponga la llamada al sistema _sys\_close()_ número _6_, en el registro _EAX_.
* Coloque el descriptor de archivo en el registro _EBX_.

La llamada al sistema devuelve, en caso de error, el código de error en el registro _EAX_.

#### Para actualizar en un archivo
Para actualizar en un archivo se hace lo siguiente:

* Ponga la llamada al sistema _sys\_lseek()_ número _19_, en el registro _EAX_.
* Coloque el descriptor de archivo en el registro _EBX_.
* Ponga el valor de compensación en el registro _ECX_.
* Ponga la posición de referencia para el desplazamiento en el registro _EDX_.

__Las posiciones de referencia son las siguientes__

* Comienzo del archivo - valor _0_
* Posición actual - valor _1_
* Fin de archivo - valor _2_

La llamada al sistema devuelve, en caso de error, el código de error en el registro _EAX_.

__Ejemplo__

Crea un archivo, escribe sobre el archivo y finalmente lee lo que hay en el archivo.
```nasm
  section .data
    ; Definimos las salidas del programa stdout, stdin,
    ; sys_exit, sys_read, sys_write, sys_open, sys_close,
    ; sys_creat
    stdout    equ 1
    stdin     equ 0
    sys_exit  equ 1
    sys_read  equ 3
    sys_write equ 4
    sys_open  equ 5
    sys_close equ 6
    sys_creat equ 8

    read_only equ 0
    write_onl equ 1
    read_wr   equ 2

    beg       equ 0
    current   equ 1
    eof       equ 2

    fil_name  db  "archivo.txt",0
    msg_file  db  "Hola mundo desde el archivo.",0x0A
    lmsg_file equ $-msg_file
    msg       db  "Mensaje del archivo: ",0x0A
    lmsg      equ $-msg

  section .bss
    fd_in  resb  1
    fd_out resb  1
    lect   resb  29

  section .text
    global  _start

  _start:
    ; Creando el archivo
    mov   eax,  sys_creat
    mov   ebx,  fil_name
    mov   ecx,  0777      ; Permisos de escritura, lectura y ejecución
    int   0x80

    mov [fd_out], eax

    ; Escribiendo en el archivo
    mov   eax,  sys_write
    mov   ebx,  [fd_out]
    mov   ecx,  msg_file
    mov   edx,  lmsg_file
    int   0x80

    ; Cerrando el flujo
    mov   eax,  sys_close
    mov   ebx,  [fd_out]
    int   0x80

    ; Escribiendo el mensaje de pantalla
    mov   eax,  sys_write
    mov   ebx,  stdout
    mov   ecx,  msg
    mov   edx,  lmsg
    int   0x80

    ; Abrimos el flujo para el archivo
    mov   eax,  sys_open
    mov   ebx,  fil_name
    mov   ecx,  read_only
    mov   edx,  0777
    int   0x80

    mov [fd_in],eax

    ; Leemos lo que hay en el archivo
    mov   eax,  sys_read
    mov   ebx,  [fd_in]
    mov   ecx,  lect
    mov   edx,  29
    int 0x80

    ; Cerramos el flujo de datos
    mov   eax,  sys_close
    mov   ebx,  [fd_in]
    int 0x80

    ; Mostramos en pantalla el contenido
    mov   eax,  sys_write
    mov   ebx,  stdout
    mov   ecx,  lect
    mov   edx,  29
    int   0x80

    ; Cerramos programa
    mov   eax,  sys_exit
    mov   ebx,  0
    int   0x80
```
