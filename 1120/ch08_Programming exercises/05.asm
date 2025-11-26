; 05.asm
; Programming Exercises 8.11 #5 - DifferentInputs

INCLUDE Irvine32.inc

.data
msgTitle BYTE "8.11 #5 - DifferentInputs demo",0

.code
DifferentInputs PROTO a:DWORD, b:DWORD, c:DWORD

main PROC
    call Clrscr
    mov  edx, OFFSET msgTitle
    call WriteString
    call Crlf

    INVOKE DifferentInputs, 1, 2, 3
    call WriteInt
    call Crlf

    INVOKE DifferentInputs, 5, 5, 7
    call WriteInt
    call Crlf

    INVOKE DifferentInputs, 1, 8, 8
    call WriteInt
    call Crlf

    INVOKE DifferentInputs, 9, 2, 9
    call WriteInt
    call Crlf

    INVOKE DifferentInputs, 4, 4, 4
    call WriteInt
    call Crlf

    exit
main ENDP

DifferentInputs PROC a:DWORD, b:DWORD, c:DWORD
    mov  eax, a
    cmp  eax, b
    je   not_all_diff
    cmp  eax, c
    je   not_all_diff

    mov  eax, b
    cmp  eax, c
    je   not_all_diff

    mov  eax, 1
    ret 12

not_all_diff:
    mov  eax, 0
    ret 12

DifferentInputs ENDP

END main
