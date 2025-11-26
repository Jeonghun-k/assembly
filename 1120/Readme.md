

# Chapter 8 – Advanced Procedures 요약 (스택 프레임 & 고급 프로시저)

> 기준 교재: *Assembly Language for x86 Processors, Chapter 8: Advanced Procedures* 내용을 요약/보완한 정리본입니다.  
> 질문에서 적어준 1–22번 메모를 토대로, 빠진 부분과 교재 내용을 채워 넣었습니다.

---

## 0. 메모리 구조 & 기본 용어 정리

### 0-1. 프로세스 메모리 구조

일반적인 (32비트) 프로세스 메모리 구조는 다음과 같이 생각하면 편합니다:

1. **Code 영역 (Text segment)**  
   - 기계어로 번역된 **실행 명령어**가 저장되는 영역  
   - `main`, `AddTwo` 같은 함수/프로시저 코드가 위치

2. **Data / BSS 영역**  
   - 전역 변수, static 변수, 초기화된 데이터 등

3. **Heap 영역**  
   - `malloc`, `new` 등으로 **동적 할당**되는 메모리  
   - 프로그램 실행 중 크기가 늘었다 줄었다 함

4. **Stack 영역**  
   - **함수 호출 시 자동으로 사용되는 메모리**  
   - **스택 프레임(stack frame, activation record)**들이 쌓이는 구조  
   - 각 프레임 안에  
     - 전달된 **파라미터(매개변수)**  
     - **리턴 주소**  
     - **저장된 레지스터 값**  
     - **지역 변수** 등이 포함됨

> 정리: **실행문(코드)**는 Code 영역에, **변수**는 전역/정적은 Data, 동적은 Heap, 지역/파라미터는 Stack에 위치한다고 보면 됩니다.

---

## 1. 파라미터 vs 아규먼트

### 1-1. 메소드(함수) 정의 시 – Parameter (매개변수)

```java
public double abc(int a, double b) { }
```

- `int a, double b` : **Parameter (파라미터, 매개변수)**
- 함수 **선언/정의**에서 괄호 안에 쓰는 이름들

### 1-2. 메소드 호출 시 – Argument (인수/인자)

```java
abc(1, 3.14);
```

- `1, 3.14` : **Argument (아규먼트, 인수, 인자)**  
- 함수를 **호출할 때 괄호 안에 넣는 실제 값**

> 용어 매핑  
> - Parameter = 매개변수  
> - Argument = 인수/인자  
> - 개념은 구분해두되, 현업에서는 섞어서 쓰는 경우도 많음

---

## 2. 스택 프레임 & 레지스터

### 2-1. CALL / RET와 리턴 주소

- `CALL someProc`
  - CPU가 **다음에 실행할 명령의 주소(IP/EIP)**를 스택에 푸시
  - 그 다음 `someProc`의 첫 명령으로 점프
- 프로시저 끝에서 `RET` 실행
  - 스택에서 **리턴 주소를 POP** → IP(EIP)에 넣고 원래 위치로 복귀

> 즉, **리턴할 곳의 주소는 CALL 때 자동으로 스택에 저장**되고, `RET`가 그것을 꺼내 돌아간다.

### 2-2. 스택 관련 레지스터

- **ESP (Stack Pointer)** : 스택의 **현재 꼭대기**를 가리키는 레지스터  
- **EBP (Base Pointer, Frame Pointer)** :  
  - 현재 함수의 **스택 프레임 시작 기준점**  
  - 파라미터/지역 변수에 접근할 때 기준이 됨
- **SS (Stack Segment)** : 스택이 시작하는 세그먼트 (실제 세그먼트 레지스터)

일반적인 함수 프롤로그:

```asm
push ebp        ; 이전 프레임의 EBP 저장
mov  ebp, esp   ; 현재 ESP를 새 기준(EBP)로 설정
; 필요하면 sub esp, N 으로 지역 변수 공간 확보
```

에필로그:

```asm
mov  esp, ebp   ; 지역 변수 영역 버리기
pop  ebp        ; 이전 함수의 EBP 복구
ret             ; 리턴 주소 POP 후 점프
```

---

## 3. Call by Value / Reference / 배열 전달

### 3-1. Call by Value (값에 의한 호출)

정의 (네가 적어둔 것 그대로 OK):

