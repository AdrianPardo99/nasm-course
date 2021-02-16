section .data
  ; Definimos las salidas del programa std_out, std_in,
  ; sys_write, sys_exit, sys_read
  stdout    equ 1
  stdin     equ 0
  sys_exit  equ 1
  sys_write equ 4
  sys_read  equ 3
  achar     db '0'

section .text
  global  _start

_start:
  call    display
  mov     eax,  sys_exit
  mov     ebx,  0
  int     0x80

display:
  mov     ecx,  256

next:
  push    ecx
  mov     eax,  sys_write
  mov     ebx,  stdout
  mov     ecx,  achar
  mov     edx,  1
  int     0x80

  pop     ecx
  mov     dx,   [achar]
  cmp     byte [achar],0x0D
  inc     byte [achar]
  loop    next
  ret
