; 04.asm - Str_find
.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

Str_find PROTO pSource:PTR BYTE, pTarget:PTR BYTE

.data
target BYTE "123ABC342432",0
source BYTE "ABC",0
pos    DWORD ?

msg1 BYTE "Target: ",0
msg2 BYTE 0Dh,0Ah,"Source: ",0
msg3 BYTE 0Dh,0Ah,"Found at offset (from target): ",0
msg4 BYTE 0Dh,0Ah,"Not found.",0Dh,0Ah,0

.code
main PROC
    mov edx, OFFSET msg1
    call WriteString
    mov edx, OFFSET target
    call WriteString

    mov edx, OFFSET msg2
    call WriteString
    mov edx, OFFSET source
    call WriteString
    call Crlf

    INVOKE Str_find, ADDR source, ADDR target
    jnz notFound

    mov pos, eax
    mov edx, OFFSET msg3
    call WriteString

    mov eax, pos
    sub eax, OFFSET target
    call WriteDec
    call Crlf
    jmp done

notFound:
    mov edx, OFFSET msg4
    call WriteString

done:
    exit
main ENDP

Str_find PROC USES esi edi ebx ecx edx,
    pSource:PTR BYTE,
    pTarget:PTR BYTE

    mov edi, pTarget

OUTER_LOOP:
    mov al, [edi]
    cmp al, 0
    je  NOT_FOUND

    mov esi, pSource
    mov ebx, edi

INNER_LOOP:
    mov al, [esi]
    cmp al, 0
    je  FOUND
    mov dl, [ebx]
    cmp dl, 0
    je  NOT_FOUND
    cmp al, dl
    jne NO_MATCH
    inc esi
    inc ebx
    jmp INNER_LOOP

FOUND:
    mov eax, edi
    cmp eax, eax         ; ZF=1
    ret

NO_MATCH:
    inc edi
    jmp OUTER_LOOP

NOT_FOUND:
    mov eax, 1
    cmp eax, 0           ; ZF=0
    ret
Str_find ENDP

END main
