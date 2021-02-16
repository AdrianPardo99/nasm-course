section .data
  ; Definimos las salidas del programa std_out, std_in,
  ; sys_write, sys_exit, sys_read
  stdout    equ 1
  stdin     equ 0
  sys_exit  equ 1
  sys_write equ 4
  sys_read  equ 3
  msg       db  "El factorial de 3 es: "
  endl      db  0x0a
  lmsg      equ $-msg
  lendl     equ $-endl

section .bss
  fact   resb  1

section .text
  global  _start


_start:
  mov     bx, 3     ; Para el calculo del factorial de 3
  call factorial
  add     ax, '0'
  mov     [fact],ax

  mov     eax,  sys_write
  mov     ebx,  stdout
  mov     ecx,  msg
  mov     edx,  lmsg
  int     0x80

  mov     eax,  sys_write
  mov     ebx,  stdout
  mov     ecx,  fact
  mov     edx,  1
  int     0x80

  mov     eax,  sys_write
  mov     ebx,  stdout
  mov     ecx,  endl
  mov     edx,  lendl
  int     0x80

  mov     eax,  sys_exit
  mov     ebx,  0
  int     0x80

factorial:
  cmp     bl, 1
  jg      calcula
  mov     ax, 1
  ret

calcula:
  dec     bl
  call    factorial
  inc     bl
  mul     bl        ; ax = al*bl
  ret
