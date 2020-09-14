section .text
    global _start     ; Debe ser usado para linkear el archivo

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
