___
# Chapter 9 R 고급 데이터 변환
실제 데이터 분석에서는 분석하고자 하는 데이터가 하나의 데이터 프레임에 정돈 형식으로 제공되는 경우가 많지 않다. 대부분의 경우 다음 두 가지 작업 중 하나 또는 두 가지 모두가 필요한 경우가 많다.
- Merge : 다양한 원천에서 획득된 데이터를 하나의 정돈 데이터로 결합
- Reshape : 비정돈 형식의 데이터를 정돈 데이터 형식으로 변환하기
이러한 데이터 전처리에 필요한 다양한 기법을 논의한다. 데이터의 결합을 위해서는 dplyr 패키지를 사용할 것이며, 비정돈 형식의 데이터를 정돈 데이터 형식으로 변현하기 위해서는 tidyr 패키지를 사용할 것이다. 이 두 패키지는 모두 tidyverse 패키지에 속해 있으므로, 이 두 패키지를 사용하기 위해 적재한다.
`library(tidyverse)`


___
# 1. 데이터의 단순 결합
#### 행으로 경합 VS 열로 결합

| **구분**                          | **1. 데이터가 동일한 열 형식으로 나뉨**                                   | **2. 데이터가 동일한 행 형식으로 나뉨**                                   |
|-----------------------------------|------------------------------------------------------------------------|------------------------------------------------------------------------|
| **설명**                          | 여러 파일이 동일한 열 형식을 가지고 있고 이를 **행**으로 결합해야 하는 경우 | 동일한 행을 가지고 있는 데이터에 서로 다른 열이 존재하며 이를 **열**로 결합해야 하는 경우 |
| **사용 함수**                     | `dplyr::bind_rows()` 또는 `rbind()`                                     | `dplyr::bind_cols()` 또는 `cbind()`                                     |
| **예시**                          | `bind_rows(data1, data2)` (2021.csv와 2022.csv 데이터를 하나로 결합)       | `bind_cols(data_personal, data_evaluation)` (개인 정보와 인사 평가 결합)  |
### 열 구조가 다른 데이터를 행으로 결합하기
데이터를 행으로 결합하는 작업이 필요한 경우, 데이터가 동일한 열 구조를 가지고 있지 않은 경우가 종종 발생한다. 동일한 열을 가지고 있더라도 열 이름이 서로 다른 경우도 있다. 이러 경우에는 결합하려는 데이터 프레임을 동일한 열 구조로 변형하여 결합하여야 한다.

##### rbind()은 열의 개수가 다른 데이터 프레임을 행으로 결합하지 못한다.
``` R
> rbind(class1, class2)
Error in rbind(deparse.level, ...) : 
  numbers of columns of arguments do not match
```

##### bind_row(class1, class2) 은 열의 개수가 다른 데이터 프레임임도 행으로 결합한다.
두 데이터에서 서로 없는 열은 결측치 `NA`로 처리되어 결합이 이루어지는 것을 볼 수 있다. 그러나 사실 `class1`의 `Midterm`과 `class2`의 `Mid`는 중간고사 점수 열로 같은 정보가 다른 열 이름으로 표현된 것 뿐이다. `bind_rows()`는 이름이 다르면 서로 다른 열이라고 생각하여 각각 새로운 열을 만들어 결합을 한다. 그러므로 사실상 같은 열이 서로 다른 이름으로 되어 있다면 이름을 동일하게 바꾸어 주어서 결합을 하여야 한다.
``` R
> bind_rows(class1, class2)
   ID   Name Gender Year Address Midterm Final Team Mid  Gen
1  15 김철수      M    1    서울      78    59    A  NA <NA>
2  18 김영희      F    3    경기      85    87    A  NA <NA>
3  25 이철수      M    3    충남      80    70    B  NA <NA>
4  34 이영희      F    2    대전      92    89    B  NA <NA>
5 151 홍길동   Male    4    세종      58    66    B  NA <NA>
6  12 장철수   <NA>    2    <NA>      NA    79    C  75    M
7  19 장영희   <NA>    2    <NA>      NA    89    C  75    F
8  28 최철수   <NA>    1    <NA>      NA    76    D  87    M
9  45 최영희   <NA>   30    <NA>      NA    79    D  82    F
```

