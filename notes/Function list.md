___
``` R
# 연산
사칙 연산 : +, -, *, /
몫 : %/%
나머지 : %%
거듭제곱 : x^n

# 비교 연산
== : 같다.
> & < : 크다, 작다
>= & <= : 같거나 크다, 같거나 작다
!= : 연산자는 같지 않다.

# 논리 연산자
& : AND
| : OR
! : NOT
xor(x,y) : XOR

# 문자열 연산
paste("x","y","..." sep = "c") : 문자열 결합, sep = "c"로 문자열을 결합
straplit("x y", split="c") : 문자열을 split="c" 기준으로 분리

# 변수
A = 값 : 변수 값 할당
A = A + "연산" : 변수 재할당
rm(A) : 변수 제거하기
ls() : 변수 목록 확인하기
assign("변수명", "변수값") : 변수를 할당

# 수학 연산 함수
sqrt(x) : 제곱근
ceiling(x) : x의 값을 정수로 올림
floor(x) : x의 값을 정수로 내림
trunc(x) : x의 값의 소수점 자리를 버림
round(x) : x의 값을 반올림
round(x, digits=n) : x의 값을 소수점 n자리에서 반올림
exp(x) : x의 지수함수 값
log(x) : 자연대수를 맡으로 하는 로그 값
log(x, base=a) : a를 밑으로 하는 로그 값
sin(x), cos(x), tan(x) : x의 삼각함수 값
factirial(n) : n! = 1*2* ... *n
choose(n, k) : n 개 중 k를 뽑는 조합의 수

# 숫자 벡터

```