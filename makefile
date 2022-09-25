SRCS := $(shell find Kernel/ -name '*.c') 
OBJS := $(SRCS:.c=.o)

%.o: %.c
	gcc -g -ffreestanding -IKernel/ -Wall -Wextra -fno-exceptions -fno-stack-protector -m32 -fno-pie -c $< -o $@

Kernel.bin: KernelEntry.o $(OBJS)
	ld -o $@ -Ttext 0x1000 $^ --oformat binary -m elf_i386

OSImage.img: Boot.bin Kernel.bin
	cat $^ > OSImage.img

Boot.bin:
	nasm Bootloader/Main.asm -f bin -o Boot.bin

KernelEntry.o:
	nasm Kernel/KernelEntry.asm -f elf -o KernelEntry.o

run: OSImage.img
	qemu-system-i386 -debugcon stdio -fda OSImage.img

clean:
	rm *.bin
	rm *.o
	rm *.img
	rm $(OBJS)