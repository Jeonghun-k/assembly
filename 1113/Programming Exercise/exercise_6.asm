
; Exercise 6 - Greatest Common Divisor (GCD)
; Environment: 32-bit MASM, Irvine32

.386
.model flat, stdcall
option casemap:none

include Irvine32.inc

.stack 4096

.data

msg_ex6   BYTE "Exercise 6 - GCD results:",0
msg_p1    BYTE "GCD(48,18)   = ",0
msg_p2    BYTE "GCD(-42,56)  = ",0
msg_p3    BYTE "GCD(270,192) = ",0

.code

;-------------------------------------------------
; GCD
; Computes greatest common divisor of x and y.
; Inputs:
;   EAX = x (signed)
;   EBX = y (signed)
; Returns:
;   EAX = gcd(|x|, |y|)
;-------------------------------------------------
GCD PROC
    push edx
    push ebx
    push ecx

    ; x = abs(x)
    test eax, eax
    jge GCD_X_OK
    neg eax
GCD_X_OK:

    ; y = abs(y)
    test ebx, ebx
    jge GCD_Y_OK
    neg ebx
GCD_Y_OK:

GCD_Loop:
    cmp ebx, 0
    jle GCD_Done        ; if y <= 0, gcd is x

    mov edx, 0
    div ebx             ; EAX / EBX -> quotient in EAX, remainder in EDX
    mov eax, ebx        ; x = y
    mov ebx, edx        ; y = remainder
    jmp GCD_Loop

GCD_Done:
    ; result x in EAX
    pop ecx
    pop ebx
    pop edx
    ret
GCD ENDP

main PROC
    mov edx, OFFSET msg_ex6
    call WriteString
    call Crlf

    ; GCD(48,18)
    mov edx, OFFSET msg_p1
    call WriteString
    mov eax, 48
    mov ebx, 18
    call GCD
    call WriteDec
    call Crlf

    ; GCD(-42,56)
    mov edx, OFFSET msg_p2
    call WriteString
    mov eax, -42
    mov ebx, 56
    call GCD
    call WriteDec
    call Crlf

    ; GCD(270,192)
    mov edx, OFFSET msg_p3
    call WriteString
    mov eax, 270
    mov ebx, 192
    call GCD
    call WriteDec
    call Crlf

    exit
main ENDP

END main
