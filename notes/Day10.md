___
# 리스트의 변경 및 연결
##### 리스트 요소의 추가
이미 생성된 리스트는 새로운 요소를 추가함으로써 확장될 수 있다. 새로운 요소를 추가하거나 변경하는 방법은 여러 가지가 있을 수 있다.
``` r
> a <- list(name="Fred", age=43, wife="Mary", 
+           no.children= 3, child.ages=c(4, 7, 9), 
+           is.house.owner=T)
> length(a)
[1] 6

# 리스트 요소 추가의 다양한 방법
> a[[7]] <- 1:5
> a[["address"]] <- "Cheonan"
> a$years.since.marrage <- 15
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

[[7]]
[1] 1 2 3 4 5

$address
[1] "Cheonan"

$years.since.marrage
[1] 15

> length(a)
[1] 9

# 리스트 데이터 수정하는 다양한 방법
> a[[7]] <- 10:18
> a$address <- "Daejeon"
> a[[9]] <- 16
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

[[7]]
[1] 10 11 12 13 14 15 16 17 18

$address
[1] "Daejeon"

$years.since.marrage
[1] 16

```

##### 자연수 인덱스를 이용한 리스트의 추가와 빈 요소의 생성
``` r
> a2 <- list(1:5, letters[1:8], LETTERS[1:3])
> a2
[[1]]
[1] 1 2 3 4 5

[[2]]
[1] "a" "b" "c" "d" "e" "f" "g" "h"

[[3]]
[1] "A" "B" "C"

> a2[[5]] <- "New items" ;a2
[[1]]
[1] 1 2 3 4 5

[[2]]
[1] "a" "b" "c" "d" "e" "f" "g" "h"

[[3]]
[1] "A" "B" "C"

[[4]]
NULL

[[5]]
[1] "New items"
```

##### 리스트 요소의 삭제
``` r
> a2 <- list(1:5, letters[1:8], LETTERS[1:3])
> a2
[[1]]
[1] 1 2 3 4 5

[[2]]
[1] "a" "b" "c" "d" "e" "f" "g" "h"

[[3]]
[1] "A" "B" "C"
> a2[[5]] <- "New items" ;a2
[[1]]
[1] 1 2 3 4 5

[[2]]
[1] "a" "b" "c" "d" "e" "f" "g" "h"

[[3]]
[1] "A" "B" "C"

[[4]]
NULL

[[5]]
[1] "New items"

> a2[[5]] <- NULL; a2
[[1]]
[1] 1 2 3 4 5

[[2]]
[1] "a" "b" "c" "d" "e" "f" "g" "h"

[[3]]
[1] "A" "B" "C"

[[4]]
NULL

> a2[[4]] <- NULL; a2
[[1]]
[1] 1 2 3 4 5

[[2]]
[1] "a" "b" "c" "d" "e" "f" "g" "h"

[[3]]
[1] "A" "B" "C"

> names(a2) <- c("num", "lower.case", "upper.case"); a2
$num
[1] 1 2 3 4 5

$lower.case
[1] "a" "b" "c" "d" "e" "f" "g" "h"

$upper.case
[1] "A" "B" "C"

> a2$num <- NULL; a2
$lower.case
[1] "a" "b" "c" "d" "e" "f" "g" "h"

$upper.case
[1] "A" "B" "C"
```

##### 부분 리스트를 이용한 리스트 변경
``` r
> a2[3:4] <- list(1:5, month.name); a2
$lower.case
[1] "a" "b" "c" "d" "e" "f" "g" "h"

$upper.case
[1] "A" "B" "C"

[[3]]
[1] 1 2 3 4 5

[[4]]
 [1] "January"   "February"  "March"     "April"     "May"       "June"      "July"      "August"    "September" "October"  
[11] "November"  "December" 
```

##### 리스트의 recycling
``` r
> a2[3:6] <- list(11:15, month.abb); a2
$lower.case
[1] "a" "b" "c" "d" "e" "f" "g" "h"

$upper.case
[1] "A" "B" "C"

[[3]]
[1] 11 12 13 14 15

[[4]]
 [1] "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"

[[5]]
[1] 11 12 13 14 15

[[6]]
 [1] "Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec"
```


