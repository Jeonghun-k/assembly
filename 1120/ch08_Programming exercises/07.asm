; 07.asm
; Programming Exercises 8.11 #7 - Recursive GCD

INCLUDE Irvine32.inc

.data
msgTitle BYTE "8.11 #7 - Recursive GCD (Euclid)",0
pairs DWORD 5,20, 24,18, 11,7, 432,226, 26,13
txtAnd BYTE " and ",0
txtGCD BYTE " => GCD = ",0

.code
GCD PROTO a:DWORD, b:DWORD

main PROC
    call Clrscr
    mov  edx, OFFSET msgTitle
    call WriteString
    call Crlf

    mov  esi, OFFSET pairs
    mov  ecx, 5

pair_loop:
    cmp  ecx, 0
    je   done
    mov  eax, [esi]
    call WriteDec
    mov  edx, OFFSET txtAnd
    call WriteString
    mov  eax, [esi+4]
    call WriteDec
    mov  edx, OFFSET txtGCD
    call WriteString

    INVOKE GCD, [esi], [esi+4]
    call WriteDec
    call Crlf

    add  esi, 8
    dec  ecx
    jmp  pair_loop

done:
    exit
main ENDP

GCD PROC USES edx,
    a:DWORD,
    b:DWORD

    mov  eax, b
    cmp  eax, 0
    jne  rec
    mov  eax, a
    ret 8

rec:
    mov  eax, a
    cdq
    idiv b
    ; remainder EDX
    INVOKE GCD, b, edx
    ret 8
GCD ENDP

END main
