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
