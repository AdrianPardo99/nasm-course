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
