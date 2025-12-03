# String and Arrays (요약 정리)

1. string primitive instructions  
    - 32비트 모드에서 **ESI(소스) / EDI(목적지)** 가 메모리 주소를 가리킨다.  
    - 누산기: **AL, AX, EAX** (문자열/배열 연산에 사용).  
    - 16비트: SI/DI, 32비트: ESI/EDI.  
    - 문자열 명령어는 예외적으로 **mem → mem** 전송 허용(`MOVSx` 등).  
    - 실행할 때마다 DF에 따라 ESI/EDI 자동 증가/감소 (`CLD`/`STD`).  

2. Repeat Prefix  
    - 공통: 앞에 붙여서 **같은 문자열 명령어를 ECX 횟수만큼 반복**.  
    - `REP`   : ECX > 0 동안 계속.  
    - `REPE/REPZ` : ZF=1 && ECX>0 일 때 반복 (같을 때 계속).  
    - `REPNE/REPNZ`: ZF=0 && ECX>0 일 때 반복 (다를 때 계속).  
    - `OFFSET name` 은 그 변수의 **시작 주소 값**. 예) `mov esi, OFFSET string1`.  

3. CMPSB, CMPSW, CMPSD  
    - `[ESI]` 와 `[EDI]` 를 비교하는 문자열 비교 명령어.  
    - `CMPSB/CMPSW/CMPSD` : byte/word/dword 단위.  
    - 보통 `repe cmpsd` 처럼 써서 두 배열 전체가 같은지 검사.  

4. SCASB, SCASW, SCASD  
    - `AL/AX/EAX` 와 `[EDI]` 를 비교하면서 **특정 값 검색**.  
    - `SCASB/SCASW/SCASD` : byte/word/dword 단위.  
    - `repne scasb` : AL과 같은 값이 나올 때까지(또는 ECX=0) 앞으로 진행하며 검색.  

5. STOSB, STOSW, STOSD  
    - `AL/AX/EAX` 값을 `[EDI]` 에 저장하고, EDI를 한 요소만큼 이동.  
    - `rep stosb` : 배열 전체를 같은 값으로 채울 때(메모리 초기화) 사용.  

6. LODSB, LODSW, LODSD  
    - `[ESI]` 에서 값을 읽어 `AL/AX/EAX` 로 가져오고, ESI 이동.  
    - 배열 원소를 하나씩 읽어와 계산할 때 사용.  

7. compare (CMP)  
    - `CMP dest, src` : 실제로는 `dest - src` 를 계산하고 **결과는 버린 채 플래그만 갱신**.  
    - ZF, CF 등을 기준으로 `JE/JNE/JG/JA` 같은 조건 분기 명령과 함께 사용.  
    - `CMPSx`, `SCASx` 도 내부적으로는 `CMP` 결과를 이용해 `REPE/REPNE` 가 반복을 제어.  

8. str length procedure (Str_length)  
    - Irvine 라이브러리: 널 종료 문자열 길이를 **EAX** 에 반환.  
    - 사용 예: `INVOKE Str_length, ADDR string_2` → EAX = 길이.  

9. str_trim (Str_trim)  
    - 문자열 끝에서부터 지정한 문자(예: `' '`, `'/'`)를 **모두 제거**.  
    - `INVOKE Str_trim, ADDR string_1, '/'` 처럼 사용.  
    - 끝에서부터 거꾸로 스캔 → 지우고 싶은 문자가 아닌 첫 글자 뒤에 널(0) 대입.  

10. ordering of rows and columns  
    - **Row-major (행 우선)**  
      - 행 0 전체 → 행 1 전체 → … 순서로 메모리에 저장. (C/Java 기본)  
    - **Column-major (열 우선)**  
      - 열 0 전체 → 열 1 전체 → … 순서.  
    - 보통 우리가 다루는 2차원 배열은 row-major 기준.  

11. BASE-Index Operands  
    - **base + index** 두 레지스터를 더해 만든 주소로 메모리에 접근하는 형식.  
    - 예: `[ebp + edi]`, `[ebx + esi]`.  
    - 구조체 배열, 2차원 배열에서 행/열 offset 계산할 때 자주 사용.  

12. two dimensional array  
    - 실제 메모리는 1차원 배열이지만, **행(row)/열(col)** 로 논리적으로 나눠서 사용.  
    - C 스타일 2차원 배열은 **row-major**: 행 단위로 연속 저장.  
    - 주소: `base + row * rowSize + col` (rowSize = 한 행의 byte 수).  

13. scale factors  
    - 인덱스 레지스터에 곱해지는 크기. 허용 값: **1, 2, 4, 8**.  
      - BYTE 배열 → 1  
      - WORD 배열 → 2  
      - DWORD 배열 → 4  
      - QWORD 배열 → 8  
    - 예: `mov eax, [array + esi*4]` (dword 배열, 인덱스*4).  

14. base index displacement operands  
    - 일반 형태: `[displacement + base + index*scale]`.  
    - displacement: 배열 이름(시작 주소), base: 행 offset, index*scale: 열/필드 offset.  
    - 복잡한 구조체/2차원 배열에서 한 번에 원하는 위치 계산 가능.  

15. bubble sort  
    - 인접한 두 값을 비교해서 순서가 반대면 **교환**.  
    - 한 패스가 끝날 때마다 **가장 큰 값이 배열 끝으로 이동**.  
    - 총 (n-1)번 패스로 정렬, 시간 복잡도 **O(n²)**, 구현은 매우 간단.  

16. binary search  
    - 전제: **배열이 정렬되어 있어야 함** (보통 오름차순).  
    - `first`, `last` 범위에서 `mid = (first + last)/2` 선택 →  
      - `array[mid] == key` : 찾음  
      - `array[mid] < key`  : 오른쪽 반으로 범위 축소  
      - `array[mid] > key`  : 왼쪽 반으로 범위 축소  
    - 시간 복잡도 **O(log n)**, 어셈블리에서는 mid 계산과 index*4 주소 계산이 핵심.  
