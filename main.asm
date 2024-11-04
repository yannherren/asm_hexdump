;   syscall table: https://x64.syscall.sh/

SECTION .data
    HexTable: db "0123456789ABCDEF", 0x20, 0x0A

SECTION .bss
    Buffer: resb 8
    BufferLen equ $ - Buffer

SECTION .text
global _start

_start:

read:
    mov rax, 0
    mov rdi, 0
    mov rsi, Buffer
    mov rdx, BufferLen
    syscall

    cmp rax, 0
    jz exit

    xor r10, r10

process:
    cmp r10, rax
    jz read_next
    mov byte bl, [Buffer+r10]

    movzx rbx, bl
    push rbx

    shr rbx, 4
    call write_char

    pop rbx
    and rbx, 0x0F
    call write_char

    mov rbx, 0x10
    call write_char

    inc r10

    jmp process

write_char:
    push rax
    lea r8, [HexTable+rbx]
    mov rax, 1
    mov rdi, 1
    mov rsi, r8
    mov rdx, 1
    syscall
    pop rax
    ret

read_next:
    mov rbx, 0x11
    call write_char
    jmp read

exit:
    mov rax, 60 ; syscall for exit
    mov rdi, 0 ; exit code 0
    syscall