- **함수 호출 시 변수의 값을 복사해서 전달**
- 함수 안에서 값을 바꿔도 **원본 변수는 절대 변하지 않음**

어셈블리 예시 (32비트):

```asm
.data
val1 DWORD 5
val2 DWORD 6

.code
push val2       ; 값 6을 복사해서 스택에
push val1       ; 값 5를 복사해서 스택에
call AddTwo
```

C++로 쓰면:

```cpp
int sum = AddTwo(val1, val2);
```

### 3-2. Call by Reference (참조에 의한 호출)

정의 (모자란 부분 채우기):

- **변수의 “주소(포인터)”를 전달**하는 방식
- 함수 내부에서 그 주소를 따라가 실제 메모리에 접근하므로  
  → **원본 변수를 직접 수정**할 수 있음

어셈블리 예:

```asm
push OFFSET val2
push OFFSET val1
call Swap
```

C/C++:

```cpp
Swap(&val1, &val2);
```

### 3-3. 배열 전달 (Passing Arrays)

- **고급 언어는 배열을 항상 참조로 전달**  
  → 배열의 **시작 주소(OFFSET)**만 스택에 푸시

```asm
.data
array DWORD 50 DUP(?)

.code
push OFFSET array    ; 배열 시작 주소만 전달
call ArrayFill
```

- 이것도 **Call by reference**의 일종 (네 메모 8번 내용과 일치)

---

## 4. 스택 파라미터 접근 (Accessing Stack Parameters)

### 4-1. EBP 기반 접근

C 코드:

```c
int AddTwo(int x, int y) {
    return x + y;
}
```

어셈블리 구현:

```asm
AddTwo PROC
    push ebp
    mov  ebp, esp        ; 스택 프레임 기준점 설정
    mov  eax, [ebp+12]   ; 두 번째 파라미터 y
    add  eax, [ebp+8]    ; 첫 번째 파라미터 x
    pop  ebp
    ret
AddTwo ENDP
```

- `[ebp+4]` : 리턴 주소  
- `[ebp+8]` : 첫 번째 인자  
- `[ebp+12]` : 두 번째 인자 … 이런 식으로 4바이트씩 증가

### 4-2. Explicit Stack Parameters (명시적 스택 파라미터)

```asm
y_param EQU [ebp+12]
x_param EQU [ebp+8]

AddTwo PROC
    push ebp
    mov  ebp, esp
    mov  eax, y_param
    add  eax, x_param
    pop  ebp
    ret
AddTwo ENDP
```

- 이렇게 **이름을 붙여** 쓰면 가독성이 좋아짐  
- `[ebp+8]`처럼 **상수 오프셋을 직접 쓰는 방식**을 교재에서 **explicit stack parameter**라고 부름.

---

## 5. 지역 변수 vs 파라미터 (EBP 기준)

네가 적은 요약을 좀 더 명확하게 정리하면:

- **파라미터(매개변수)**  
  - `EBP` **위쪽(+) 방향**에 위치  
  - 예) `[ebp+8]`, `[ebp+12]` …

- **지역 변수(local variables)**  
  - `EBP` **아래쪽(-) 방향**에 위치  
  - 예) `[ebp-4]`, `[ebp-8]` …

> 따라서, **EBP를 기준으로 +면 파라미터, -면 지역 변수**라고 외우면 됨.

---

## 6. LEA와 스택 정렬 (sub esp,30 vs sub esp,32)

### 6-1. 예시

```asm
makeArray PROC
    push ebp
    mov  ebp, esp
    sub  esp, 32       ; myString은 EBP-30에 위치
    lea  esi, [ebp-30] ; myString의 주소
    mov  ecx, 30
L1:
    mov BYTE PTR [esi], '*'
    inc esi
    loop L1
    add esp, 32
    pop ebp
    ret
makeArray ENDP
```

- 실제 문자열 크기: **30바이트**
- 그런데 `sub esp, 32`로 **32바이트 확보**

> 배열은 30바이트지만, **스택 포인터를 32만큼 줄여서 “더블워드(4바이트) 경계”에 정렬하기 위해서** 이렇게 작성한 것이다.

### 6-2. 네가 적어둔 의문점 정리

> “sub esp,32는 2바이트를 버리는 잘못된 값이다. sub esp,30이 맞는 말이다”  

