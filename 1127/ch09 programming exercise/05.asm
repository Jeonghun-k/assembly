; 05.asm - Str_nextWord
.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

Str_nextWord PROTO pStr:PTR BYTE, delim:BYTE

.data
target BYTE "Johnson,Calvin",0

msg1 BYTE "Original: ",0
msg2 BYTE 0Dh,0Ah,"After  : ",0
msg3 BYTE 0Dh,0Ah,"Next word: ",0
msgNF BYTE 0Dh,0Ah,"Delimiter not found.",0Dh,0Ah,0

.code
main PROC
    mov edx, OFFSET msg1
    call WriteString
    mov edx, OFFSET target
    call WriteString

    INVOKE Str_nextWord, ADDR target, ','

    jnz notFound

    mov edx, OFFSET msg2
    call WriteString
    mov edx, OFFSET target
    call WriteString

    mov edx, OFFSET msg3
    call WriteString
    mov edx, eax         ; EAX -> next word
    call WriteString
    call Crlf
    jmp done

notFound:
    mov edx, OFFSET msgNF
    call WriteString

done:
    exit
main ENDP

Str_nextWord PROC USES esi,
    pStr:PTR BYTE,
    delim:BYTE

    mov esi, pStr
    mov al,  delim

SCAN_LOOP:
    mov bl, [esi]
    cmp bl, 0
    je  NOT_FOUND
    cmp bl, al
    je  FOUND
    inc esi
    jmp SCAN_LOOP

FOUND:
    mov BYTE PTR [esi], 0
    lea eax, [esi+1]
    cmp eax, eax          ; ZF=1
    ret

NOT_FOUND:
    mov eax, 1
    cmp eax, 0            ; ZF=0
    ret
Str_nextWord ENDP

END main
