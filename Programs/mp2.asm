section .data
    msg1 db 10,13,"Enter a string:"
    len1 equ $-msg1
section .bss
    str1 resb 200 ; string declaration
    result resb 16
section .text
    global _start

_start:
    ; display
    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, len1
    syscall

    ; store string
    mov rax, 0
    mov rdi, 0
    mov rsi, str1
    mov rdx, 200
    syscall

    call display

    ; exit system call
    mov rax, 60
    xor rdi, rdi
    syscall

%macro dispmsg 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

display:
    mov rbx, rax      ; store no in rbx
    mov rdi, result  ; point rdi to result variable
    mov cx, 16       ; load count of rotation in cx

up1:
    rol rbx, 4       ; rotate no of left by four bits
    mov al, bl       ; move lower byte in al
    and al, 0fh      ; get only LSB
    cmp al, 9        ; compare with 9
    jg add_37        ; if greater than 9, skip add 37
    add al, 30h
    jmp skip         ; else add 30
add_37:
    add al, 37h
skip:
    mov [rdi], al    ; store ASCII code in result variable
    inc rdi          ; point to next byte
    dec cx           ; decrement counter
    jnz up1          ; if not zero, jump to repeat

    dispmsg result, 16 ; call to macro

    ret
