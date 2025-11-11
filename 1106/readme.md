# 💾 어셈블리 제어문(분기문) 정리 – CH6 Conditional Processing 요약

> 📘 수업 노트 + PDF 통합 요약본  
> 주제: 논리 연산, 비교, 조건 분기, 루프, 고급 제어 지시어

---

## 1️⃣ 제어문이란?
- 프로그램이 **순차적으로 실행**되는 흐름을 제어하는 명령어들.  
- 어셈블리어에서는 고수준 언어의 `if`, `while`, `for` 대신  
  **CMP + Jcc**, **TEST**, **LOOP**, **.IF** 지시어 등을 이용해 분기 구현.

---

## 2️⃣ 불리언(Boolean) 연산 명령어
어셈블리에서 논리 연산은 **비트 단위**로 수행됨.

| 명령어 | 기능 | 플래그 영향 | 비고 |
|:--|:--|:--|:--|
| **AND** | 둘 다 1이면 1, 나머지는 0 | ZF, SF, PF ← 결과 기반 / CF, OF ← 0 | **비트 마스크** 자주 사용 |
| **OR** | 둘 중 하나라도 1이면 1 | ZF, SF, PF ← 결과 기반 / CF, OF ← 0 | 비트를 **1로 세팅**할 때 |
| **XOR** | 두 값이 다를 때 1 | ZF, SF, PF ← 결과 기반 / CF, OF ← 0 | 자신과 XOR → 0 (초기화용) |
| **NOT** | 모든 비트를 반전 | 플래그 변하지 않음 | 1의 보수 계산 |
| **TEST** | AND와 동일하지만 **결과 저장 X** | ZF, SF, PF ← 결과 기반 / CF, OF ← 0 | **플래그만 설정** |

🧠 **Bit Mask 활용 예시**
```asm
mov al, 0FFh      ; AL = 1111 1111
and al, 0Fh       ; AL = 0000 1111 → 하위 4비트만 유지
```

🔤 **소문자 → 대문자 변환 예시**
```asm
and al, 11011111b ; bit5(32) 비트를 0으로 만들어 대문자로 변환
```

---

## 3️⃣ 플래그 레지스터 (EFLAGS 주요 비트)
| 플래그 | 의미 | 설명 |
|:--|:--|:--|
| **ZF (Zero)** | 연산 결과가 0이면 1 | CMP 결과 같으면 1 |
| **CF (Carry)** | 자리올림/자리내림 발생 | 무부호 연산에서 사용 |
| **SF (Sign)** | 결과의 부호 (MSB) | 1=음수, 0=양수 |
| **OF (Overflow)** | 부호 있는 수에서 오버플로 발생 | ±127 범위 초과 등 |
| **PF (Parity)** | 1비트 개수 짝수면 1 | 짝수 패리티 |

⚙️ `AND`, `OR`, `XOR`, `TEST`는 **OF, CF = 0**,  
ZF/SF/PF는 결과값에 따라 변경됨.

---

## 4️⃣ CMP (Compare) 명령어
- 형식: `CMP destination, source`
- 실제로는 **destination - source** 연산을 수행하되, **결과 저장하지 않음**.
- 결과에 따라 **플래그만 변경**.

### 🔸 무부호 비교 (Unsigned)
| 관계 | ZF | CF |
|:--|:--:|:--:|
| d < s | 0 | 1 |
| d > s | 0 | 0 |
| d = s | 1 | 0 |

### 🔹 부호 비교 (Signed)
| 관계 | 조건식 |
|:--|:--|
| d < s | SF ≠ OF |
| d > s | SF = OF, ZF=0 |
| d = s | ZF=1 |

🧩 예시
```asm
mov ax, 5
cmp ax, 10     ; 5-10 → ZF=0, CF=1
jz  equal      ; 같을 때 점프(ZF=1)
jne notequal   ; 다를 때 점프(ZF=0)
```

---

