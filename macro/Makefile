ASM=nasm
FLAGS=-f elf
SRASM=$(wildcard *.asm)
OBJ=$(SRASM:.asm=.o)
BIN=$(OBJ:.o=)
all: ${BIN}

%.o:%.asm
	${ASM} ${FLAGS} $<

${BIN}: %:%.o
	ld -m elf_i386 $< -s -o $@

clean:
	rm ${BIN} ${OBJ}
