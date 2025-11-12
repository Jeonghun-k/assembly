;
INCLUDE Irvine32.inc
XorKey PROTO, p:PTR BYTE, n:DWORD, k:PTR BYTE, kn:DWORD
.data m BYTE "ABXmv#7",0
kn DWORD ($-m)-1
t BYTE "Attack at dawn!",0
n DWORD ($-t)-1
b BYTE 64 DUP(?), sp BYTE ' ',0
.code
main PROC
  ; copy t->b
  push esi
  push edi
  mov esi,OFFSET t
  mov edi,OFFSET b
  mov ecx,n
  rep movsb
  pop edi
  pop esi
  ; enc
  INVOKE XorKey, ADDR b, n, ADDR m, kn
  ; hex show
  mov esi,OFFSET b
  mov ecx,n
H:movzx eax,BYTE PTR [esi]
  call WriteHexB
  mWrite sp
  inc esi
  loop H
  call CrLf
  ; dec
  INVOKE XorKey, ADDR b, n, ADDR m, kn
  mov edx,OFFSET b
  call WriteString
  call CrLf
  exit
main ENDP
XorKey PROC USES eax ebx ecx edx esi, p:PTR BYTE, n:DWORD, k:PTR BYTE, kn:DWORD
  mov esi,p
  mov ecx,n
  xor ebx,ebx
L: mov al,[esi]
   xor al,[k+ebx]
   mov [esi],al
   inc ebx
   cmp ebx,kn
   jb  C
   xor ebx,ebx
C: inc esi
   loop L
  ret
XorKey ENDP
END main
