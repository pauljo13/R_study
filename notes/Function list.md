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
strsplit("x y", split="c") : 문자열을 split="c" 기준으로 분리


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
seq(along = y) : y 벡터의  만큼 일련번호를 생성한다.
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
summary() : 최소값, 사분위수, 최대값, 평균 등

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
gsub(pattern, replacement, x, ignore.case=F, fixed=F) : 벡터 x의 문자열 요소에서 pattern을 찾아 replacement로 대체한다.
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


# 인덱스 벡터와 필터링
vector[index_vector]
x[which.min(x)] : 벡터의 최소값인 요소를 반환
x[which.max(x)] : 벡터의 최대값인 요소를 반환
x[which()] : 조건에 맞는 요소들을 반환
x[order(x)] : 벡터의 크기 순서대로 반환 = sort(x)
x[-n] : n 인덱스에 있는 요소를 제거하고 반환
x[x(T,F,T,...)] : 논리 벡터를 이용하면 T인 인덱스 요소만 반환된다.
x[x > n] : x 벡터 내의 n보다 큰 요소만 반환된다.
names(vector) <- c("name1","name2", ...) : 벡터의 이름이 할당된다.
x[index] <- velue : 벡터의 특정 인덱스에 값을 할당할 수 있다.


# Matrix
matrix(n, nrow = x, ncol = y, byrow = ) : 행렬 생성
	- n : 행렬에 들어갈 값
	- nrow : 행, 가로줄 개수
	- ncol : 열, 세로줄 개수
	- byrow : T, 열이 아닌 행을 차례대로 채우기
	- 행렬의 재사용 : 벡터가 행렬의 요소 개수보다 적으면 벡터가 재사용됨
attributes() : 원래의 벡터 n과 벡터로 만들어진 행렬 m의 속서을 보여줌
	- $dim : 행렬의 배열을 보여줌
cbind() : 옆으로 결합, 행의 개수가 같아야 한다.
rbind() : 밑으로 결합, 열의 개수가 같아야 한다.
	- 각각의 행렬이 가진 행 혹은 열의 개수는 반드시 일치해야 한다.
Matrix[i,j]
	- i : 행(row)의 값
	- j : 열(col)의 값
rownames() : row 값들의 이름을 부여
colnames() : col 값들의 이름을 부여
행렬의 연산 : 행과 열의 수가 같은 행렬은 산술 연산을 할 수있다.
	- 행과 열이 다른 경우 행렬은 재사용 되지 않아 오류가 일어난다.
벡터와 행렬의 연산, 벡터는 재사용된다.
t() : 전치행렬(transposed matrix)을 만드는 함수
nrow() : 행의 수를 반환
ncol() : 열의 수를 반환
dim() : 행과 열의 차원 전체를 반환
as.vector() : c(matrix)행렬을 벡터로 전환한다. 
apply(X, MARGIN, FUN, ...) : 
	- X : 행렬 또는 열별로 함수를 적용할 행렬
	- MARGIN : 함수를 적용할 방향을 지정
		- 1 : 행, 가로
		- 2 : 열, 세로
	- FUN : 행이나 열별로 적용할 함수를 전달
array(data, dim) : dim의 행렬 구조에 data를 넣어서 만드며, data는 재사용된다.
dim(x,y,z) : 3 차원 배열
dim(x,y,z,w) : 4 차원 배열
-> 배열은 dim 속성을 갖는 벡터
dimnames() <- list(x, y, z)
	- x : 행의 이름
	- y : 열의 이름
	- z : 3차원 이름
dimnames[[i]] : i 의 이름 반환 (1 : row / 2 : col / 3 : 차원)
3 차원 연산, 각 차원끼리 연산이 된다.
diag() : 주 대각선 요소를 추출하거나, 대각행렬을 만든다.
solve() : 일차 연립 방정식
eigen() : 행렬의 고유치와 고유벡터를 구한다.
	- values, vectors 라는 두 요소를 가지는 리스트를 반환
	- only.values = TURE : 인수로 고유벡터를 제외한 고유치만 반환


# 객체 속성 함수
typeof() : 객체의 데이터 타입을 반환하는 함수
length() : 객체의 데이터 길이를 반환
class() : 객체에 따라 부여되지 않을 수도 있고 여러 개가 부여될 수 있는 속성
attr() : 객체에서 특정 이름을 가진 속성을 보여주거나 해당 속성에 데이터를 할당

# 리스트
list(요소1, 요소2, ...)
list(이름1 = 요소1, 이름2, = 요소2, ...)
	- 요소 : 문자, 숫자, 논리값
	- $ : 요소의 이름 표시
names() : 리스트의 이름을 반환한다.
typeof(), length() 도 리스트에서 사용 가능
List[[]] : 연산자와 요소의 번호로 지정
	- 연산자와 요소의 번호 대신 문자열을 제시 가능
	- 칸에 요소의 번호로 리스트를 추가 할 수 있다.
	- NULL를 리스트 요소 값으로 넣어 해당 요소 값을 삭제할 수 있다.
list_name$component_name : 지정
as.list() : list 형태로 형변환 가능하다.
c(List1, List2) : 두 개의 리스트를 연결할 수 있다.
list(List1, List2) : 계측적인 리스트를 만들 수 있다.
unlist() : 리스트를 벡터로 형 변환한다.
lapply(리스트, 함수) : 리스트의 각 요소에 함수를 적용함
sapply(리스트, 함수) : 벡터나 행렬처럼 출력됨
mapply(FUN, list_1(vector_1), ..., list_n(vector_n), MoreArgs=NULL) : 다수의 리스트에 대해 같은 위치의 요소들에 함수를 적용하는 함수
lm(col_1 ~ col_2, data = list) : 선형회귀분석
unclass() : 클래스 속성을 제거한다.

# 데이터 프레임
as.data.frame() : list나 벡터를 데이터 프레임으로 전환한다.
factor() : 범주형 데이터를 처리함, levels 요인이 생성됨


```