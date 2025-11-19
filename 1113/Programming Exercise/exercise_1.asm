
; Exercise 1 - WriteScaled
; Environment: 32-bit MASM, Irvine32

.386
.model flat, stdcall
option casemap:none

include Irvine32.inc

.stack 4096

.data

DECIMAL_OFFSET EQU 5

decimal_one   BYTE "100123456789765"
len_one       =   ($ - decimal_one)

decimal_two   BYTE "987654321"
len_two       =   ($ - decimal_two)

decimal_three BYTE "31415926"
len_three     =   ($ - decimal_three)

msg_ex1_1   BYTE "Exercise 1 - Number 1: ",0
msg_ex1_2   BYTE "Exercise 1 - Number 2: ",0
msg_ex1_3   BYTE "Exercise 1 - Number 3: ",0

.code

;-------------------------------------------------
; WriteScaled
; Prints a decimal string with implied decimal point.
; Inputs:
;   EDX = address of ASCII digits (no decimal point)
;   ECX = number of digits
;   EBX = decimal offset (# of digits from right)
; Example:
;   "100123456789765", len=15, offset=5
;   -> prints 1001234567.89765
;-------------------------------------------------
WriteScaled PROC
    push eax
    push ecx
    push edx
    push ebx

    mov eax, ecx        ; eax = length
    sub eax, ebx        ; eax = dotIndex (0-based)
    mov ebx, eax        ; ebx = dotIndex

    xor eax, eax        ; eax = i = 0

WS_Loop:
    cmp eax, ecx
    jge WS_Done

    ; if i == dotIndex, print '.'
    cmp eax, ebx
    jne WS_NoDot
    mov al, '.'
    call WriteChar
WS_NoDot:
    mov al, [edx+eax]
    call WriteChar

    inc eax
    jmp WS_Loop

WS_Done:
    pop ebx
    pop edx
    pop ecx
    pop eax
    ret
WriteScaled ENDP

main PROC
    ; Number 1
    mov edx, OFFSET msg_ex1_1
    call WriteString
    mov edx, OFFSET decimal_one
    mov ecx, len_one
    mov ebx, DECIMAL_OFFSET
    call WriteScaled
    call Crlf

    ; Number 2 (decimal point 2 digits from right)
    mov edx, OFFSET msg_ex1_2
    call WriteString
    mov edx, OFFSET decimal_two
    mov ecx, len_two
    mov ebx, 2
    call WriteScaled
    call Crlf

    ; Number 3 (decimal point 5 digits from right)
    mov edx, OFFSET msg_ex1_3
    call WriteString
    mov edx, OFFSET decimal_three
    mov ecx, len_three
    mov ebx, 5
    call WriteScaled
    call Crlf

    exit
main ENDP

END main
