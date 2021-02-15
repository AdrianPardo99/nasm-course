; El siguiente ejemplo pedirá dos dígitos al usuario,
; respectivamente, sumara los valores, almacenará
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

  msg3  db  "La suma es: "
  lmsg3 equ $-msg3

section .bss
  n1  resb  6
  n2  resb  6
  r   resb  5

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
  mov edx,  6
  int 0x80

  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  msg2
  mov edx,  lmsg2
  int 0x80

  mov eax,  sys_read
  mov ebx,  stdin
  mov ecx,  n2
  mov edx,  6
  int 0x80

  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  msg3
  mov edx,  lmsg3
  int 0x80


  mov esi,  4 ; Puntero del ultimo digito
  mov ecx,  5 ; Numero de digitos

add_loop:
  mov al,   [n1+esi]
  adc al,   [n2+esi]
  aaa
  pushf
  or  al,   0x30
  popf

  mov [r+esi],  al
  dec esi
  loop add_loop

  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  r
  mov edx,  5
  int 0x80

  mov eax,  sys_exit
  mov ebx,  0
  int 0x80
