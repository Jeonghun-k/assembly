; 09.asm - BinarySearch with registers
.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

BinarySearch PROTO pArray:PTR DWORD, Count:DWORD, key:DWORD

.data
array DWORD  1,3,5,7,9,11,13,15,17,19,21,23
msg1  BYTE "Array: ",0
msg2  BYTE 0Dh,0Ah,"Search key: ",0
msg3  BYTE 0Dh,0Ah,"Found at index: ",0
msg4  BYTE 0Dh,0Ah,"Not found.",0Dh,0Ah,0

.code
main PROC
    mov edx, OFFSET msg1
    call WriteString
    mov ecx, LENGTHOF array
    mov esi, OFFSET array
PrintArr:
    mov eax, [esi]
    call WriteDec
    mov dl, ' '
    call WriteChar
    add esi, 4
    loop PrintArr
    call Crlf

    mov edx, OFFSET msg2
    call WriteString
    mov eax, 13
    call WriteDec
    call Crlf

    INVOKE BinarySearch, ADDR array, LENGTHOF array, 13
    cmp eax, -1
    je NotFound

    mov edx, OFFSET msg3
    call WriteString
    call WriteDec
    call Crlf
    jmp Done

NotFound:
    mov edx, OFFSET msg4
    call WriteString

Done:
    exit
main ENDP

BinarySearch PROC USES ebx ecx edx esi,
    pArray:PTR DWORD,
    Count:DWORD,
    key:DWORD

    mov esi, pArray

    xor ebx, ebx          ; first = 0
    mov edx, Count
    dec edx               ; last = Count - 1

BS_LOOP:
    cmp ebx, edx
    jg  NOT_FOUND

    mov ecx, ebx
    add ecx, edx
    shr ecx, 1            ; mid

    mov eax, ecx
    shl eax, 2
    mov eax, [esi+eax]

    cmp eax, key
    je  FOUND

    jb  GO_RIGHT          ; a[mid] < key
    dec ecx
    mov edx, ecx          ; last = mid - 1
    jmp BS_LOOP

GO_RIGHT:
    inc ecx
    mov ebx, ecx          ; first = mid + 1
    jmp BS_LOOP

FOUND:
    mov eax, ecx
    ret

NOT_FOUND:
    mov eax, -1
    ret
BinarySearch ENDP

END main
