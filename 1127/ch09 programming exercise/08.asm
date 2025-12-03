; 08.asm - BubbleSort with exchange flag
.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

BubbleSort PROTO pArray:PTR DWORD, Count:DWORD

.data
array DWORD  9, 5, 3, 8, 1, 4, 7, 2, 6, 0FFFFFFFFh
msg1  BYTE "Before sort:",0Dh,0Ah,0
msg2  BYTE 0Dh,0Ah,"After sort :",0Dh,0Ah,0

.code
main PROC
    mov edx, OFFSET msg1
    call WriteString

    mov ecx, LENGTHOF array
    mov esi, OFFSET array
PrintOrig:
    mov eax, [esi]
    call WriteDec
    mov dl, ' '
    call WriteChar
    add esi, 4
    loop PrintOrig
    call Crlf

    INVOKE BubbleSort, ADDR array, LENGTHOF array

    mov edx, OFFSET msg2
    call WriteString

    mov ecx, LENGTHOF array
    mov esi, OFFSET array
PrintSorted:
    mov eax, [esi]
    call WriteDec
    mov dl, ' '
    call WriteChar
    add esi, 4
    loop PrintSorted
    call Crlf

    exit
main ENDP

BubbleSort PROC USES eax ecx edx esi edi ebx,
    pArray:PTR DWORD,
    Count:DWORD

    mov edi, pArray
    mov ecx, Count
    dec ecx
    jle DONE

OUTER_LOOP:
    mov ebx, 0           ; exchange flag
    push ecx

    mov esi, edi
    mov edx, ecx

INNER_LOOP:
    mov eax, [esi]
    cmp [esi+4], eax
    jge NOSWAP
    xchg eax, [esi+4]
    mov [esi], eax
    mov ebx, 1

NOSWAP:
    add esi, 4
    dec edx
    jg INNER_LOOP

    pop ecx

    cmp ebx, 0
    je DONE

    loop OUTER_LOOP

DONE:
    ret
BubbleSort ENDP

END main
