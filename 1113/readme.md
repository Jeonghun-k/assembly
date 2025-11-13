# Integer Arithmetic Summary

## 1. Shift & Rotate Instructions
### Logical Shift (SHL, SHR)
- SHL: Left shift, fill with 0 → `X * 2^n`
- SHR: Right shift, fill with 0 → `X / 2^n`
- Carry Flag(CF) receives shifted-out bit.

### Arithmetic Shift (SAL, SAR)
- SAL = SHL
- SAR: Right shift, fill with sign bit  
  예: `1111 0000b (-16)` → SAR 1 → `1111 1000b (-8)`

### Rotate (ROL, ROR)
- ROL: MSB → CF, LSB로 들어감
- ROR: LSB → CF, MSB로 들어감  
- 비트가 손실되지 않음.

### Rotate with Carry (RCL, RCR)
- CF도 함께 회전에 참여.

### Double Shift (SHLD, SHRD)
- SHLD: dest ← left shift, 빈 자리를 source의 MSB로 채움  
- SHRD: dest ← right shift, 빈 자리를 source의 LSB로 채움  
- source는 변하지 않음.

---

## 2. Extracting File Date Fields
파일 날짜는 다음과 같이 비트로 저장됨:
- Year: bits 9–15 (1980 기준)
- Month: bits 5–8
- Day: bits 0–4

---

## 3. MUL (Unsigned Multiply)
- 피연산자 크기 동일 → 결과는 2배 크기  
- 8×8 → AX  
- 16×16 → DX:AX  
- 32×32 → EDX:EAX  
- CF/OF는 상위 절반에 유효한 값이 있을 때 설정.

예:
```
mov al, 05h
mov bl, 10h
mul bl        ; AX = 0050h
```

---

## 4. IMUL (Signed Multiply)
- 부호 있는 정수 곱셈
- 1-operand: 결과 AX, DX:AX, EDX:EAX  
- 2/3-operand: 결과는 목적지 크기로 잘림 → 손실 시 CF/OF = 1

---

## 5. Time Instructions
- GetMseconds 사용하여 시간 측정
- startTime / procTime1 / procTime2 변수로 계산

---

## 6. DIV (Unsigned Division)
### 8-bit divisor
- Dividend = AX  
- Quotient = AL  
- Remainder = AH

### 16/32-bit divisor
- Dividend = DX:AX or EDX:EAX  
- Quotient = AX or EAX  
- Remainder = DX or EDX

예:
```
mov ax, 0083h
mov bl, 2
div bl   ; AL=41h, AH=01h
```

---

## 7. Signed Integer Division (IDIV)
부호 확장 필요:
- CBW: AL → AX
- CWD: AX → DX:AX
- CDQ: EAX → EDX:EAX

---

## 8. Divide Overflow
- 몫이 AL/AX/EAX 저장 범위를 넘기면 예외(Exception) 발생

---

## 9. ADC (Add with Carry)
```
adc dl, 0    ; dl = dl + 0 + CF
```

---

## 10. SBB (Subtract with Borrow)
```
sbb dl, 0    ; dl = dl - 0 - CF
```

---

## 11. ASCII Instructions (AAA, AAS, AAM, AAD)
### AAA (ASCII Adjust After Addition)
- ADD 결과를 ASCII(unpacked decimal)로 조정

예:
```
mov al,'8'
add al,'2'   ; '8' + '2' = 0x6A
aaa          ; → '1', '0' 형태로 보정
```

### AAS
- ASCII subtraction 조정

### AAM
- MUL 결과를 unpacked decimal로 변환

### AAD
- unpacked decimal → binary 변환 후 DIV 준비

---

## 12. Packed Decimal (DAA, DAS)
### DAA
ADD/ADC 후 AL을 packed decimal로 보정  
### DAS
SUB/SBB 후 AL을 packed decimal로 보정

---

## 부록: PDF 기반 추가 개념
- RCL/RCR의 CF 참여
- SHLD/SHRD 플래그 영향: SF, ZF, PF, CF 업데이트
- OF는 shift count = 1일 때만 정의됨
- DIV/IDIV 후 플래그는 모두 **undefined**
- Divide-by-zero는 반드시 검사 필요
- Signed multiply(IDIV) 전 반드시 부호 확장해야 함

---

# END

