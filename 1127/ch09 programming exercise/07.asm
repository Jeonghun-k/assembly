; 07.asm - Sieve of Eratosthenes
.386
.model flat, stdcall
.stack 4096
include Irvine32.inc

MAXN EQU 65000

.data?
sieve BYTE MAXN+1 DUP(?)

.data
msg1 BYTE "Primes between 2 and 65000:",0Dh,0Ah,0

.code
main PROC
    mov edx, OFFSET msg1
    call WriteString

    ; init array to 0
    mov eax, 0
    mov edi, OFFSET sieve
    mov ecx, MAXN+1
    cld
    mov al, 0
    rep stosb

    mov ebx, 2            ; p = 2

OUTER:
    mov eax, ebx
    imul eax, ebx         ; p*p
    cmp eax, MAXN
    jg  DONE_SIEVE

    mov al, [sieve+ebx]
    cmp al, 0
    jne NEXT_P

    mov edx, ebx
    add edx, ebx          ; 2p

MARK_LOOP:
    cmp edx, MAXN
    jg  NEXT_P
    mov BYTE PTR [sieve+edx], 1
    add edx, ebx
    jmp MARK_LOOP

NEXT_P:
    inc ebx
    jmp OUTER

DONE_SIEVE:
    mov ecx, 2
PRINT_LOOP:
    cmp ecx, MAXN
    jg  FINISH

    mov al, [sieve+ecx]
    cmp al, 0
    jne NOT_PRIME

    mov eax, ecx
    call WriteDec
    mov dl, ' '
    call WriteChar

NOT_PRIME:
    inc ecx
    jmp PRINT_LOOP

FINISH:
    call Crlf
    exit
main ENDP

END main
