section .data
  ; Definimos las salidas del programa std_out, std_in,
  ; sys_write, sys_exit, sys_read
  stdout    equ 1
  stdin     equ 0
  sys_exit  equ 1
  sys_write equ 4
  sys_read  equ 3
  msg       db  "Resultado de la suma del array: "
  endl      db  0x0a
  lmsg      equ $-msg
  lendl     equ $-endl
  global x  ; Forma 3 de declarar un array
    x:      db  2
            db  4
            db  3
    sum:    db  0

section .text
  global  _start

_start:
  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  msg
  mov edx,  lmsg
  int 0x80

  mov eax,  3       ; Número de bytes del array
  mov ebx,  0       ; Registro que almacenara la suma
  mov ecx,  x       ; Punto de inicio del arreglo

top:
  add ebx,  [ecx]
  add ecx,  1       ; Pasa a la siguiente posición
  dec eax           ; Decrementa eax para verificar si es 0
  jnz top

hecho:
  add ebx,  '0'
  mov [sum],ebx     ; Mueve el valor del registro ebx a sum

fin:
  mov eax,  sys_write
  mov ebx,  stdout
  mov ecx,  sum
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
