; 09.asm
; Programming Exercises 8.11 #9 - CountNearMatches

INCLUDE Irvine32.inc

.data
msgTitle BYTE "8.11 #9 - CountNearMatches demo",0

arrA1 SDWORD 10, 20, 30, 40, 50
arrB1 SDWORD 12, 18, 29, 41, 60

arrA2 SDWORD -5, -10, -15, -20
arrB2 SDWORD -7,  -8, -14, -25

.code
CountNearMatches PROTO pA:PTR SDWORD, pB:PTR SDWORD, count:DWORD, diff:DWORD

main PROC
    call Clrscr
    mov  edx, OFFSET msgTitle
    call WriteString
    call Crlf

    INVOKE CountNearMatches, ADDR arrA1, ADDR arrB1, LENGTHOF arrA1, 3
    call WriteInt
    call Crlf

    INVOKE CountNearMatches, ADDR arrA2, ADDR arrB2, LENGTHOF arrA2, 2
    call WriteInt
    call Crlf

    exit
main ENDP

CountNearMatches PROC USES ecx esi edi ebx edx,
    pA:PTR SDWORD,
    pB:PTR SDWORD,
    count:DWORD,
    diff:DWORD

    mov  esi, pA
    mov  edi, pB
    mov  ecx, count
    mov  eax, 0

cnm_loop:
    cmp  ecx, 0
    je   cnm_done

    mov  ebx, [esi]
    mov  edx, [edi]
    sub  ebx, edx
    cmp  ebx, 0
    jge  no_neg
    neg  ebx
no_neg:
    cmp  ebx, diff
    jg   cnm_next
    inc  eax

cnm_next:
    add  esi, 4
    add  edi, 4
    dec  ecx
    jmp  cnm_loop

cnm_done:
    ret

CountNearMatches ENDP

END main
