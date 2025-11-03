INCLUDE Irvine32.inc
.data
N DWORD 47
arr DWORD 47 DUP(?)
.code
Fibonacci PROC
    push ebp
    mov  ebp, esp
    push esi
    push ebx
    push ecx

    mov esi, [ebp+8]    ; ptr
    mov ecx, [ebp+12]   ; count
    cmp ecx, 0
    jle done
    mov eax,1
    mov [esi], eax
    add esi,4
    dec ecx
    jz done

    mov ebx,1
    mov [esi], ebx
    add esi,4
    dec ecx
F_loop:
    jz done
    add eax, ebx
    xchg eax, ebx
    mov [esi], ebx
    add esi,4
    dec ecx
    jmp F_loop
done:
    pop ecx
    pop ebx
    pop esi
    mov esp, ebp
    pop ebp
    ret 8
Fibonacci ENDP

main PROC
    lea eax, arr
    push N
    push eax
    call Fibonacci
    mov eax, arr[ (47-1)*4 ]
    call WriteDec
    call Crlf
    exit
main ENDP
END main
