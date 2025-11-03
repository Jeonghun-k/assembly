INCLUDE Irvine32.inc
.data
msg BYTE "#",0
.code
main PROC
    mov bh,0
BgLoop:
    mov bl,0
FgLoop:
    movzx eax, bh
    shl eax, 4
    movzx edx, bl
    add eax, edx
    call SetTextColor
    mov edx, OFFSET msg
    call WriteString
    mov al, ' '
    call WriteChar
    inc bl
    cmp bl,16
    jl FgLoop
    call Crlf
    inc bh
    cmp bh,16
    jl BgLoop
    call WaitMsg
    exit
main ENDP
END main
