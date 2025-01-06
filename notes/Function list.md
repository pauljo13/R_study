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
c() : 숫자 벡터 생성
n:m : n부터 m까지 1씩 증가하거나 감소하는 수열 생성
seq(n,m) : n에서 m까지 1씩 증가하거나 감소하는 수열 생성
seq(n,m by=k) : n에서 m까지 k씩 만큼 증가하거나 감소한다.
seq(length=j, from=n, by=k) : n부터 k씩 만큼 j길이(개수) 만큼 수열 생성
seq(along = y) : y 벡터의 길이 만큼 일련번호를 생성한다.
rep(x, times = n) : x 벡터를 n 만큼 반복시킨다.
rep(x, each = n) : x 벡터의 요소를 n 만큼 반복한다.


# 벡터 관련 함수
length(x) : 벡터 x의 길이를 반환
sum(x) : 벡터 x의 있는 머든 요소들을 더한 결과를 반환
mean(x) : 모든 요소의 평균값 반환
var(x) : 요소들의 분산을 반환
sd(x) : 요소들의 표준편차를 반환
range(x) : 요소들의 최소값과 최대값을 반환
min(x) : 최소값 반환
max(x) : 최대값 반환
median(x) : 요소들의 중위수를 반환
rank(x) : 각 요소를 작은 것에서 큰 것까지 순위를 반환
sort(x) : 벡터 x의 각 요소를 순서대로 배열
order(x) : 벡터 x의 요소의 값이 가장 작은 것부터 가장 큰 것까지 순서대로 요소의 위치 반환
which.max(x) : 벡터 x의 최대값 위치 반환
which.min(x) : 벡터 x의 최소값 위치 반환
which(x) : 벡터 x에서 조건을 만족하는 요소의 위치를 반환

# 논리 벡터
any() : OR, |,  T가 하나라도 있으면 TRUE
all() : AND, &, 모두 T면 TRUE
ifelse(x, a, b) : 논리 벡터를 이용하는 또 다른 벡터 연산 함수
	x : 논리 벡터
	a & b : x의 길이와 동일한 벡터
	x의 요소가 T = a
	x의 요소가 F = b


# 문자 벡터
c("문자","문자2", ...)
as.character(n) : 숫자나 논리 벡터 n을 문자 벡터로 전환
paste() : 문자 벡터에 많이 사용되는 연산 중 하나로 문자 벡터를 요소끼리 서로 연결시키는 연산
strsplit() : 문자열을 나눌 때 구분자로 사용한 문자열을 split= " "인수로 제공해 나눔
nchar() : 문자 벡터의 각 요소의 문자 개수를 알려 준자. 공백도 문자이므로 문자 개수를 셀 때 포함이 된다는데 주의한다.
substr(x, start, stop) : 벡터 x의 문자열 요소의 start번째 문자부터 stop번째 문자까지의 부분 문자열을 출력한다.
grep(pattern, x, ignore.case=F, fixed=F) : 벡터 x의 문자열 요소에 pattern 문자열 요소가 있는지 검색한다. pattern은 정규식일 수 있다.
ub(pattern, replacement, x, ignore.case=F, fixed=F) : 벡터 x의 문자열 요소에서 pattern을 찾아 replacement로 대체한다.
strsplit(x, split, fixed=F) : 벡터 x의 문자열 요소를 split에서 분리한 결과를 반환한다.
paste(…, sep=’ ’) : 문자 벡터를 sep를 이용하여 결합시킨 결과를 반환한다.
toupper(x) : 벡터 x의 문자열 요소를 대문자로 변환한다.
tolower(x) : 벡터 x의 문자열 요소를 소문자로 변환한다.


# Missing Values
is.na() : NAN와 NA 결측치이면 TRUE로 반환
na.omit() : 결측치의 위치를 반환하고 결측치를 제외한 벡터를 만들 수 있다.
na.rm 인수 : sum(), mean() 함수 등의 결과에서 NA가 포함되면 NA로 나오기 때문에 na.rm = TRUE로 결측치를 제외한 값을 구한다.
NaN : Not a Number , 결측치는 아니지만 데이터 값을 결정할 수 없음
Inf : 무한대
is.nan() : NaN 만 TRUE


# 인덱스

```