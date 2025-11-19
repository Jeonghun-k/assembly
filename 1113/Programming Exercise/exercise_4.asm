
; Exercise 4 - Encryption Using Rotate Operations
; Environment: 32-bit MASM, Irvine32

.386
.model flat, stdcall
option casemap:none

include Irvine32.inc

.stack 4096

.data

KEY_LEN EQU 10

key BYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6

msg_plain1  BYTE "HELLO WORLD!",0
len_plain1  =   ($ - msg_plain1 - 1)    ; exclude null

msg_plain2  BYTE "ASSEMBLY ROTATION TEST",0
len_plain2  =   ($ - msg_plain2 - 1)

msg_ex4_1   BYTE "Exercise 4 - Encrypted message 1:",0
msg_ex4_2   BYTE "Exercise 4 - Encrypted message 2:",0

.code

;-------------------------------------------------
; EncryptRotate
; Simple encryption using rotate with key pattern.
; Inputs:
;   ESI = pointer to plaintext (in-place modify)
;   ECX = message length (bytes, excluding null)
;   EDI = pointer to key array
;   EBX = key length
; Behavior:
;   For each byte i:
;     k = key[i % keyLen]
;     if k < 0 : ROL by -k
;     if k > 0 : ROR by k
;     if k = 0 : unchanged
;-------------------------------------------------
EncryptRotate PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    xor edx, edx        ; i = 0

ER_Loop:
    cmp edx, ecx
    jge ER_Done

    mov al, [esi+edx]   ; current byte

    ; compute key index = i mod KEY_LEN
    mov eax, edx
    cdq
    mov ebx, KEY_LEN
    div ebx             ; quotient in EAX, remainder in EDX
    mov bl, key[edx]    ; bl = key[i % KEY_LEN]

    cmp bl, 0
    je  ER_Store

    jl  ER_Left
    ; positive: rotate right
    mov cl, bl
    ror al, cl
    jmp ER_Store

ER_Left:
    neg bl
    mov cl, bl
    rol al, cl

ER_Store:
    mov [esi+edx], al
    inc edx
    jmp ER_Loop

ER_Done:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
EncryptRotate ENDP

main PROC
    ; Message 1
    mov edx, OFFSET msg_ex4_1
    call WriteString
    call Crlf

    mov esi, OFFSET msg_plain1
    mov ecx, len_plain1
    mov edi, OFFSET key
    mov ebx, KEY_LEN
    call EncryptRotate

    mov edx, OFFSET msg_plain1
    call WriteString
    call Crlf

    ; Message 2
    mov edx, OFFSET msg_ex4_2
    call WriteString
    call Crlf

    mov esi, OFFSET msg_plain2
    mov ecx, len_plain2
    mov edi, OFFSET key
    mov ebx, KEY_LEN
    call EncryptRotate

    mov edx, OFFSET msg_plain2
    call WriteString
    call Crlf

    exit
main ENDP

END main
