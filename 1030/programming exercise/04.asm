INCLUDE Irvine32.inc
.data
prompt1 BYTE "Enter first integer: ",0
prompt2 BYTE "Enter second integer: ",0
sumMsg  BYTE "Sum = ",0
.code
main PROC
    mov ecx,3
L_outer:
    call Clrscr
    mov edx,OFFSET prompt1
    call WriteString
    call ReadInt
    push eax
    mov edx,OFFSET prompt2
    call WriteString
    call ReadInt
    pop ebx
    add eax, ebx
    mov edx,OFFSET sumMsg
    call WriteString
    call WriteInt
    call Crlf
    call WaitMsg
    loop L_outer
    exit
main ENDP
END main
