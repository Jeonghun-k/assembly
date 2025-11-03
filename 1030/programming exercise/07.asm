INCLUDE Irvine32.inc
.data
ch BYTE "*",0
.code
main PROC
    call Randomize
    mov ecx,100
L1:
    call GetMaxXY
    movzx eax, dh
    call RandomRange
    mov dh, al
    movzx eax, dl
    call RandomRange
    mov dl, al
    call Gotoxy
    mov edx, OFFSET ch
    call WriteString
    INVOKE Delay, 100
    loop L1
    exit
main ENDP
END main
