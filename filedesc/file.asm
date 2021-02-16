section .data
  ; Definimos las salidas del programa stdout, stdin,
  ; sys_exit, sys_read, sys_write, sys_open, sys_close,
  ; sys_creat
  stdout    equ 1
  stdin     equ 0
  sys_exit  equ 1
  sys_read  equ 3
  sys_write equ 4
  sys_open  equ 5
  sys_close equ 6
  sys_creat equ 8

  read_only equ 0
  write_onl equ 1
  read_wr   equ 2

  beg       equ 0
  current   equ 1
  eof       equ 2

  fil_name  db  "archivo.txt",0
  msg_file  db  "Hola mundo desde el archivo.",0x0A
  lmsg_file equ $-msg_file
  msg       db  "Mensaje del archivo: ",0x0A
  lmsg      equ $-msg

section .bss
  fd_in  resb  1
  fd_out resb  1
  lect   resb  29

section .text
  global  _start

_start:
  ; Creando el archivo
  mov   eax,  sys_creat
  mov   ebx,  fil_name
  mov   ecx,  0777      ; Permisos de escritura, lectura y ejecución
  int   0x80

  mov [fd_out], eax

  ; Escribiendo en el archivo
  mov   eax,  sys_write
  mov   ebx,  [fd_out]
  mov   ecx,  msg_file
  mov   edx,  lmsg_file
  int   0x80

  ; Cerrando el flujo
  mov   eax,  sys_close
  mov   ebx,  [fd_out]
  int   0x80

  ; Escribiendo el mensaje de pantalla
  mov   eax,  sys_write
  mov   ebx,  stdout
  mov   ecx,  msg
  mov   edx,  lmsg
  int   0x80

  ; Abrimos el flujo para el archivo
  mov   eax,  sys_open
  mov   ebx,  fil_name
  mov   ecx,  read_only
  mov   edx,  0777
  int   0x80

  mov [fd_in],eax

  ; Leemos lo que hay en el archivo
  mov   eax,  sys_read
  mov   ebx,  [fd_in]
  mov   ecx,  lect
  mov   edx,  29
  int 0x80

  ; Cerramos el flujo de datos
  mov   eax,  sys_close
  mov   ebx,  [fd_in]
  int 0x80

  ; Mostramos en pantalla el contenido
  mov   eax,  sys_write
  mov   ebx,  stdout
  mov   ecx,  lect
  mov   edx,  29
  int   0x80

  ; Cerramos programa
  mov   eax,  sys_exit
  mov   ebx,  0
  int   0x80
