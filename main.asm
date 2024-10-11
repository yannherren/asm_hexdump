;   syscall table: https://x64.syscall.sh/

SECTION .data
    ; define data here

SECTION .bss
    ; reserve memory here

SECTION .text
global _start

_start:
    ; your code goes here

    mov rax, 60 ; syscall for exit
    mov rdi, 0 ; exit code 0
    syscall
