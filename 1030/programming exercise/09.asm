INCLUDE Irvine32.inc
.data
counter DWORD 0
.code
Recur PROC
    inc counter
    loop Lcall
    ret
Lcall:
    call Recur
    ret
Recur ENDP

main PROC
    mov ecx,5
    call Recur
    mov eax, counter
    call WriteDec
    call Crlf
    exit
main ENDP
END main
