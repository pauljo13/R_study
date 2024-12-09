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
> typeof(a)
[1] "list"
> length(a)
[1] 6
> attributes(a)
$names
[1] "name"           "age"            "wife"           "no.children"    "child.ages"     "is.house.owner"

> names(a)
[1] "name"           "age"            "wife"           "no.children"    "child.ages"     "is.house.owner"
> a2 <- list(1:5, letters[1:8], LETTERS[1:3]); a2
[[1]]
[1] 1 2 3 4 5

[[2]]
[1] "a" "b" "c" "d" "e" "f" "g" "h"

[[3]]
[1] "A" "B" "C"
```

##### 리스트 요소의 이름은 자동으로 부여되지 않는다.
```r
> cbind(var1, var2)
     var1 var2
[1,]    1    4
[2,]    2    5
[3,]    3    6
> data.frame(var1, var2)
  var1 var2
1    1    4
2    2    5
3    3    6

> list(var1, var2)
[[1]]
[1] 1 2 3

[[2]]
[1] 4 5 6
> list(var1=var1, var2=var2)
$var1
[1] 1 2 3

$var2
[1] 4 5 6
```

##### 리스트 요소 지정
리스트에서 요소 하나를 지정할 때는 주로 다음의 세가지 방법을 사용한다.
1. `[[]]` 연산자와 요소의 번호로 지정
2. `list_name$component_name` 형태로 지정
3. `[[]]` 연산자와 요소의 번호 대신 문자열을 제시
``` r
> a[[3]]
[1] "Mary"
> a$wife
[1] "Mary"
> a[["wife"]]
[1] "Mary"

# 단계적으로 요소 지정
> a[[5]]
[1] 4 7 9
> a[[5]][2:3]
[1] 7 9
> a$child.ages[2:3]
[1] 7 9

# 요소의 이름 단축
> a$no
[1] 3
> a$child
[1] 4 7 9

# 부분 리스트 필터링
> a[1:3]
$name
[1] "Fred"

$age
[1] 43

$wife
[1] "Mary"
> a[-(4:5)]
$name
[1] "Fred"

$age
[1] 43

$wife
[1] "Mary"

$is.house.owner
[1] TRUE
> a[c("wife", "child.ages")]
$wife
[1] "Mary"

$child.ages
[1] 4 7 9

> a[c(T, F, F)]
$name
[1] "Fred"

$no.children
[1] 3

```

#### 리스트 요소 지정 vs. 부분 리스트 필터링
벡터의 필터링의 결과는 원래 벡터의 부분으로 구성된 벡터인 것과 마찬가지로, 리스트의 []필터링의 결과는 리스트의 부분으로 구성된 또 다른 리스트가 된다. 반면 [[]]나 $ 연산자르 이용하여 요소를 지정하는 것은 리스트의 요소 그 자체가 된다.
-> 다른 리스트가 되는 것이 아니라 리스틔의 요소가 벡터이면 벡터 그 자체가 된다.
```r
> a[[5]]
[1] 4 7 9
> a[5]
$child.ages
[1] 4 7 9

> a[[5]][2:3]
[1] 7 9
> a[[5]]*7
[1] 28 49 63
> a[5][2:3]
$<NA>
NULL

$<NA>
NULL

> a[5]*7
Error in a[5] * 7 : non-numeric argument to binary operator
```

