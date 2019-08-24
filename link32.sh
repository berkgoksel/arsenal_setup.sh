#!/bin/bash
#Compile and link x86

nasm -f elf $1
echo $1
cutString(){
echo $1 | cut -d "." -f 1
}
string=$(cutString $1)
echo $string
ld -m elf_i386 $string.o -o $string
