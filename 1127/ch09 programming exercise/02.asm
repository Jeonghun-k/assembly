; 02.asm - Str_concat
.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

Str_concat PROTO pTarget:PTR BYTE, pSource:PTR BYTE

.data
targetStr BYTE "ABCDE",10 DUP(0)
sourceStr BYTE "FGH",0

msg1 BYTE "Before: ",0
msg2 BYTE 0Dh,0Ah,"After : ",0Dh,0Ah,0

.code
main PROC
    mov edx, OFFSET msg1
    call WriteString
    mov edx, OFFSET targetStr
    call WriteString

    INVOKE Str_concat, ADDR targetStr, ADDR sourceStr

    mov edx, OFFSET msg2
    call WriteString
    mov edx, OFFSET targetStr
    call WriteString
    call Crlf

    exit
main ENDP

Str_concat PROC USES esi edi,
    pTarget:PTR BYTE,
    pSource:PTR BYTE

    mov edi, pTarget
FIND_END:
    mov al, [edi]
    cmp al, 0
    je  START_COPY
    inc edi
    jmp FIND_END

START_COPY:
    mov esi, pSource
COPY_LOOP:
    mov al, [esi]
    mov [edi], al
    inc esi
    inc edi
    cmp al, 0
    jne COPY_LOOP
    ret
Str_concat ENDP

END main
