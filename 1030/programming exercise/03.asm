INCLUDE Irvine32.inc
.data
prompt1 BYTE "Enter first integer: ",0
prompt2 BYTE "Enter second integer: ",0
sumMsg  BYTE "Sum = ",0
num1 SDWORD ?
num2 SDWORD ?
.code
main PROC
    call Clrscr
    mov dh,12
    mov dl,25
    call Gotoxy

    mov edx,OFFSET prompt1
    call WriteString
    call ReadInt
    mov num1,eax

    mov edx,OFFSET prompt2
    call WriteString
    call ReadInt
    mov num2,eax

    mov eax,num1
    add eax,num2

    mov edx,OFFSET sumMsg
    call WriteString
    call WriteInt
    call Crlf
    call WaitMsg
    exit
main ENDP
END main
