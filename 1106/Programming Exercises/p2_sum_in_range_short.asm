;
INCLUDE Irvine32.inc
SumInRange PROTO, p:PTR SDWORD, n:DWORD, j:SDWORD, k:SDWORD
.data A SDWORD 10 DUP(?)
.code
main PROC
  call Randomize
  ; seed A = 0..9
  mov ecx,10
  mov esi,OFFSET A
  mov eax,0
S: mov [esi],eax
   add esi,4
   inc eax
   loop S
  INVOKE SumInRange, ADDR A, 10, 3, 7
  call WriteInt
  call CrLf
  exit
main ENDP
SumInRange PROC USES ebx ecx edx esi, p:PTR SDWORD, n:DWORD, j:SDWORD, k:SDWORD
  mov esi,p
  mov ecx,n
  xor eax,eax
L:mov edx,[esi]
  mov ebx,j
  cmp edx,ebx
  jl N
  mov ebx,k
  cmp edx,ebx
  jg N
  add eax,edx
N:add esi,4
  loop L
  ret
SumInRange ENDP
END main
