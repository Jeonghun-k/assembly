;
INCLUDE Irvine32.inc
WHITE=15, BLUE=1, GREEN=2
.data msg BYTE "line",0
.code
main PROC
  call Randomize
  mov ecx,20
L:mov eax,10
  call RandomRange
  cmp eax,3
  jl W
  cmp eax,4
  je B
  mov eax,GREEN
  jmp S
W:mov eax,WHITE
  jmp S
B:mov eax,BLUE
S:call SetTextColor
  mWrite msg
  call CrLf
  loop L
  mov eax,7
  call SetTextColor
  exit
main ENDP
END main
