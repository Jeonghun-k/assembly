; 06.asm
; Programming Exercises 8.11 #6 - Exchanging Integers

INCLUDE Irvine32.inc

.data
msgTitle BYTE "8.11 #6 - Exchanging Integers with Swap",0
arr DWORD 10, 20, 30, 40, 50, 60, 70

.code
Swap PROTO pX:PTR DWORD, pY:PTR DWORD

main PROC
    call Clrscr
    mov  edx, OFFSET msgTitle
    call WriteString
    call Crlf

    mov  edx, OFFSET arr
    mov  ecx, LENGTHOF arr
show_orig:
    mov  eax, [edx]
    call WriteDec
    call Crlf
    add  edx, TYPE arr
    loop show_orig

    call Crlf

    mov  ecx, LENGTHOF arr
    mov  eax, 0

pair_loop:
    cmp  eax, ecx
    jge  pairs_done
    mov  edx, eax
    add  edx, 1
    cmp  edx, ecx
    jge  pairs_done

    mov  esi, OFFSET arr
    lea  ebx, [esi + eax*4]
    lea  edx, [esi + edx*4]
    INVOKE Swap, ebx, edx

    add  eax, 2
    jmp  pair_loop

pairs_done:
    mov  edx, OFFSET arr
    mov  ecx, LENGTHOF arr
show_new:
    mov  eax, [edx]
    call WriteDec
    call Crlf
    add  edx, TYPE arr
    loop show_new

    exit
main ENDP

Swap PROC uses eax esi edi,
    pX:PTR DWORD,
    pY:PTR DWORD

    mov  esi, pX
    mov  edi, pY
    mov  eax, [esi]
    xchg eax, [edi]
    mov  [esi], eax
    ret 8

Swap ENDP

END main