##### 벡터의 리스트로의 형변환
``` r
> a2[3:6] <- c("X", "Y", "Z", "W"); a2
$lower.case
[1] "a" "b" "c" "d" "e" "f" "g" "h"

$upper.case
[1] "A" "B" "C"

[[3]]
[1] "X"

[[4]]
[1] "Y"

[[5]]
[1] "Z"

[[6]]
[1] "W"

> c("X", "Y", "Z", "W")
[1] "X" "Y" "Z" "W"
> as.list(c("X", "Y", "Z", "W"))
[[1]]
[1] "X"

[[2]]
[1] "Y"

[[3]]
[1] "Z"

[[4]]
[1] "W"

> a2[3:6] <- NULL; a2
$lower.case
[1] "a" "b" "c" "d" "e" "f" "g" "h"

$upper.case
[1] "A" "B" "C"
```

##### c() 를 이용한 리스트 연결하기
``` r
> a3 <- list(first=1:3, second=4:6); a3
$first
[1] 1 2 3

$second
[1] 4 5 6

> a4 <- c(a2, a3); a4
$lower.case
[1] "a" "b" "c" "d" "e" "f" "g" "h"

$upper.case
[1] "A" "B" "C"

$first
[1] 1 2 3

$second
[1] 4 5 6

> length(a4)
[1] 4
```

##### 계층적인 리스트 만들기
- 두개의 리스트를 c() 로 연결하면 리스트 두 개가 합쳐진다. 하지만 list()로 두개의 리스트를 합치면 하나의 리스트가 각 요소가 되어 두개의 요소가 있는 리스트가 만들어져 계측적인 구조를 갖게 된다.
``` r
> a5 = list(a2, a3); a5
[[1]]
[[1]]$lower.case
[1] "a" "b" "c" "d" "e" "f" "g" "h"

[[1]]$upper.case
[1] "A" "B" "C"


[[2]]
[[2]]$first
[1] 1 2 3

[[2]]$second
[1] 4 5 6


> length(a5)
[1] 2


> a4[[2]]
[1] "A" "B" "C"
> a5[[2]]
$first
[1] 1 2 3

$second
[1] 4 5 6

> a5[[1]][[2]]
[1] "A" "B" "C"
> a5[[2]]$second
[1] 4 5 6
> c(a4, a5)
$lower.case
[1] "a" "b" "c" "d" "e" "f" "g" "h"

$upper.case
[1] "A" "B" "C"

$first
[1] 1 2 3

$second
[1] 4 5 6

[[5]]
[[5]]$lower.case
[1] "a" "b" "c" "d" "e" "f" "g" "h"

[[5]]$upper.case
[1] "A" "B" "C"


[[6]]
[[6]]$first
[1] 1 2 3

[[6]]$second
[1] 4 5 6


> c(a4, a5, recursive = TRUE)
lower.case1 lower.case2 lower.case3 lower.case4 lower.case5 lower.case6 lower.case7 lower.case8 upper.case1 upper.case2 
        "a"         "b"         "c"         "d"         "e"         "f"         "g"         "h"         "A"         "B" 
upper.case3      first1      first2      first3     second1     second2     second3 lower.case1 lower.case2 lower.case3 
        "C"         "1"         "2"         "3"         "4"         "5"         "6"         "a"         "b"         "c" 
lower.case4 lower.case5 lower.case6 lower.case7 lower.case8 upper.case1 upper.case2 upper.case3      first1      first2 
        "d"         "e"         "f"         "g"         "h"         "A"         "B"         "C"         "1"         "2" 
     first3     second1     second2     second3 
        "3"         "4"         "5"         "6" 
```


##### unlist() 로 리스트를 벡터로 형 변환하기
``` r
> unlist(a3)
 first1  first2  first3 second1 second2 second3 
      1       2       3       4       5       6 
> unlist(a4)
lower.case1 lower.case2 lower.case3 lower.case4 lower.case5 lower.case6 lower.case7 lower.case8 upper.case1 upper.case2 
        "a"         "b"         "c"         "d"         "e"         "f"         "g"         "h"         "A"         "B" 
upper.case3      first1      first2      first3     second1     second2     second3 
        "C"         "1"         "2"         "3"         "4"         "5"         "6" 

> a = c("R is a specialized programming language for statistical analysis.", "A variety of data analysis functions are built-in.")
> b = strsplit(a, split = " "); b
[[1]]
[1] "R"           "is"          "a"           "specialized" "programming" "language"    "for"         "statistical" "analysis."  

[[2]]
[1] "A"         "variety"   "of"        "data"      "analysis"  "functions" "are"       "built-in."
```