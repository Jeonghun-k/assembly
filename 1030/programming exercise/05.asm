INCLUDE Irvine32.inc
.data
count DWORD 50
.code
BetterRandomRange PROC
    push ecx
    sub eax, ebx
    call RandomRange
    add eax, ebx
    pop ecx
    ret
BetterRandomRange ENDP

main PROC
    call Randomize
    mov ecx, count
L1:
    mov ebx, -300
    mov eax, 100
    call BetterRandomRange
    call WriteInt
    call Crlf
    loop L1
    exit
main ENDP
END main
