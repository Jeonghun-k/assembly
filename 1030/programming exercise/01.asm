INCLUDE Irvine32.inc
.data
msg BYTE "Hello Assembly!",0
.code
main PROC
    mov ecx,4
    mov eax,1
L1:
    call SetTextColor
    mov edx,OFFSET msg
    call WriteString
    call Crlf
    inc eax
    loop L1
    call WaitMsg
    exit
main ENDP
END main
