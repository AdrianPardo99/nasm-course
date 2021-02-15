; El siguiente ejemplo pedirá dos dígitos al usuario,
; respectivamente, restara los valores, almacenará
; el resultado en una ubicación de memoria 'r'
; y finalmente mostrará el resultado.
section .data
  ; Definimos las salidas del programa std_out, std_in,
  ; sys_write, sys_exit, sys_read
  stdout    equ 1
  stdin     equ 0
  sys_exit  equ 1
  sys_write equ 4
  sys_read  equ 3

  ; Otros valores constantes seran
  msg1  db  "Ingresa el primer digito: "
  lmsg1 equ $-msg1

  msg2  db  "Ingresa los siguiente digito: "
  lmsg2 equ $-msg2

  msg3  db  "La resta es: "
  lmsg3 equ $-msg3

section .bss
  n1  resb  2
  n2  resb  2
  r   resb  1

section .text
  global  _start

_start:
  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  msg1
  mov edx,  lmsg1
  int 0x80

  mov eax,  sys_read
  mov ebx,  stdin
  mov ecx,  n1
  mov edx,  2
  int 0x80

  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  msg2
  mov edx,  lmsg2
  int 0x80

  mov eax,  sys_read
  mov ebx,  stdin
  mov ecx,  n2
  mov edx,  2
  int 0x80

  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  msg3
  mov edx,  lmsg3
  int 0x80

  mov al,  [n1]

  mov bl,  [n2]
  sub al,   bl
  aas
  or  al,   0x30


  ; Almacenaremos en r
  mov [r],  ax

  ; Imprimiremos la suma:
  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  r
  mov edx,  1
  int 0x80

  mov eax,  sys_exit
  mov ebx,  0
  int 0x80
