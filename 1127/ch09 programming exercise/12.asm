; 12.asm - calc_row_sum
.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

calc_row_sum PROTO

.data
ROWS   EQU 3
COLS   EQU 4

byteArr  BYTE  1,2,3,4,  5,6,7,8,  9,10,11,12
wordArr  WORD  1,2,3,4,  5,6,7,8,  9,10,11,12
dwordArr DWORD 1,2,3,4,  5,6,7,8,  9,10,11,12

msg1 BYTE "Row index: ",0
msg2 BYTE 0Dh,0Ah,"Byte row sum  : ",0
msg3 BYTE 0Dh,0Ah,"Word row sum  : ",0
msg4 BYTE 0Dh,0Ah,"Dword row sum : ",0Dh,0Ah,0

.code
main PROC
    mov edx, OFFSET msg1
    call WriteString
    mov eax, 1
    call WriteDec
    call Crlf

    ; byte row
    push 1
    push 1
    push COLS
    push OFFSET byteArr
    call calc_row_sum
    add esp, 16

    mov edx, OFFSET msg2
    call WriteString
    call WriteDec

    ; word row
    push 1
    push 2
    push COLS
    push OFFSET wordArr
    call calc_row_sum
    add esp, 16

    mov edx, OFFSET msg3
    call WriteString
    call WriteDec

    ; dword row
    push 1
    push 4
    push COLS
    push OFFSET dwordArr
    call calc_row_sum
    add esp, 16

    mov edx, OFFSET msg4
    call WriteString
    call WriteDec
    call Crlf

    exit
main ENDP

calc_row_sum PROC
    push ebp
    mov  ebp, esp
    push esi
    push ecx
    push ebx
    push edx

    mov esi, [ebp+8]     ; base
    mov ecx, [ebp+12]    ; row size
    mov ebx, [ebp+16]    ; type size
    mov edx, [ebp+20]    ; row index

    mov eax, edx
    imul eax, ecx        ; row*cols
    imul eax, ebx        ; *type
    add esi, eax         ; start addr

    xor eax, eax         ; sum

SUM_LOOP:
    cmp ecx, 0
    je  DONE

    cmp ebx, 1
    je  BYTE_CASE
    cmp ebx, 2
    je  WORD_CASE

DWORD_CASE:
    add eax, [esi]
    add esi, 4
    dec ecx
    jmp SUM_LOOP

WORD_CASE:
    movzx edx, WORD PTR [esi]
    add eax, edx
    add esi, 2
    dec ecx
    jmp SUM_LOOP

BYTE_CASE:
    movzx edx, BYTE PTR [esi]
    add eax, edx
    inc esi
    dec ecx
    jmp SUM_LOOP

DONE:
    pop edx
    pop ebx
    pop ecx
    pop esi
    pop ebp
    ret
calc_row_sum ENDP

END main
