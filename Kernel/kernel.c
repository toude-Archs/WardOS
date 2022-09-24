#include <include/textmode.h>
#include <include/GDT/gdt.h>

void _start(){
InitGdt();
TerminalClear();
TerminalSetColor(0x0E);
TerminalWrite("Hello, World!");
}