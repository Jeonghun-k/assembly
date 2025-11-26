; 10.asm
; Programming Exercises 8.11 #10 - ShowParams

INCLUDE Irvine32.inc

.data
msgTitle   BYTE "8.11 #10 - ShowParams demo",0
hdr1       BYTE "Stack parameters:",0
hdr2       BYTE "---------------------------",0
msgAddr    BYTE "Address ",0
msgEq      BYTE " = ",0

.code
ShowParams PROTO paramCount:DWORD
MySample   PROTO first:DWORD, second:DWORD, third:DWORD

main PROC
    call Clrscr
    mov  edx, OFFSET msgTitle
    call WriteString
    call Crlf

    INVOKE MySample, 1234h, 5000h, 6543h

    exit
main ENDP

MySample PROC first:DWORD, second:DWORD, third:DWORD
    LOCAL paramCount:DWORD

    mov  paramCount, 3
    INVOKE ShowParams, paramCount

    ret 12
MySample ENDP

ShowParams PROC USES eax ecx edx esi,
    paramCount:DWORD

    mov  edx, OFFSET hdr1
    call WriteString
    call Crlf
    mov  edx, OFFSET hdr2
    call WriteString
    call Crlf

    mov  ecx, paramCount
    cmp  ecx, 0
    jle  sp_done

    mov  esi, [ebp]
    add  esi, 8

sp_loop:
    cmp  ecx, 0
    je   sp_done

    mov  edx, OFFSET msgAddr
    call WriteString

    mov  eax, esi
    call WriteHex

    mov  edx, OFFSET msgEq
    call WriteString

    mov  eax, [esi]
    call WriteHex
    call Crlf

    add  esi, 4
    dec  ecx
    jmp  sp_loop

sp_done:
    ret 4

ShowParams ENDP

END main
