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
