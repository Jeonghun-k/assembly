; 01.asm
; Programming Exercises 8.11 #1 - FindLargest
; FindLargest(pArray:PTR SDWORD, count:DWORD) -> EAX = largest element

INCLUDE Irvine32.inc

.data
msgTitle BYTE "8.11 #1 - FindLargest demo",0
arr1 SDWORD  10,  20,  -5,  7,  0
arr2 SDWORD -10, -20, -30, -5, -100
arr3 SDWORD 100, -50,  200,  0,  -300,  199

.code
FindLargest PROTO pArray:PTR SDWORD, count:DWORD

main PROC
    call Clrscr
    mov  edx, OFFSET msgTitle
    call WriteString
    call Crlf

    INVOKE FindLargest, ADDR arr1, LENGTHOF arr1
    call WriteInt
    call Crlf

    INVOKE FindLargest, ADDR arr2, LENGTHOF arr2
    call WriteInt
    call Crlf

    INVOKE FindLargest, ADDR arr3, LENGTHOF arr3
    call WriteInt
    call Crlf

    exit
main ENDP

FindLargest PROC USES ecx edx esi,
    pArray:PTR SDWORD,
    count:DWORD

    mov  ecx, count
    cmp  ecx, 0
    jle  fl_zero

    mov  esi, pArray
    mov  eax, [esi]
    add  esi, 4
    dec  ecx

fl_loop:
    cmp  ecx, 0
    je   fl_done
    mov  edx, [esi]
    cmp  edx, eax
    jle  fl_next
    mov  eax, edx
fl_next:
    add  esi, 4
    dec  ecx
    jmp  fl_loop

fl_done:
    ret

fl_zero:
    mov  eax, 0
    ret

FindLargest ENDP

END main
