; 04.asm
; Programming Exercises 8.11 #4 - FindThrees

INCLUDE Irvine32.inc

.data
msgTitle BYTE "8.11 #4 - FindThrees demo",0
arr1 SDWORD 1,3,3,3,5,6
arr2 SDWORD 3,3,2,3,3,3
arr3 SDWORD 1,2,3,4,5

.code
FindThrees PROTO pArray:PTR SDWORD, count:DWORD

main PROC
    call Clrscr
    mov  edx, OFFSET msgTitle
    call WriteString
    call Crlf

    INVOKE FindThrees, ADDR arr1, LENGTHOF arr1
    call WriteInt
    call Crlf

    INVOKE FindThrees, ADDR arr2, LENGTHOF arr2
    call WriteInt
    call Crlf

    INVOKE FindThrees, ADDR arr3, LENGTHOF arr3
    call WriteInt
    call Crlf

    exit
main ENDP

FindThrees PROC USES ecx esi edx,
    pArray:PTR SDWORD,
    count:DWORD

    mov  ecx, count
    cmp  ecx, 3
    jl   ft_notfound

    mov  esi, pArray

ft_loop:
    mov  eax, [esi]
    cmp  eax, 3
    jne  ft_next
    mov  eax, [esi+4]
    cmp  eax, 3
    jne  ft_next
    mov  eax, [esi+8]
    cmp  eax, 3
    jne  ft_next

    mov  eax, 1
    ret

ft_next:
    add  esi, 4
    dec  ecx
    cmp  ecx, 3
    jge  ft_loop

ft_notfound:
    mov  eax, 0
    ret

FindThrees ENDP

END main
