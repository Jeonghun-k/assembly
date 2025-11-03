INCLUDE Irvine32.inc
.data
buf BYTE 64 DUP(0)
.code
RandomString PROC USES ecx edx
    mov ecx, eax
L1:
    mov eax, 26
    call RandomRange
    add al, 'A'
    mov [edx], al
    inc edx
    loop L1
    ret
RandomString ENDP

main PROC
    call Randomize
    mov ecx,20
Lshow:
    mov eax,16
    mov edx,OFFSET buf
    call RandomString
    ; terminate string
    mov BYTE PTR [edx], 0
    mov edx, OFFSET buf
    call WriteString
    call Crlf
    loop Lshow
    exit
main ENDP
END main
