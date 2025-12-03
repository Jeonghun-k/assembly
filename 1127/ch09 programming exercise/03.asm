; 03.asm - Str_remove
.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

Str_remove PROTO pPos:PTR BYTE, count:DWORD

.data
target  BYTE "abcxxxxdefghijklmop",0
msg1    BYTE "Before: ",0
msg2    BYTE 0Dh,0Ah,"After : ",0Dh,0Ah,0

.code
main PROC
    mov  edx, OFFSET msg1
    call WriteString
    mov  edx, OFFSET target
    call WriteString

    ; remove "xxxx" (index 3, length 4)
    INVOKE Str_remove, ADDR target+3, 4

    mov  edx, OFFSET msg2
    call WriteString
    mov  edx, OFFSET target
    call WriteString
    call Crlf

    exit
main ENDP

Str_remove PROC USES esi edi,
    pPos:PTR BYTE,
    count:DWORD

    mov edi, pPos
    mov esi, pPos
    add esi, count

SHIFT_LOOP:
    mov al, [esi]
    mov [edi], al
    inc esi
    inc edi
    cmp al, 0
    jne SHIFT_LOOP
    ret
Str_remove ENDP

END main
