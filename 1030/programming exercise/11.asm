INCLUDE Irvine32.inc
.data
N EQU 50
arr BYTE N DUP(0)
.code
FindMultiples PROC USES eax ebx ecx edx esi edi
    push ebp
    mov  ebp, esp
    mov  esi, [ebp+8]    ; array base
    mov  ecx, [ebp+12]   ; N
    mov  ebx, [ebp+16]   ; K
    xor  edi, edi        ; i = 0
L_loop:
    cmp  edi, ecx
    jge  done
    mov  eax, edi
    xor  edx, edx
    div  ebx             ; EDX = i % K
    cmp  edx, 0
    jne  L_next
    mov  BYTE PTR [esi+edi], 1
L_next:
    inc  edi
    jmp  L_loop
done:
    pop  ebp
    ret 12
FindMultiples ENDP

main PROC
    ; clear array
    mov ecx, N
    mov edi, OFFSET arr
    mov al, 0
clz:
    mov [edi], al
    inc edi
    loop clz

    ; K=2
    push 2
    push N
    push OFFSET arr
    call FindMultiples
    ; K=3
    push 3
    push N
    push OFFSET arr
    call FindMultiples

    ; show first 50 bytes
    mov edx, OFFSET arr
    mov ecx, N
L_show:
    movzx eax, BYTE PTR [edx]
    call WriteDec
    mov al, ' '
    call WriteChar
    inc edx
    loop L_show
    call Crlf
    exit
main ENDP
END main