##### rbind()는 두 데이터의 열의 이름이 다른 경우 행으로 결합하지 못한다.
``` R
> rbind(select(class1, -Address), class2)
Error in match.names(clabs, names(xi)) : 
  names do not match previous names

> rbind(select(class1, -Address), rename(class2, Midterm = Mid, Gender = Gen))
   ID   Name Gender Year Midterm Final Team
1  15 김철수      M    1      78    59    A
2  18 김영희      F    3      85    87    A
3  25 이철수      M    3      80    70    B
4  34 이영희      F    2      92    89    B
5 151 홍길동   Male    4      58    66    B
6  12 장철수      M    2      75    79    C
7  19 장영희      F    2      75    89    C
8  28 최철수      M    1      87    76    D
9  45 최영희      F   30      82    79    D
```

##### rbind() 와 bind_rows()는 열의 순서를 자동으로 맞춘다.
``` R
> class12 <- bind_rows(select(class1, -Address),
+                      rename(class2, Midterm = Mid, Gender = Gen))
> class12
   ID   Name Gender Year Midterm Final Team
1  15 김철수      M    1      78    59    A
2  18 김영희      F    3      85    87    A
3  25 이철수      M    3      80    70    B
4  34 이영희      F    2      92    89    B
5 151 홍길동   Male    4      58    66    B
6  12 장철수      M    2      75    79    C
7  19 장영희      F    2      75    89    C
8  28 최철수      M    1      87    76    D
9  45 최영희      F   30      82    79    D
```

##### 합쳐지는 데이터에 식별자 부여하기
앞의 class1과 class2 데이터는 1분반과 2분반 학생의 데이터이다. 그런데 이 두 데이터를 행으로 결합한 데이터에서는 각 행이 어떤 데이터에서 온 것인지에 대한 정보가 없기 때문에 학생이 속한 분반을 확인할 수 없다. 
``` R
> bind_rows(select(class1, -Address),
+           rename(class2, Midterm = Mid, Gender = Gen),
+           .id = "Class")
  Class  ID   Name Gender Year Midterm Final Team
1     1  15 김철수      M    1      78    59    A
2     1  18 김영희      F    3      85    87    A
3     1  25 이철수      M    3      80    70    B
4     1  34 이영희      F    2      92    89    B
5     1 151 홍길동   Male    4      58    66    B
6     2  12 장철수      M    2      75    79    C
7     2  19 장영희      F    2      75    89    C
8     2  28 최철수      M    1      87    76    D
9     2  45 최영희      F   30      82    79    D
> dfs = list(select(class1, -Address), rename(class2, Midterm = Mid, Gender = Gen))
> bind_rows(dfs)
   ID   Name Gender Year Midterm Final Team
1  15 김철수      M    1      78    59    A
2  18 김영희      F    3      85    87    A
3  25 이철수      M    3      80    70    B
4  34 이영희      F    2      92    89    B
5 151 홍길동   Male    4      58    66    B
6  12 장철수      M    2      75    79    C
7  19 장영희      F    2      75    89    C
8  28 최철수      M    1      87    76    D
9  45 최영희      F   30      82    79    D
> bind_rows(dfs, .id = "Class")
  Class  ID   Name Gender Year Midterm Final Team
1     1  15 김철수      M    1      78    59    A
2     1  18 김영희      F    3      85    87    A
3     1  25 이철수      M    3      80    70    B
4     1  34 이영희      F    2      92    89    B
5     1 151 홍길동   Male    4      58    66    B
6     2  12 장철수      M    2      75    79    C
7     2  19 장영희      F    2      75    89    C
8     2  28 최철수      M    1      87    76    D
9     2  45 최영희      F   30      82    79    D
```

### 데이터를 열로 결합하기
##### 행 순서가 다른 데이터를 열로 결합하기
데이터를 열로 결합하는 경우 실제 데이터가 동일한 행 순서로 정렬되어 있지 않은 경우가 종종 있다.
``` R
> attendance
   ID Class Attend
1  12     2    185
2  15     1     90
3  18     1     95
4  19     2    100
5  25     1    100
6  28     2    100
7  34     1    100
8  45     2    100
9 151     1     95
```

