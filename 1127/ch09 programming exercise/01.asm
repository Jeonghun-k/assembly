; 01.asm - Str_copyN (copy at most N chars)
.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

Str_copyN PROTO pDest:PTR BYTE, pSrc:PTR BYTE, maxCount:DWORD

.data
sourceStr  BYTE "Hello, Assembly World!",0
destStr    BYTE 50 DUP(0)
msg1       BYTE "Source : ",0
msg2       BYTE 0Dh,0Ah,"Dest   : ",0
msg3       BYTE 0Dh,0Ah,"(copied at most 10 chars)",0Dh,0Ah,0

.code
main PROC
    mov  edx, OFFSET msg1
    call WriteString
    mov  edx, OFFSET sourceStr
    call WriteString

    INVOKE Str_copyN, ADDR destStr, ADDR sourceStr, 10

    mov  edx, OFFSET msg2
    call WriteString
    mov  edx, OFFSET destStr
    call WriteString

    mov  edx, OFFSET msg3
    call WriteString

    exit
main ENDP

Str_copyN PROC USES esi edi ecx,
    pDest:PTR BYTE,
    pSrc:PTR BYTE,
    maxCount:DWORD

    mov edi, pDest
    mov esi, pSrc
    mov ecx, maxCount

COPY_LOOP:
    cmp ecx, 0
    je  FINISH

    mov al, [esi]
    cmp al, 0
    je  FINISH

    mov [edi], al
    inc esi
    inc edi
    dec ecx
    jmp COPY_LOOP

FINISH:
    mov BYTE PTR [edi], 0
    ret
Str_copyN ENDP

END main
