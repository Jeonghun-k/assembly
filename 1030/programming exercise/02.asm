INCLUDE Irvine32.inc
.data
startIdx DWORD 1
chars   BYTE 'H','A','C','E','B','D','F','G'
links   DWORD 0,4,5,6,2,3,7,0
outbuf  BYTE 8 DUP(?),0
.code
main PROC
    mov esi, startIdx
    mov edi, OFFSET outbuf
L_traverse:
    mov al, chars[esi]
    mov [edi], al
    inc edi
    mov eax, links[esi*4]
    mov esi, eax
    cmp esi, 0
    jne L_traverse
    mov edx, OFFSET outbuf
    call WriteString
    call Crlf
    exit
main ENDP
END main
