
; Exercise 8 - AddPacked
; Environment: 32-bit MASM, Irvine32

.386
.model flat, stdcall
option casemap:none

include Irvine32.inc

.stack 4096

.data

; Example packed decimal-like bytes (low->high)

; 4-byte examples (plus 1 carry byte for sum)
packed4_a   BYTE 36h,45h,00h,00h       ; 0045 36
packed4_b   BYTE 07h,72h,00h,00h       ; 0072 07
packed4_sum BYTE 5 DUP(0)

; 8-byte examples (plus 1 carry byte for sum)
packed8_a   BYTE 12h,34h,56h,78h,90h,12h,34h,56h
packed8_b   BYTE 00h,00h,00h,01h,00h,00h,00h,01h
packed8_sum BYTE 9 DUP(0)

; 16-byte examples (plus 1 carry byte for sum)
packed16_a  BYTE 01h,23h,45h,67h,89h,01h,23h,45h,67h,89h,01h,23h,45h,67h,89h,01h
packed16_b  BYTE 00h,11h,22h,33h,44h,55h,66h,77h,88h,99h,00h,11h,22h,33h,44h,55h
packed16_sum BYTE 17 DUP(0)

msg_ex8_1   BYTE "Exercise 8 - AddPacked 4-byte sum (low->high bytes):",0
msg_ex8_2   BYTE "Exercise 8 - AddPacked 8-byte sum (low->high bytes):",0
msg_ex8_3   BYTE "Exercise 8 - AddPacked 16-byte sum (low->high bytes):",0

.code

;-------------------------------------------------
; AddPacked
; Adds two packed decimal integers of ECX bytes.
; Inputs:
;   ESI = pointer to first number
;   EDI = pointer to second number
;   EDX = pointer to sum buffer (size = ECX+1)
;   ECX = number of bytes to add
; Behavior:
;   Adds low->high bytes with DAA and final carry byte.
;-------------------------------------------------
AddPacked PROC
    push eax
    push ebx
    push ecx
    push esi
    push edi
    push edx

    xor ebx, ebx                ; index = 0
    mov BYTE PTR [edx+ecx], 0   ; clear extra carry
    clc

AP_Loop:
    cmp ebx, ecx
    jge AP_After

    mov al, [esi+ebx]
    adc al, [edi+ebx]
    daa
    mov [edx+ebx], al

    inc ebx
    jmp AP_Loop

AP_After:
    mov al, 0
    adc al, 0                   ; final carry
    mov [edx+ecx], al

    pop edx
    pop edi
    pop esi
    pop ecx
    pop ebx
    pop eax
    ret
AddPacked ENDP

main PROC
    ; 4-byte test
    mov edx, OFFSET msg_ex8_1
    call WriteString
    call Crlf

    mov esi, OFFSET packed4_a
    mov edi, OFFSET packed4_b
    mov edx, OFFSET packed4_sum
    mov ecx, 4
    call AddPacked

    mov esi, OFFSET packed4_sum
    mov ecx, 5
P4_Print:
    movzx eax, BYTE PTR [esi]
    call WriteHex
    call Crlf
    inc esi
    loop P4_Print
    call Crlf

    ; 8-byte test
    mov edx, OFFSET msg_ex8_2
    call WriteString
    call Crlf

    mov esi, OFFSET packed8_a
    mov edi, OFFSET packed8_b
    mov edx, OFFSET packed8_sum
    mov ecx, 8
    call AddPacked

    mov esi, OFFSET packed8_sum
    mov ecx, 9
P8_Print:
    movzx eax, BYTE PTR [esi]
    call WriteHex
    call Crlf
    inc esi
    loop P8_Print
    call Crlf

    ; 16-byte test
    mov edx, OFFSET msg_ex8_3
    call WriteString
    call Crlf

    mov esi, OFFSET packed16_a
    mov edi, OFFSET packed16_b
    mov edx, OFFSET packed16_sum
    mov ecx, 16
    call AddPacked

    mov esi, OFFSET packed16_sum
    mov ecx, 17
P16_Print:
    movzx eax, BYTE PTR [esi]
    call WriteHex
    call Crlf
    inc esi
    loop P16_Print
    call Crlf

    exit
main ENDP

END main
