file=proEqu
comp: ${file}.asm
	nasm -f elf ${file}.asm
	ld -m elf_i386 ${file}.o -s -o ${file}
