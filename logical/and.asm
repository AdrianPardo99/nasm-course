; El siguiente ejemplo pedirá un dígito al usuario,
; almacenará los dígitos en el registro EAX y EBX,
; respectivamente, and a los valores, almacenará
; el resultado en una ubicación de memoria 'res'
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

  msg3  db  "Es un valor potencia 2: "
  lmsg3 equ $-msg3

  msg2 db   0x0A,"Si es un valor 0 es un valor potencia 2",0x0A
  lmsg2 equ $-msg2

section .bss
  n1  resb  2
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
  mov ecx,  msg3
  mov edx,  lmsg3
  int 0x80

  ; Primero usaremos mov para cada numero, despues
  ; Substraeremos el valor ascii '0' para convertir a decimal

  mov eax,  [n1]
  sub eax,  '0'

  mov ebx,  [n1]
  sub ebx,  '0'
  sub ebx, 0x01

  ; Despues haremos and eax, ebx
  and eax,  ebx

  ; Sumaremos '0'
  add eax,  '0'

  ; Almacenaremos en r
  mov [r],  eax

  ; Imprimiremos la operación and:
  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  r
  mov edx,  1
  int 0x80

  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  msg2
  mov edx,  lmsg2
  int 0x80

  mov eax,  sys_exit
  mov ebx,  0
  int 0x80
