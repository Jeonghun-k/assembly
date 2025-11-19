
; Exercise 3 - PackedToAsc
; Environment: 32-bit MASM, Irvine32

.386
.model flat, stdcall
option casemap:none

include Irvine32.inc

.stack 4096

.data

; Each DWORD is treated as 8 packed decimal digits (4 bytes, 8 nibbles)

packed1 DWORD 12345678h
packed2 DWORD 00001234h
packed3 DWORD 87654321h
packed4 DWORD 00000099h
packed5 DWORD 99999999h

buf1    BYTE 9 DUP(0)      ; 8 digits + null
buf2    BYTE 9 DUP(0)
buf3    BYTE 9 DUP(0)
buf4    BYTE 9 DUP(0)
buf5    BYTE 9 DUP(0)

msg_ex3 BYTE "Exercise 3 - PackedToAsc:",0

.code

;-------------------------------------------------
; PackedToAsc
; Converts 4-byte packed decimal (8 nibbles)
; into 8 ASCII digits.
; Inputs:
;   EAX = address of packed DWORD
;   EDX = address of buffer (>= 9 bytes)
;-------------------------------------------------
PackedToAsc PROC
    push eax
    push ebx
    push ecx
    push edx

    mov ebx, [eax]      ; load 4 bytes
    mov ecx, 8          ; 8 nibbles

PTA_Loop:
    rol ebx, 4          ; rotate left 4 bits
    mov al, bl
    and al, 0Fh         ; low nibble
    add al, '0'         ; to ASCII
    mov [edx], al
    inc edx
    loop PTA_Loop

    mov BYTE PTR [edx], 0 ; null-terminate

    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
PackedToAsc ENDP

main PROC
    mov edx, OFFSET msg_ex3
    call WriteString
    call Crlf

    ; packed1
    mov eax, OFFSET packed1
    mov edx, OFFSET buf1
    call PackedToAsc
    mov edx, OFFSET buf1
    call WriteString
    call Crlf

    ; packed2
    mov eax, OFFSET packed2
    mov edx, OFFSET buf2
    call PackedToAsc
    mov edx, OFFSET buf2
    call WriteString
    call Crlf

    ; packed3
    mov eax, OFFSET packed3
    mov edx, OFFSET buf3
    call PackedToAsc
    mov edx, OFFSET buf3
    call WriteString
    call Crlf

    ; packed4
    mov eax, OFFSET packed4
    mov edx, OFFSET buf4
    call PackedToAsc
    mov edx, OFFSET buf4
    call WriteString
    call Crlf

    ; packed5
    mov eax, OFFSET packed5
    mov edx, OFFSET buf5
    call PackedToAsc
    mov edx, OFFSET buf5
    call WriteString
    call Crlf

    exit
main ENDP

END main
