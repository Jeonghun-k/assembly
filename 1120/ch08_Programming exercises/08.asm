; 08.asm
; Programming Exercises 8.11 #8 - CountMatches

INCLUDE Irvine32.inc

.data
msgTitle BYTE "8.11 #8 - CountMatches demo",0

arrA1 SDWORD 1,2,3,4,5
arrB1 SDWORD 1,0,3,9,5

arrA2 SDWORD -1,-2,-3,-4,-5
arrB2 SDWORD -1,-2,  0,-4, 7

.code
CountMatches PROTO pA:PTR SDWORD, pB:PTR SDWORD, count:DWORD

main PROC
    call Clrscr
    mov  edx, OFFSET msgTitle
    call WriteString
    call Crlf

    INVOKE CountMatches, ADDR arrA1, ADDR arrB1, LENGTHOF arrA1
    call WriteInt
    call Crlf

    INVOKE CountMatches, ADDR arrA2, ADDR arrB2, LENGTHOF arrA2
    call WriteInt
    call Crlf

    exit
main ENDP

CountMatches PROC USES ecx esi edi edx,
    pA:PTR SDWORD,
    pB:PTR SDWORD,
    count:DWORD

    mov  esi, pA
    mov  edi, pB
    mov  ecx, count
    mov  eax, 0

cm_loop:
    cmp  ecx, 0
    je   cm_done

    mov  edx, [esi]
    cmp  edx, [edi]
    jne  cm_next
    inc  eax

cm_next:
    add  esi, 4
    add  edi, 4
    dec  ecx
    jmp  cm_loop

cm_done:
    ret

CountMatches ENDP

END main
