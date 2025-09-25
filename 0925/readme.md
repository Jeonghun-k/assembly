# Assembly Language Programming 요약

## 1. Assembly Language Programming 개요

-   TOTAL Information, Simple Program, Assembly Language, Responsibility

## 2. 기초

-   `move eax, 5` : eax(레지스터)에 값 5 저장\
-   `add eax, 6` : eax 값에 6 더하기\
-   `INVOKE ExitProcess` : 프로그램 종료\
-   코멘트(주석) : `;`\
-   실행 파일은 CLU가 디스크에서 주기억장치로 옮겨 실행\
-   cl에서 `0 = 성공`, 다른 값 = 실패\
-   `int sum = 0` ⇒ `sum DWORD 0`

## 3. 인티저와 리터럴

-   접미사: h(16진수), q/o(8진수), d(10진수), b(2진수)\
-   언어에 따라 2진수 지원 여부 다름

## 4. Constant Integer Expression

-   MOD : 나머지\
-   지수(E), 가수(M: 소숫점 부분) (p.8)

## 5. Character

-   `'a'` 또는 `"d"`

## 6. String Literals

-   character도 string에 포함\
-   예: `'abc'`, `"this isn’t a test"`

## 7. 예약어

-   명령어: MOV, ADD, MUL\
-   디렉티브: 번역기에게 지시하는 명령\
-   연산자: Operator\
-   `@`: 사용자 정의 가능하지만 권장하지 않음

## 8. 아이덴티파이어

-   대소문자 구분 없음

## 9. 세그먼트(Segments)

-   함수 실행 시 필요한 메모리 존재\
-   스택: 함수 실행 후 원래 위치로 돌아가는 주소 저장\
-   `.data`, `.code`, `.stack 100h`

## 10. Instruction

-   require(필수), optional(선택)

## 11. Label

-   점프(JMP) 시 사용

## 12. Instruction Mnemonic

-   기계어 명령의 축약 표현

## 13. Operands (오퍼랜드)

-   명령 대상\
-   `add eax, 6` → add = 명령어, eax·6 = 오퍼랜드\
-   `stc`: Carry flag 설정 (오퍼랜드 없음)\
-   `inc eax`: eax에 1 더함\
-   `mov count, ebx`: ebx 값을 count에 저장\
-   오퍼랜드 2개일 때: 첫 번째 = 저장 공간, 두 번째 = 연산 값

## 14. Comment

-   사람에게 알림, 주석\
-   단일 줄: `;`\
-   블록 주석: `!`

## 15. NOP (No Operation)

-   1바이트 차지, 아무 일도 하지 않음\
-   명령어 정렬을 맞추기 위해 사용\
-   예:
    -   `66 8B C3` (3바이트)\
    -   `90` (NOP, 1바이트)\
    -   `8B D1` (다음 명령)

## 16. Visual Studio 실행

-   `Ctrl + F5` → 창 실행

## 17. 디버깅

-   브레이크포인트 → 실행 후 레지스터 값 확인 가능

## 18. 리스팅 파일

-   어셈블 결과를 보여주는 파일\
-   리스팅 파일, 맵 파일 참조 (p.26 그림)

## 19. 데이터 정의 문장

-   디렉티브 + 초기화\
-   p.30 표, Legacy data directives 외우기

## 20. Multiple Initializer

-   `list BYTE 10,20,30,40` → 각 값이 1바이트 단위로 저장

## 21. DUP

-   `BYTE 20 DUP(0)` : 20바이트를 0으로 채움

## 22. DWORD / SDWORD

-   4바이트 단위 증가

## 23. BCD

-   큰 숫자 처리 가능

## 24. REAL

-   실수 표현

## 25. Little Endian

-   값을 거꾸로 저장\
-   예: 1234 → 4321 저장, 읽을 때는 1234

## 26. Uninitialized Data

-   `?` 사용\
-   초기화 여부에 따라 실행 시 동작 차이 발생

## 27. Equal Sign Directive

-   상수 정의

## 28. 배열/문자열 크기 계산

-   `$` → 현재 주소\
-   `List BYTE 10,20,30,40`\
-   `ListSize = ($ - list)` → 4

## 29. EQU Directive

-   변경 불가 (변경 시 에러 발생)

## 30. TEXTEQU

-   변경 가능

