;
INCLUDE Irvine32.inc
.data
menu BYTE "1 AND  2 OR  3 NOT  4 XOR  5 Exit:",13,10,0
askx BYTE "x(hex): ",0
asky BYTE "y(hex): ",0
res  BYTE " = ",0
.code
main PROC
M:  mWrite menu
    call ReadDec
    cmp eax,5
    je  Q
    cmp eax,1
    je  A
    cmp eax,2
    je  O
    cmp eax,3
    je  N
    cmp eax,4
    je  X
    jmp M
A:  mWrite askx
    call ReadHex
    push eax
    mWrite asky
    call ReadHex
    pop edx
    and eax,edx
    jmp P
O:  mWrite askx
    call ReadHex
    push eax
    mWrite asky
    call ReadHex
    pop edx
    or  eax,edx
    jmp P
N:  mWrite askx
    call ReadHex
    not eax
    jmp P
X:  mWrite askx
    call ReadHex
    push eax
    mWrite asky
    call ReadHex
    pop edx
    xor eax,edx
P:  mWrite res
    call WriteHex
    call CrLf
    jmp M
Q:  exit
main ENDP
END main
