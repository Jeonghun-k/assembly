;
INCLUDE Irvine32.inc
.data
menu BYTE "1 AND  2 OR  3 NOT  4 XOR  5 Exit:",13,10,0
mA BYTE "AND",13,10,0
mO BYTE "OR",13,10,0
mN BYTE "NOT",13,10,0
mX BYTE "XOR",13,10,0
tbl DWORD OFFSET mA, OFFSET mO, OFFSET mN, OFFSET mX
.code
main PROC
L:  mWrite menu
    call ReadDec
    cmp eax,5
    je  Q
    dec eax
    cmp eax,3
    ja  L
    mov edx,[tbl+eax*4]
    call WriteString
    jmp L
Q:  exit
main ENDP
END main
