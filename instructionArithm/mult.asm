section .data
  ; Definimos las salidas del programa std_out,
  ; sys_write, sys_exit
  stdout    equ 1
  sys_exit  equ 1
  sys_write equ 4
  msg1  db  "Primer valor: "
  lmsg1 equ $-msg1

  msg2  db  "Segundo valor: "
  lmsg2 equ $-msg2

  msg3  db  "La multiplicación es: "
  lmsg3 equ $-msg3

  endl  db  0x0A
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