- **이건 “메모리를 딱 필요한 만큼만 쓰자”라는 관점**에서는 맞는 말  
- 하지만 **성능/정렬 관점**에서는 **일부러 2바이트 더 잡는 것**이 맞는 경우가 많음
- 특히 x86 / x64에서는 **스택을 4바이트 또는 16바이트 정렬**하면
  - 메모리 접근이 더 빠르거나
  - 특정 ABI 규약을 만족해야 함

정리하면:

- **시험/수업에서 교수님이 “sub esp,30이 맞다”고 강조**했다면  
  → “필요한 만큼만 정확히 빼는 코드”를 의도했을 수 있음  
- **실제 코드에서는 정렬 때문에 32로 잡기도 한다**  
  → 둘 다 “논리적으로 가능”, 다만 **기준(정렬 vs 딱 맞춤)에 따라 다름**

---

## 7. ENTER / LEAVE / LOCAL

### 7-1. ENTER

`ENTER numbytes, nestinglevel`

- 함수 스택 프레임을 **자동으로 만드는 명령**
- 내부적으로 다음을 한 번에 수행:
  1. `push ebp`
  2. `mov ebp, esp`
  3. `sub esp, numbytes` (지역 변수 공간 확보)

보통:

```asm
ENTER 32, 0   ; 지역 변수 32바이트 확보, 중첩 수준 0
```

### 7-2. LEAVE

- `LEAVE`는 **ENTER의 반대 역할**
  - `mov esp, ebp`
  - `pop ebp`
- 그 다음에 `RET`가 따라오는 패턴이 일반적

### 7-3. LOCAL directive

```asm
MyProc PROC
    LOCAL var1:DWORD, var2:BYTE
    ; ...
MyProc ENDP
```

- `LOCAL`은 **프로시저 내부 지역변수들을 이름/타입과 함께 선언**하는 지시어
- MASM이 자동으로:
  - `sub esp, ...`로 공간 확보
  - 각 변수에 `[ebp-4]`, `[ebp-8]` 같은 오프셋을 배치

> 네가 메모에 적은 설명과 교재 내용이 잘 맞음.

---

## 8. 재귀 호출(Recursion)과 스택

### 8-1. 정의

- **자기 자신을 다시 호출하는 함수/프로시저**  
- 직접 혹은 간접(다른 함수 통해) 재귀 가능

### 8-2. 중요한 특징

1. **호출마다 새로운 스택 프레임이 쌓인다.** (네 메모 17번)  
2. **반드시 종료 조건(terminating condition)**이 있어야 한다.  
   - 없으면 무한 재귀 → 스택 오버플로우
3. 재귀에서 **임시 데이터를 스택 파라미터나 지역 변수에 저장**해두고  
   - 재귀가 ‘unwind’ 될 때(RET들이 돌아올 때) 이 값을 사용하기도 함

---

## 9. INVOKE / ADDR / PROC / PROTO / 파라미터 종류

### 9-1. INVOKE

- 32비트 모드에서만 사용 가능한 **고급 호출 매크로**
- 하는 일:
  1. **파라미터를 올바른 순서로 스택에 push**
  2. `call` 명령을 실행
  3. `.MODEL`에서 설정한 호출 규약(`stdcall`, `cdecl` 등)에 따라  
     **스택 정리까지 자동으로 처리**

네 메모 18번 내용과 정확히 일치.

예:

```asm
INVOKE AddTwo, 5, 6
INVOKE Swap, ADDR Array, ADDR [Array+4]
```

### 9-2. ADDR

- `INVOKE`와 같이 쓰는 **주소 전달용 연산자**
- 형식:

```asm
INVOKE FillArray, ADDR myArray
```

- 주의점 (네 메모 19 보완):
  - **피연산자는 반드시 “어셈블리 시점 상수(compile-time constant)”여야 함**
  - 그래서 `ADDR [ebp+12]`처럼 **런타임 계산이 필요한 표현**은 사용할 수 없음
    - `INVOKE mySub, ADDR [ebp+12]` → 오류
  - 즉, `ADDR`는 **전역/정적/지역 이름(symbol)**에만 사용

### 9-3. PROC / PROTO

