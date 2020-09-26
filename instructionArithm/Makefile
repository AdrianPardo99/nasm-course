file=suma
file2=mult
file3=divi
comp: ${file}.asm ${file2}.asm ${file3}.asm
	nasm -f elf ${file}.asm
	ld -m elf_i386 ${file}.o -s -o ${file}
	nasm -f elf ${file2}.asm
	ld -m elf_i386 ${file2}.o -s -o ${file2}
	nasm -f elf ${file3}.asm
	ld -m elf_i386 ${file3}.o -s -o ${file3}
sum: ${file}.asm
	nasm -f elf ${file}.asm
	ld -m elf_i386 ${file}.o -s -o ${file}
mult: ${file2}.asm
	nasm -f elf ${file2}.asm
	ld -m elf_i386 ${file2}.o -s -o ${file2}
div:	${file3}.asm
	nasm -f elf ${file3}.asm
	ld -m elf_i386 ${file3}.o -s -o ${file3}
