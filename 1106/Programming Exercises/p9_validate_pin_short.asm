;
INCLUDE Irvine32.inc
Validate_PIN PROTO, p:PTR BYTE
.data min BYTE 5,2,4,1,3
max BYTE 9,5,8,4,6
p1  BYTE 5,2,4,1,3
p2  BYTE 4,3,5,3,4
ok  BYTE "Valid",13,10,0
bad BYTE "Invalid at ",0
.code
main PROC
  INVOKE Validate_PIN, ADDR p1
  test eax,eax
  jz V1
  mWrite bad
  call WriteDec
  call CrLf
  jmp L2
V1:mWrite ok
L2:INVOKE Validate_PIN, ADDR p2
  test eax,eax
  jz V2
  mWrite bad
  call WriteDec
  call CrLf
  jmp Q
V2:mWrite ok
Q: exit
main ENDP
Validate_PIN PROC USES ecx edx esi edi, p:PTR BYTE
  mov esi,p
  mov edi,OFFSET min
  mov edx,1
  mov ecx,5
L: mov al,[esi]
   cmp al,[edi]
   jl R
   cmp al,[OFFSET max + edx-1]
   jg R
   inc esi
   inc edi
   inc edx
   loop L
  xor eax,eax
  ret
R:mov eax,edx
  ret
Validate_PIN ENDP
END main