- `PROC` : 프로시저 정의용 지시어
- 확장 형태로 **파라미터 이름과 타입**을 함께 적을 수 있음:

```asm
AddTwo PROC,
    x:DWORD,
    y:DWORD
    ; ...
AddTwo ENDP
```

- `PROTO` : 다른 모듈에 있는 프로시저를 **미리 선언** (함수 프로토타입 역할)  
  - C의 함수 선언과 비슷

### 9-4. 파라미터 종류 (입력 / 입력+출력 / 출력)

프로시저 파라미터를 **데이터 흐름 방향**으로 분류:

1. **Input parameter (입력 전용)**  
   - 함수가 **읽기만** 하는 값  
   - 예: `AddTwo`의 `x`, `y`

2. **Output parameter (출력 전용)**  
   - 함수가 **값을 채워서 돌려주는 용도**  
   - C 기준 `void ReadInt(int* outValue)`에서 `outValue` 같은 것

3. **Input-Output parameter (입력 + 출력)**  
   - 함수가 **초기 값을 읽고**, 수정 후 **다시 돌려주는** 파라미터  
   - 예: `Swap`에서 넘기는 포인터들

네 메모 21번과 일치.

---

## 10. 어셈블리에서의 “아규먼트”

네 메모 6번:

> “어셈블리에는 아규먼트가 없으니깐 이걸 레지스터에 넣어두고 사용해야 한다”

조금만 보완하면:

- **어셈블리에도 “파라미터/아규먼트” 개념은 존재**하지만
  - 고급 언어처럼 `(a, b, c)` 형식의 문법은 없음
- 대신,
  - **스택에 push**해서 전달하거나
  - **레지스터에 직접 넣어서** 전달
- MASM의 `INVOKE`, `PROC` 같은 고급 지시어가  
  → 이런 스택 조작을 **편하게 자동으로 해 주는 “문법 설탕”** 역할을 한다고 보면 됨.

---

## 11. EXTERN / EXTERNDEF (멀티 모듈)

### 11-1. EXTERN

- 다른 모듈에 정의된 함수를 호출할 때 사용  
- 이름과 스택 프레임 크기(인자 크기)를 같이 명시:

```asm
EXTERN AddTwo@8 : PROC
```

- 뒤의 `@8`은 **스택 파라미터가 총 8바이트**라는 뜻

### 11-2. PUBLIC / PRIVATE

- `PUBLIC name` : 이 모듈에서 정의한 심볼을 **다른 모듈에서 사용할 수 있게 export**
- `OPTION PROC:PRIVATE` :  
  - 기본적으로 모든 프로시저를 **private**으로 만들고,  
  - 필요한 것만 `PUBLIC`으로 내보내는 패턴

### 11-3. EXTERNDEF

- MASM의 유용한 지시어로, **PUBLIC + EXTERN를 합쳐놓은 것**
- 의미 요약:

> EXTERNDEF는 “어디선가 이 이름이 정의돼 있을 거야”라고 알려주면서,  
> 동시에 필요하면 이 모듈에서 정의된 심볼을 외부로 공개할 수도 있게 도와주는 도구.

네 메모 22번:

> “지금 나한테는 파일이 없지만 다른 곳에 파일이 있다는 걸 명시… 링킹할 때 사용”

- 이 감각은 맞고, 거기에 **export/import를 동시에 관리하는 도구**라는 점이 추가된다고 보면 됨.

---

## 12. 정리 체크리스트

- [x] 코드/데이터/스택/힙 역할 구분  
- [x] Parameter vs Argument 구분  
- [x] Call by value / reference / 배열 전달 방식  
- [x] EBP/ESP 기반 스택 프레임 구조 이해  
- [x] 지역변수 vs 파라미터: EBP 기준 + / -  
- [x] LEA + 스택 정렬(sub esp,32)의 의미 이해  
- [x] ENTER / LEAVE / LOCAL 동작 원리  
- [x] 재귀 호출 시 스택 프레임 증가/감소 흐름  
- [x] INVOKE / ADDR / PROC / PROTO 사용법  
- [x] 파라미터 분류 (입력 / 출력 / 입력+출력)  
- [x] EXTERN / EXTERNDEF / PUBLIC / PRIVATE 역할

이 파일만 계속 보면서 복습해도 ch08 핵심은 거의 다 커버될 거야.
