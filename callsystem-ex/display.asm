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
