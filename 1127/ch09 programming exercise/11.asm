; 11.asm - LetterMatrix sets with exactly 2 vowels
.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

GEN_MATRIX PROTO pMatrix:PTR BYTE
PRINT_MATRIX PROTO pMatrix:PTR BYTE
PRINT_VALID_SETS PROTO pMatrix:PTR BYTE

.data
matrix  BYTE 16 DUP(?)

vowels      BYTE "AEIOU",0
consonants  BYTE "BCDFGHJKLMNPQRSTVWXYZ",0

msg1 BYTE "Matrix:",0Dh,0Ah,0
msg2 BYTE 0Dh,0Ah,"4-letter sets with exactly 2 vowels:",0Dh,0Ah,0

colBuf  BYTE 4 DUP(?)
diagBuf BYTE 4 DUP(?)

.code
main PROC
    call Randomize

    INVOKE GEN_MATRIX, ADDR matrix

    mov edx, OFFSET msg1
    call WriteString
    INVOKE PRINT_MATRIX, ADDR matrix

    mov edx, OFFSET msg2
    call WriteString
    INVOKE PRINT_VALID_SETS, ADDR matrix

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

COUNT_VOWELS PROC USES ebx ecx edx esi,
    pChars:PTR BYTE

    mov esi, pChars
    mov ecx, 4
    xor eax, eax

NEXT_CHAR:
    mov dl, [esi]
    mov ebx, OFFSET vowels
VLOOP:
    mov bl, [ebx]
    cmp bl, 0
    je  NOT_V
    cmp dl, bl
    je  IS_V
    inc ebx
    jmp VLOOP

IS_V:
    inc eax
NOT_V:
    inc esi
    loop NEXT_CHAR
    ret
COUNT_VOWELS ENDP

PRINT_SET PROC USES ecx eax edx esi,
    pChars:PTR BYTE

    mov esi, pChars
    mov ecx, 4
PLOOP:
    mov dl, [esi]
    call WriteChar
    inc esi
    loop PLOOP
    call Crlf
    ret
PRINT_SET ENDP

PRINT_VALID_SETS PROC USES eax ebx ecx edx esi edi,
    pMatrix:PTR BYTE

    mov edi, pMatrix

    ; rows
    mov ecx, 4
    mov esi, edi
ROW:
    push ecx
    INVOKE COUNT_VOWELS, esi
    cmp eax, 2
    jne NEXT_ROW
    INVOKE PRINT_SET, esi
NEXT_ROW:
    add esi, 4
    pop ecx
    loop ROW

    ; columns
    mov ecx, 4
    mov ebx, 0
COL:
    push ecx
    mov esi, OFFSET colBuf
    mov edx, pMatrix
    add edx, ebx
    mov ecx, 4
COL_GATHER:
    mov al, [edx]
    mov [esi], al
    add edx, 4
    inc esi
    loop COL_GATHER

    INVOKE COUNT_VOWELS, ADDR colBuf
    cmp eax, 2
    jne NEXT_COL
    INVOKE PRINT_SET, ADDR colBuf

NEXT_COL:
    inc ebx
    pop ecx
    loop COL

    ; diag 1
    mov esi, OFFSET diagBuf
    mov ecx, 4
    mov ebx, 0
D1_LOOP:
    mov al, [pMatrix+ebx*5]
    mov [esi], al
    inc esi
    inc ebx
    loop D1_LOOP

    INVOKE COUNT_VOWELS, ADDR diagBuf
    cmp eax, 2
    jne D2_START
    INVOKE PRINT_SET, ADDR diagBuf

D2_START:
    ; diag 2 (0,3)-(3,0)
    mov esi, OFFSET diagBuf
    mov ecx, 4
    mov ebx, 0
D2_LOOP:
    mov eax, ebx
    imul eax, 3
    add eax, 3
    mov al, [pMatrix+eax]
    mov [esi], al
    inc esi
    inc ebx
    loop D2_LOOP

    INVOKE COUNT_VOWELS, ADDR diagBuf
    cmp eax, 2
    jne DONE
    INVOKE PRINT_SET, ADDR diagBuf

DONE:
    ret
PRINT_VALID_SETS ENDP

END main
