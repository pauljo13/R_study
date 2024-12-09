___
# 2. 리스트의 생성 및 필터링
R의 리스트는 component라고 불리는 객체들을 순서대로 모은 데이터 구조이다. 리스트의 요소들은 서로 다른 데이터 형식일 수 있다. 이론적으로 말하자면 리스트는 서로 다른 타입을 가지는 요소에 대한 주소 정보를 가지고 있는 데이터 형식이다.

##### list
`list(요소1, 요소2, ...)`
`list(이름1 = 요소1, 이름2 = 요소2, ...)`
``` r
> a <- list(name="Fred", age=43, wife="Mary",
+           no.children= 3, child.ages=c(4, 7, 9), is.house.owner=T)
> a
$name
[1] "Fred"

$age
[1] 43

$wife
[1] "Mary"

$no.children
[1] 3

$child.ages
[1] 4 7 9

$is.house.owner
[1] TRUE

```
요소로 문자, 숫자, 논리값을 모두 포함할 수 있음을 볼 수 있다. 
`$` = 요소의 이름 표시

##### names()
typeof()와 length() 함수를 이용하면 객체의 내재적 속성인 타입과 요소의 길이를 확인할 수 있다.
``` r

```