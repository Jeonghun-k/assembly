; 10.asm - LetterMatrix (4x4, 50% vowels)
.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

GEN_MATRIX PROTO pMatrix:PTR BYTE
PRINT_MATRIX PROTO pMatrix:PTR BYTE

.data
matrix  BYTE 16 DUP(?)

vowels      BYTE "AEIOU",0
consonants  BYTE "BCDFGHJKLMNPQRSTVWXYZ",0

msg1 BYTE "Random letter matrices:",0Dh,0Ah,0

.code
main PROC
    call Randomize

    mov edx, OFFSET msg1
    call WriteString

    mov ecx, 5
GEN_LOOP:
    INVOKE GEN_MATRIX, ADDR matrix
    INVOKE PRINT_MATRIX, ADDR matrix
    call Crlf
    loop GEN_LOOP

    exit
main ENDP

GEN_MATRIX PROC USES esi edi eax ebx edx,
    pMatrix:PTR BYTE

    mov edi, pMatrix
    mov ecx, 16

FILL_LOOP:
    mov eax, 2
    call RandomRange
    cmp eax, 0
    je  MAKE_VOWEL

    mov eax, LENGTHOF consonants-1
    call RandomRange
    movzx ebx, al
    mov dl, consonants[ebx]
    jmp STORE_CHAR

MAKE_VOWEL:
    mov eax, LENGTHOF vowels-1
    call RandomRange
    movzx ebx, al
    mov dl, vowels[ebx]

STORE_CHAR:
    mov [edi], dl
    inc edi
    loop FILL_LOOP
    ret
GEN_MATRIX ENDP

PRINT_MATRIX PROC USES esi ecx eax,
    pMatrix:PTR BYTE

    mov esi, pMatrix
    mov ecx, 4

ROW_LOOP:
    push ecx
    mov ecx, 4
COL_LOOP:
    mov al, [esi]
    mov dl, al
    call WriteChar
    mov dl, ' '
    call WriteChar
    inc esi
    loop COL_LOOP
    call Crlf
    pop ecx
    loop ROW_LOOP
    ret
PRINT_MATRIX ENDP

END main
