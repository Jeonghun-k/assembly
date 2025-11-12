;
INCLUDE Irvine32.inc
FillArray PROTO, p:PTR DWORD, n:DWORD, j:SDWORD, k:SDWORD
.data A DWORD 10 DUP(?), B DWORD 10 DUP(?), s BYTE ' ',0
.code
main PROC
  call Randomize
  INVOKE FillArray, ADDR A, 10, 10, 20
  INVOKE FillArray, ADDR B, 10, -5, 5
  mov esi,OFFSET A  ; print A
  mov ecx,10
L1: mov eax,[esi]  ; A[i]
    call WriteDec
    mWrite s
    add esi,4
    loop L1
  call CrLf
  mov esi,OFFSET B ; print B
  mov ecx,10
L2: mov eax,[esi]
    call WriteInt
    mWrite s
    add esi,4
    loop L2
  exit
main ENDP
FillArray PROC USES eax ebx ecx edx esi, p:PTR DWORD, n:DWORD, j:SDWORD, k:SDWORD
  mov esi,p
  mov ecx,n
  mov eax,k
  sub eax,j
  inc eax        ; range
  mov ebx,eax
F:mov eax,ebx
  call RandomRange
  add eax,j
  mov [esi],eax
  add esi,4
  loop F
  ret
FillArray ENDP
END main