##### 정렬 후 열로 결합하기
``` R
> class12.a <- bind_cols(arrange(class12, ID), select(attendance, -ID))
> class12.a
   ID   Name Gender Year Midterm Final Team Class Attend
1  12 장철수      M    2      75    79    C     2    185
2  15 김철수      M    1      78    59    A     1     90
3  18 김영희      F    3      85    87    A     1     95
4  19 장영희      F    2      75    89    C     2    100
5  25 이철수      M    3      80    70    B     1    100
6  28 최철수      M    1      87    76    D     2    100
7  34 이영희      F    2      92    89    B     1    100
8  45 최영희      F   30      82    79    D     2    100
9 151 홍길동   Male    4      58    66    B     1     95
> class12.b <- bind_cols(class12,
+                        attendance %>% arrange(Class, ID) %>% select(-ID))
> class12.b
   ID   Name Gender Year Midterm Final Team Class Attend
1  15 김철수      M    1      78    59    A     1     90
2  18 김영희      F    3      85    87    A     1     95
3  25 이철수      M    3      80    70    B     1    100
4  34 이영희      F    2      92    89    B     1    100
5 151 홍길동   Male    4      58    66    B     1     95
6  12 장철수      M    2      75    79    C     2    185
7  19 장영희      F    2      75    89    C     2    100
8  28 최철수      M    1      87    76    D     2    100
9  45 최영희      F   30      82    79    D     2    100
```


# 2. 관계형 데이터베이스처럼 데이터 결합하기
관계형 데이터베이스에서는 서로 다른 열 정보를 담고 있는 두 데이터 테이블을 key를 사용하여 join이라는 방식을 이용하여 연결시킨다.
R에서도 두 데이터 프레임을 관계형 데이터베이스의 join과 같은 방식으로 결합시킬 수 있다. 이 작업은 R의 기본 함수인 `merge()` 함수를 이용하여 수행할 수도 있고, dplyr 패키지의 join 함수들을 사용하여 수행할 수도 있다
### Inner join과 outer join
##### inner join
- **1:1 Inner Join**
    
    - 두 데이터 프레임의 특정 열(by로 지정)의 값이 **1:1로 정확히 대응**될 때 사용.
    - 결과 데이터는 **양쪽 데이터 프레임 모두에 존재하는 값**만 포함.
    - 예: 두 데이터 프레임에 동일한 학생 ID가 있을 경우 해당 학생 정보만 결합.
- **0:1 Inner Join**
    
    - 한 데이터 프레임에는 값이 있고, 다른 데이터 프레임에는 해당 값이 없을 수 있는 경우.
    - 결과 데이터는 **공통된 값이 있는 행만 포함**, 한쪽에만 있는 데이터는 제외.
    - 예: 1분반(class1) 데이터와 1, 2분반(attendance) 데이터를 결합할 경우, 1분반에 있는 학생 데이터만 남음.
- **기준 열(by 인수)**
    
    - `inner_join()` 함수는 기본적으로 **이름이 같은 열**을 기준으로 자동 결합.
    - 명시적으로 결합 기준 열을 설정할 수도 있음.
    
    R
    
    복사편집
    
    `inner_join(df1, df2, by = "공통 열 이름")`
    
- **결과 특징**
    
    - **공통된 열의 값**이 양쪽 데이터 프레임에 존재해야 해당 행이 결과에 포함됨.
    - 한쪽 데이터 프레임에만 있는 행은 제거됨.
``` R
# inner join
> inner_join(class12, attendance)
Joining with `by = join_by(ID)`
   ID   Name Gender Year Midterm Final Team Class Attend
1  15 김철수      M    1      78    59    A     1     90
2  18 김영희      F    3      85    87    A     1     95
3  25 이철수      M    3      80    70    B     1    100
4  34 이영희      F    2      92    89    B     1    100
5 151 홍길동   Male    4      58    66    B     1     95
6  12 장철수      M    2      75    79    C     2    185
7  19 장영희      F    2      75    89    C     2    100
8  28 최철수      M    1      87    76    D     2    100
9  45 최영희      F   30      82    79    D     2    100
> inner_join(class1, attendance, by="ID")
   ID   Name Gender Year Address Midterm Final Team Class Attend
1  15 김철수      M    1    서울      78    59    A     1     90
2  18 김영희      F    3    경기      85    87    A     1     95
3  25 이철수      M    3    충남      80    70    B     1    100
4  34 이영희      F    2    대전      92    89    B     1    100
5 151 홍길동   Male    4    세종      58    66    B     1     95
```

