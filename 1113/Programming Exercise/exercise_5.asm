
; Exercise 5 - Prime Numbers (Sieve of Eratosthenes)
; Environment: 32-bit MASM, Irvine32

.386
.model flat, stdcall
option casemap:none

include Irvine32.inc

.stack 4096

.data

MAX_NUM EQU 1000

primeFlags BYTE (MAX_NUM+1) DUP(0) ; 0 = prime assumption, 1 = composite

msg_ex5 BYTE "Exercise 5 - Primes from 2 to 1000:",0

.code

;-------------------------------------------------
; GenPrimes
; Generates prime flags from 2..MAX_NUM
; primeFlags[i] = 0 => prime
; primeFlags[i] = 1 => composite
;-------------------------------------------------
GenPrimes PROC
    push eax
    push ebx
    push ecx
    push edx

    ; Mark 0 and 1 as non-prime
    mov BYTE PTR [primeFlags+0], 1
    mov BYTE PTR [primeFlags+1], 1

    mov eax, 2          ; i = 2

GP_Outer:
    cmp eax, 32         ; up to floor(sqrt(1000)) ≈ 31
    jge GP_DoneOuter

    mov bl, [primeFlags+eax]
    cmp bl, 0
    jne GP_NextI        ; if already composite, skip

    ; j = i*i
    mov ebx, eax
    imul ebx, eax       ; ebx = i*i

GP_MarkLoop:
    cmp ebx, MAX_NUM+1
    jge GP_EndMark

    mov BYTE PTR [primeFlags+ebx], 1
    add ebx, eax
    jmp GP_MarkLoop

GP_EndMark:
GP_NextI:
    inc eax
    jmp GP_Outer

GP_DoneOuter:
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
GenPrimes ENDP

main PROC
    mov edx, OFFSET msg_ex5
    call WriteString
    call Crlf

    call GenPrimes

    mov eax, 2
PrintLoop:
    cmp eax, MAX_NUM
    jg  DonePrint

    mov bl, [primeFlags+eax]
    cmp bl, 0
    jne SkipPrint

    push eax
    call WriteDec
    mov al, ' '
    call WriteChar
    pop eax

SkipPrint:
    inc eax
    jmp PrintLoop

DonePrint:
    call Crlf
    exit
main ENDP

END main
