section .data
  ; Definimos las salidas del programa stdout, stdin,
  ; sys_exit, sys_read, sys_write, sys_open, sys_close,
  ; sys_creat
  stdout    equ 1
  stdin     equ 0
  sys_exit  equ 1
  sys_read  equ 3
  sys_write equ 4
  sys_brk   equ 45

  msg       db  "Se almacenaron 16kb!!",0x0A
  lmsg      equ $-msg

section .text
  global  _start

_start:
  ; Crea el flujo
  mov     eax,  sys_brk
  xor     ebx,  ebx
  int     0x80

  ; Parte de la reserva
  add     eax,  16384
  mov     ebx,  eax
  mov     eax,  sys_brk
  int     0x80

  cmp     eax,  0
  jl      salir           ; Si hay error

  mov     edi,  eax       ; edi = dirección más alta disponible
  sub     edi,  4         ; Apuntando a la última DWORD
  mov     ecx,  4096      ; número de DWORD asignados
  xor     eax,  eax       ; Limpiando el registro eax
  std                     ; Hacia atrás
  rep     stosd           ; Repetir para toda el área asignada
  cld                     ; Pone la bandera DF en estado normal

  mov     eax,  sys_write
  mov     ebx,  stdout
  mov     ecx,  msg
  mov     edx,  lmsg
  int     0x80

salir:
  mov     eax,  sys_exit
  xor     ebx,  ebx
  int     0x80
