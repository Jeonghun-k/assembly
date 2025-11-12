;
INCLUDE Irvine32.inc
EvenParity PROTO, p:PTR BYTE, n:DWORD
.data A BYTE 1,2,3,4,5,6,7,8,9,10
     B BYTE 1,1,1,1,1,1,1,1,1,0
.code
main PROC
  INVOKE EvenParity, ADDR A, LENGTHOF A
  call WriteDec
  call CrLf
  INVOKE EvenParity, ADDR B, LENGTHOF B
  call WriteDec
  call CrLf
  exit
main ENDP
EvenParity PROC USES ecx esi, p:PTR BYTE, n:DWORD
  mov esi,p
  mov ecx,n
  xor al,al
L: xor al,[esi]
   inc esi
   loop L
  setp dl
  movzx eax,dl
  ret
EvenParity ENDP
END main
