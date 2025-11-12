;
INCLUDE Irvine32.inc
.data ok BYTE "Can register",13,10,0
no BYTE "Cannot register",13,10,0
g DWORD 220    ; GPA*100
c DWORD 14     ; credits
.code
main PROC
  mov eax,c
  cmp eax,1
  jb bad
  cmp eax,30
  ja bad
  mov eax,g
  cmp eax,200
  jb low
  mov eax,c
  cmp eax,16
  ja cannot
  jmp can
low:
  mov eax,c
  cmp eax,12
  ja cannot
can: mWrite ok
  jmp done
cannot: mWrite no
  jmp done
bad: mWrite no
done: exit
main ENDP
END main
