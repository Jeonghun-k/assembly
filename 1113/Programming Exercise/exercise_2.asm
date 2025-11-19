
; Exercise 2 - Extended_Sub
; Environment: 32-bit MASM, Irvine32

.386
.model flat, stdcall
option casemap:none

include Irvine32.inc

.stack 4096

.data

; We will subtract 12-byte integers (3 dwords each)
; ext_a - ext_b = ext_res

ext_a   DWORD 01234567h, 89ABCDEFh, 00112233h
ext_b   DWORD 00001111h, 00000010h, 00000001h
ext_res DWORD 3 DUP(0)

msg_ex2  BYTE "Exercise 2 - Extended_Sub result (low->high dwords):",0

.code

;-------------------------------------------------
; Extended_Sub
; result = first - second, arbitrary byte length
; Inputs:
;   ESI = pointer to first (minuend)
;   EDI = pointer to second (subtrahend)
;   EDX = pointer to result
;   ECX = number of bytes
; Integers stored little-endian (low byte at offset 0).
;-------------------------------------------------
Extended_Sub PROC
    push eax
    push ebx
    push ecx
    push esi
    push edi
    push edx

    xor ebx, ebx        ; index = 0
    clc                 ; clear borrow

ES_Loop:
    cmp ebx, ecx
    jge ES_Done

    mov al, [esi+ebx]
    sbb al, [edi+ebx]
    mov [edx+ebx], al

    inc ebx
    jmp ES_Loop

ES_Done:
    pop edx
    pop edi
    pop esi
    pop ecx
    pop ebx
    pop eax
    ret
Extended_Sub ENDP

main PROC
    mov edx, OFFSET msg_ex2
    call WriteString
    call Crlf

    mov esi, OFFSET ext_a
    mov edi, OFFSET ext_b
    mov edx, OFFSET ext_res
    mov ecx, 12                 ; 12 bytes
    call Extended_Sub

    ; Print low->high dwords
    mov eax, [ext_res]
    call WriteHex
    call Crlf

    mov eax, [ext_res+4]
    call WriteHex
    call Crlf

    mov eax, [ext_res+8]
    call WriteHex
    call Crlf

    exit
main ENDP

END main
