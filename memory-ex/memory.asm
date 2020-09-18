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
