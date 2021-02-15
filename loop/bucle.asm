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