## 5️⃣ 조건 분기 (Jcc 명령어)
조건에 따라 특정 라벨로 점프하는 명령어.

| 명령어 | 의미 | 조건 |
|:--|:--|:--|
| **JC** | Jump if Carry | CF = 1 |
| **JNC** | Jump if No Carry | CF = 0 |
| **JZ / JE** | Jump if Zero / Equal | ZF = 1 |
| **JNZ / JNE** | Jump if Not Zero / Not Equal | ZF = 0 |
| **JG / JNLE** | Jump if Greater (Signed) | SF = OF, ZF=0 |
| **JL / JNGE** | Jump if Less (Signed) | SF ≠ OF |
| **JA / JNBE** | Jump if Above (Unsigned) | CF=0, ZF=0 |
| **JB / JNAE** | Jump if Below (Unsigned) | CF=1 |
| **JGE / JNL** | Jump if Greater or Equal | SF=OF |
| **JLE / JNG** | Jump if Less or Equal | SF≠OF or ZF=1 |

🧠 핵심 기억:  
- **Unsigned → CF, ZF 기준**  
- **Signed → SF, OF, ZF 기준**  

---

## 6️⃣ 특별한 점프 명령어
| 명령어 | 설명 |
|:--|:--|
| **JMP** | 무조건 점프 |
| **JCXZ / JECXZ** | CX(ECX)=0이면 점프 (Loop 종료용) |

📌 **CX는 루프 카운터로 자주 사용**  
→ 루프 끝날 때 0이 되면 점프.

---

## 7️⃣ 예제 요약 (p.27 기준)
1️⃣ **cmp edx, edx → ZF=1, CF=0** → `je` 실행됨  
2️⃣ **bx = 1234h, sub bx, bx → ZF=1** → `je` 실행  
3️⃣ **cx=0FFFFh, inc cx → 0000h** → `jcxz` 점프  
4️⃣ **xor ecx, ecx → 0** → `jecxz` 점프

---

## 8️⃣ Loop 관련 명령어
| 명령어 | 의미 | 조건 |
|:--|:--|:--|
| **LOOP** | ECX--, ECX≠0이면 반복 | 무조건 감소 후 검사 |
| **LOOPZ / LOOPE** | ECX--, ZF=1이고 ECX≠0이면 반복 | Zero 유지 시 반복 |
| **LOOPNZ / LOOPNE** | ECX--, ZF=0이고 ECX≠0이면 반복 | Zero 아닐 때 반복 |

💡 `LOOPZ`와 `LOOPE`는 같은 의미, `LOOPNZ`와 `LOOPNE`도 동일.  
즉, **ZF와 루프 카운터 두 조건 모두 만족**해야 반복.

---

## 9️⃣ 조건부 제어 지시어 (.IF / .ELSE)
MASM의 고급 제어문 (32bit에서만 지원)

```asm
mov eax, 6
.IF eax > val1
    mov result, 1
.ENDIF
```
이는 내부적으로 다음과 같이 변환됨 👇
```asm
cmp eax, val1
jbe @C0001
mov result, 1
@C0001:
```

| 지시어 | 의미 |
|:--|:--|
| `.IF` | 조건 시작 |
| `.ELSEIF` | 추가 조건 |
| `.ELSE` | 그 외 조건 |
| `.ENDIF` | 종료 |

> ⚠️ 64비트 MASM에서는 지원되지 않음.

---

## 🔟 실습 예시 요약

### 🔹 배열에서 0이 아닌 값 찾기
```asm
mov ebx, OFFSET intArray
mov ecx, LENGTHOF intArray

L1: cmp WORD PTR [ebx], 0
jnz found
add ebx, 2
loop L1
jmp notFound
```

### 🔹 XOR 암호화 (Encrypt.asm)
```asm
L1:
xor buffer[esi], KEY ; 암호화 or 복호화
inc esi
loop L1
```

> XOR은 같은 키로 **두 번 XOR** 하면 원본 복구 가능.

---

