; 06.asm - Get_frequencies
.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

Get_frequencies PROTO pStr:PTR BYTE, pTable:PTR DWORD

.data
target    BYTE "AAEBDCFBBC",0
freqTable DWORD 256 DUP(0)

msg1 BYTE "String: ",0
msg2 BYTE 0Dh,0Ah,"Frequencies for A..F:",0Dh,0Ah,0

.code
main PROC
    mov edx, OFFSET msg1
    call WriteString
    mov edx, OFFSET target
    call WriteString
    call Crlf

    INVOKE Get_frequencies, ADDR target, ADDR freqTable

    mov edx, OFFSET msg2
    call WriteString

    mov ecx, 6
    mov eax, 'A'
PRINT_LOOP:
    push ecx
    mov dl, al
    call WriteChar
    mov dl, ':'
    call WriteChar
    mov dl, ' '
    call WriteChar

    movzx ebx, al
    mov edx, OFFSET freqTable
    mov esi, ebx
    shl esi, 2
    mov eax, [edx+esi]
    call WriteDec
    call Crlf

    inc al
    pop ecx
    loop PRINT_LOOP

    exit
main ENDP

Get_frequencies PROC USES esi edi eax,
    pStr:PTR BYTE,
    pTable:PTR DWORD

    mov esi, pStr
    mov edi, pTable

NEXT_CHAR:
    mov al, [esi]
    cmp al, 0
    je  DONE

    movzx eax, al
    shl eax, 2
    inc DWORD PTR [edi+eax]

    inc esi
    jmp NEXT_CHAR

DONE:
    ret
Get_frequencies ENDP

END main
