section .data
  ; Definimos las salidas del programa std_out, std_in,
  ; sys_write, sys_exit, sys_read
  stdout    equ 1
  stdin     equ 0
  sys_exit  equ 1
  sys_write equ 4
  sys_read  equ 3
  msg       db  "Resultado de la suma es: "
  endl      db  0x0a
  lmsg      equ $-msg
  lendl     equ $-endl

section .bss
  r   resb  1

section .text
  global  _start

_start:
  mov ecx,  '4'
  mov edx,  '3'
  sub ecx,  '0'
  sub edx,  '0'

  call sum

  mov  [r], eax

  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  msg
  mov edx,  lmsg
  int 0x80

  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  r
  mov edx,  1
  int 0x80

  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  endl
  mov edx,  lendl
  int 0x80

  mov eax,  sys_exit
  mov ebx,  0
  int 0x80

sum:
  mov eax,  ecx
  add eax,  edx
  add eax,  '0'
  ret
