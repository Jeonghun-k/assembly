; 14.asm - Str_trimSet
.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

Str_trimSet PROTO pStr:PTR BYTE, pSet:PTR BYTE

.data
testStr BYTE "ABC#$&",0
filter  BYTE "%#!;$&*",0

msg1 BYTE "Before: ",0
msg2 BYTE 0Dh,0Ah,"After : ",0Dh,0Ah,0

.code
main PROC
    mov edx, OFFSET msg1
    call WriteString
    mov edx, OFFSET testStr
    call WriteString

    INVOKE Str_trimSet, ADDR testStr, ADDR filter

    mov edx, OFFSET msg2
    call WriteString
    mov edx, OFFSET testStr
    call WriteString
    call Crlf

    exit
main ENDP

Str_trimSet PROC USES esi edi ebx ecx edx,
    pStr:PTR BYTE,
    pSet:PTR BYTE

    mov edi, pStr
FIND_END:
    mov al, [edi]
    cmp al, 0
    je  BACK_START
    inc edi
    jmp FIND_END

BACK_START:
    dec edi
    std

TRIM_LOOP:
    cmp edi, pStr
    jb  DONE_RESET

    mov al, [edi]
    mov esi, pSet
CHECK_SET:
    mov bl, [esi]
    cmp bl, 0
    je  NOT_IN_SET
    cmp al, bl
    je  IN_SET
    inc esi
    jmp CHECK_SET

IN_SET:
    mov BYTE PTR [edi], 0
    dec edi
    jmp TRIM_LOOP

NOT_IN_SET:
    jmp DONE_RESET

DONE_RESET:
    cld
    ret
Str_trimSet ENDP

END main
