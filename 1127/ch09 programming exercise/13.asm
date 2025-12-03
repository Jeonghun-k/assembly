; 13.asm - Str_trimLeading
.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

Str_trimLeading PROTO pStr:PTR BYTE, ch:BYTE

.data
testStr BYTE "###ABC",0
msg1    BYTE "Before: ",0
msg2    BYTE 0Dh,0Ah,"After : ",0Dh,0Ah,0

.code
main PROC
    mov edx, OFFSET msg1
    call WriteString
    mov edx, OFFSET testStr
    call WriteString

    INVOKE Str_trimLeading, ADDR testStr, '#'

    mov edx, OFFSET msg2
    call WriteString
    mov edx, OFFSET testStr
    call WriteString
    call Crlf

    exit
main ENDP

Str_trimLeading PROC USES esi edi,
    pStr:PTR BYTE,
    ch:BYTE

    mov esi, pStr
    mov al,  ch

SKIP_LOOP:
    mov bl, [esi]
    cmp bl, 0
    je  DONE
    cmp bl, al
    jne COPY_START
    inc esi
    jmp SKIP_LOOP

COPY_START:
    mov edi, pStr

COPY_LOOP:
    mov bl, [esi]
    mov [edi], bl
    inc esi
    inc edi
    cmp bl, 0
    jne COPY_LOOP

DONE:
    ret
Str_trimLeading ENDP

END main
