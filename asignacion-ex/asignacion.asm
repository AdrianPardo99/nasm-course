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
