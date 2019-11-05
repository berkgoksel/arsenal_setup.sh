#!/bin/bash
#Compile and link x86_64

nasm -f elf64 $1
echo $1
cutString(){
echo $1 | cut -d "." -f 1
}
string=$(cutString $1)
echo $string
ld $string.o -o $string