##### Outer join
한 쪽 데이터 프레임에 해당 행이 없더라도 어느 한쪽의 데이터 프레임에 행이 있으면 그 행을 포함시킬 필요가 있는 경우가 있다.
outer_join 함수들을 사용한다. Outer join 함수는 다음 세 가지가 있다.
- `left_join(x, y)`: x에 있는 행을 모두 유지하여 join을 수행한다.
- `right_join(x, y)`: y에 있는 행을 모두 유지하여 join을 수행한다.
- `full_join(x, y)`: x와 y의 모든 행을 유지하여 join을 수행한다.
대신 한 쪽에 없는 정보는 모두 결측치 `NA`가 입력되어 결합된다.
``` R
> x <- data.frame(id=1:3, name = letters[1:3]); x
  id name
1  1    a
2  2    b
3  3    c
> y <- data.frame(id=2:4, addr = LETTERS[2:4]); y
  id addr
1  2    B
2  3    C
3  4    D
> inner_join(x, y)
Joining with `by = join_by(id)`
  id name addr
1  2    b    B
2  3    c    C
> left_join(x,y)
Joining with `by = join_by(id)`
  id name addr
1  1    a <NA>
2  2    b    B
3  3    c    C
> right_join(x,y)
Joining with `by = join_by(id)`
  id name addr
1  2    b    B
2  3    c    C
3  4 <NA>    D
> full_join(x,y)
Joining with `by = join_by(id)`
  id name addr
1  1    a <NA>
2  2    b    B
3  3    c    C
4  4 <NA>    D
> right_join(class1, attendance, by="ID")
   ID   Name Gender Year Address Midterm Final Team Class Attend
1  15 김철수      M    1    서울      78    59    A     1     90
2  18 김영희      F    3    경기      85    87    A     1     95
3  25 이철수      M    3    충남      80    70    B     1    100
4  34 이영희      F    2    대전      92    89    B     1    100
5 151 홍길동   Male    4    세종      58    66    B     1     95
6  12   <NA>   <NA>   NA    <NA>      NA    NA <NA>     2    185
7  19   <NA>   <NA>   NA    <NA>      NA    NA <NA>     2    100
8  28   <NA>   <NA>   NA    <NA>      NA    NA <NA>     2    100
9  45   <NA>   <NA>   NA    <NA>      NA    NA <NA>     2    100
```

##### 1:n inner join
``` R
> pjt
  Team Project
1    A      80
2    B      90
3    C      85
4    D      75
> class12.c <- inner_join(class12.a, pjt, by="Team")
> class12.c
   ID   Name Gender Year Midterm Final Team Class Attend Project
1  12 장철수      M    2      75    79    C     2    185      85
2  15 김철수      M    1      78    59    A     1     90      80
3  18 김영희      F    3      85    87    A     1     95      80
4  19 장영희      F    2      75    89    C     2    100      85
5  25 이철수      M    3      80    70    B     1    100      90
6  28 최철수      M    1      87    76    D     2    100      75
7  34 이영희      F    2      92    89    B     1    100      90
8  45 최영희      F   30      82    79    D     2    100      75
9 151 홍길동   Male    4      58    66    B     1     95      90
```

##### 두 열 이상을 기준으로 join
``` R
> cAge
  first.name last.name age
1      James    Bolton  34
2      James     Tiger  26
3     Goerge     Tiger  47
> cIncome
  first.name last.name income
1     Goerge     Tiger     35
2      James    Bolton     24
3      James     Tiger     18

> inner_join(cAge, cIncome, by="first.name")
  first.name last.name.x age last.name.y income
1      James      Bolton  34      Bolton     24
2      James      Bolton  34       Tiger     18
3      James       Tiger  26      Bolton     24
4      James       Tiger  26       Tiger     18
5     Goerge       Tiger  47       Tiger     35
Warning message:
In inner_join(cAge, cIncome, by = "first.name") :
  Detected an unexpected many-to-many relationship between `x` and `y`.
ℹ Row 1 of `x` matches multiple rows in `y`.
ℹ Row 2 of `y` matches multiple rows in `x`.
ℹ If a many-to-many relationship is expected, set `relationship = "many-to-many"` to
  silence this warning.

> inner_join(cAge, cIncome, by=c("last.name", "first.name"))
  first.name last.name age income
1      James    Bolton  34     24
2      James     Tiger  26     18
3     Goerge     Tiger  47     35
```

