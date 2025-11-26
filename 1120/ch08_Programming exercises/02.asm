; 02.asm
; Programming Exercises 8.11 #2 - Chess Board

INCLUDE Irvine32.inc

.data
msgTitle BYTE "8.11 #2 - Chess Board",0
twoSpaces BYTE "  ",0

.code
DrawSquare PROC uses eax edx,
    x:BYTE,
    y:BYTE,
    fore:BYTE,
    back:BYTE

    mov  al, x
    shl  al, 1
    mov  dl, al
    mov  al, y
    mov  dh, al
    INVOKE Gotoxy, dl, dh

    movzx eax, back
    shl   eax, 4
    movzx edx, fore
    or    eax, edx
    INVOKE SetTextColor, eax

    mov  edx, OFFSET twoSpaces
    call WriteString

    ret
DrawSquare ENDP

DrawBoard PROC uses eax ebx ecx edx,
    foreDark:BYTE,
    backDark:BYTE,
    foreLight:BYTE,
    backLight:BYTE

    mov  bl, 0
row_loop:
    cmp  bl, 8
    jge  db_done
    mov  cl, 0
col_loop:
    cmp  cl, 8
    jge  next_row

    mov  al, bl
    add  al, cl
    and  al, 1
    cmp  al, 0
    jne  light

    INVOKE DrawSquare, cl, bl, foreDark, backDark
    jmp  after_square

light:
    INVOKE DrawSquare, cl, bl, foreLight, backLight

after_square:
    inc  cl
    jmp  col_loop

next_row:
    inc  bl
    jmp  row_loop

db_done:
    ret
DrawBoard ENDP

main PROC
    call Clrscr
    mov  edx, OFFSET msgTitle
    call WriteString
    call Crlf

    INVOKE DrawBoard, black, lightGray, black, white
    INVOKE SetTextColor, white + (black SHL 4)
    call Crlf

    exit
main ENDP

END main
