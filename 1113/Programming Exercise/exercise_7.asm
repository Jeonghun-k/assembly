
; Exercise 7 - BitwiseMultiply
; Environment: 32-bit MASM, Irvine32

.386
.model flat, stdcall
option casemap:none

include Irvine32.inc

.stack 4096

.data

msg_ex7   BYTE "Exercise 7 - BitwiseMultiply:",0
msg_ex7_2 BYTE "13 * 17 = ",0

.code

;-------------------------------------------------
; BitwiseMultiply
; Multiplies EAX (multiplicand) by EBX (multiplier)
; using only shifting and addition.
; Inputs:
;   EAX = multiplicand
;   EBX = multiplier (unsigned)
; Returns:
;   EAX = product (32-bit, assumes no overflow)
;-------------------------------------------------
BitwiseMultiply PROC
    push ecx
    push edx
    push ebx

    mov ecx, ebx        ; copy multiplier
    xor edx, edx        ; result = 0

BM_Loop:
    cmp ecx, 0
    je  BM_Done

    test ecx, 1
    jz   BM_SkipAdd
    add  edx, eax       ; if LSB of multiplier is 1, add multiplicand

BM_SkipAdd:
    shl eax, 1          ; multiplicand <<= 1
    shr ecx, 1          ; multiplier >>= 1
    jmp BM_Loop

BM_Done:
    mov eax, edx        ; return result

    pop ebx
    pop edx
    pop ecx
    ret
BitwiseMultiply ENDP

main PROC
    mov edx, OFFSET msg_ex7
    call WriteString
    call Crlf

    mov edx, OFFSET msg_ex7_2
    call WriteString

    mov eax, 13
    mov ebx, 17
    call BitwiseMultiply
    call WriteDec
    call Crlf

    exit
main ENDP

END main
