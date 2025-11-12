;
INCLUDE Irvine32.inc
CalcGrade PROTO, s:DWORD
.data a BYTE ' ',0
.code
main PROC
  call Randomize
  mov ecx,10
L:mov eax,51
  call RandomRange
  add eax,50
  push eax
  INVOKE CalcGrade, eax
  pop edx
  push eax
  mov eax,edx
  call WriteDec
  mWrite a
  pop eax
  mov dl,al
  mov al,dl
  call WriteChar
  mWrite a
  loop L
  call CrLf
  exit
main ENDP
CalcGrade PROC USES eax, s:DWORD
  mov eax,s
  cmp eax,90
  jl B
  mov al,'A'
  ret
B:cmp eax,80
  jl C
  mov al,'B'
  ret
C:cmp eax,70
  jl D
  mov al,'C'
  ret
D:cmp eax,60
  jl F
  mov al,'D'
  ret
F:mov al,'F'
  ret
CalcGrade ENDP
END main
