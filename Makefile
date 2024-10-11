main: main.o
	ld -o main main.o

main.o: main.asm
	nasm -f elf64 -g -F dwarf main.asm -o main.o

clean:
	rm -rf main
	rm -rf main.o