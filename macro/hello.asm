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
