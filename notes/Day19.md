___
### Filtering join
두 데이터 프레임의 키 값이 같은 행을 inner 또는 outer join으로 연결하는 방법이 있었다. 하지만 어떤 경우에는 한 데이터 프레임의 데이터를 다른 데이터 프레임의 정보를 사용해 필터링해야 하는 경우가 있다.
- semi_join(x, y) : x 데이터 프레임에서 y에 있는 데이터만 뽑아낸다. Inner join과 다른 점은 두 데이터 프레임의 정보를 결합하지 않는다.
- anti_join(x, y) : x 데이터 프레임에서 y에 있는 행은 제외한다.
``` R
> semi_join(x,y)
Joining with `by = join_by(id)`
  id name
1  2    b
2  3    c
> anti_join(x,y)
Joining with `by = join_by(id)`
  id name
1  1    a
```

##### merge() 
dplyr 패키지의 inner와 outer join 수행해 준다.
``` R
> merge(x,y)
  id name addr
1  2    b    B
2  3    c    C
> merge(x,y, all.x = TRUE)
  id name addr
1  1    a <NA>
2  2    b    B
3  3    c    C
> merge(x,y, all.y = TRUE)
  id name addr
1  2    b    B
2  3    c    C
3  4 <NA>    D
> merge(x,y, all = TRUE)
  id name addr
1  1    a <NA>
2  2    b    B
3  3    c    C
4  4 <NA>    D
```

##### sqldf 패키지
지금까지 dplyr의 join 함수를 이용하여 관계형 데이터베이스의 join과 유사한 데이터 결합을 어떻게 수행하는지 살펴보았다. 그런데 관계형 데이터베이스의 SQL에 익숙한 사람들은 R에서 SQL처럼 좀 더 다양한 방식으로 join을 수행할 수 없을까라는 의문을 가질 수 있다. sqldf 패키지는 SQL 문법을 이용하여 R의 데이터 프레임에서 데이터를 조회하거나 결합할 수 있도록 해 준다. 이러한 기능이 필요한 사람은 이 패키지의 문서를 참조하기 바란다. 그러나 R은 데이터 분석을 위한 도구이지 관계형 데이터베이스와 같은 일을 수행하기 위한 도구가 아님을 명심할 필요가 있다. 대량의 데이터의 결합이 필요하다면 관계형 데이터베이스에서 SQL을 이용하여 이를 먼저 수행한 후 최종 결과를 R로 보내어 분석을 수행하는 것이 일반적으로 더 효율적인 방법이다.


# tidyr 패키지를 이용하여 정돈 데이터 형식으로 바꾸기
tidyr 패키지는 tidyverse 패키지에 포함된 패키지로 비정돈 형식의 데이터를 정돈 형식으로 바꾸어주는 함수를 가지고 있다.

##### pivot_longer : 여러 열에 걸친 한 변수의 데이터를 하나의 열로 길게 모으기
정돈 데이터는 한 열이 하나의 변수에 대응을 해야 한다. 그러나 현실의 데이터에서는 동일한 변수의 값이 여러 열에 흩뿌려져 있는 경우가 발생한다. 시계열 데이터들이 대표적인 사례라 할 수 있다. 다음은 `tidyr`에 포함된 `table4a` 데이터이다.
``` R
> table4a
# A tibble: 3 × 3
  country     `1999` `2000`
  <chr>        <dbl>  <dbl>
1 Afghanistan    745   2666
2 Brazil       37737  80488
3 China       212258 213766

> ggplot(table4a, aes(country, `1999`)) + geom_col()

> table4a %>%
+   pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")
# A tibble: 6 × 3
  country     year   cases
  <chr>       <chr>  <dbl>
1 Afghanistan 1999     745
2 Afghanistan 2000    2666
3 Brazil      1999   37737
4 Brazil      2000   80488
5 China       1999  212258
6 China       2000  213766
	- `pivot_longer()`에 모아야 할 열의 이름을 지정한다. 이 예에서는 1999와 2000이다. 두 열의 이름은 숫자로 시작하고 있어서 표준적인 형태를 따르지 않아서 `` ` ` ``으로 둘러쌓여 표현되었다.
	- 원 데이터의 열 이름을 표현할 변수를 `names_to`로 지정한다.
	- 원 데이터의 열의 값을 표현할 변수를 `values_to`로 지정한다.

> table4a %>%
+   pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases") %>%
+   ggplot(aes(country, cases, fill=year)) + geom_col()
> table4a %>%
+   pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases") %>%
+   ggplot(aes(year, cases, fill=country)) + geom_col()

`pivot_longer()` 함수의 작동 방식을 보여준다. 원 데이터보다 길어진 형식으로 데이터가 변환되므로 longer라는 표현이 사용되었다.
```

##### 결측치가 있는 경우
``` R
> na_table4a <- table4a
> na_table4a$`2000`[3] <- NA
> na_table4a
# A tibble: 3 × 3
  country     `1999` `2000`
  <chr>        <dbl>  <dbl>
1 Afghanistan    745   2666
2 Brazil       37737  80488
3 China       212258     NA
> na_table4a %>%
+   pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases")
# A tibble: 6 × 3
  country     year   cases
  <chr>       <chr>  <dbl>
1 Afghanistan 1999     745
2 Afghanistan 2000    2666
3 Brazil      1999   37737
4 Brazil      2000   80488
5 China       1999  212258
6 China       2000      NA
> na_table4a %>%
+   pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases", values_drop_na = T)
# A tibble: 5 × 3
  country     year   cases
  <chr>       <chr>  <dbl>
1 Afghanistan 1999     745
2 Afghanistan 2000    2666
3 Brazil      1999   37737
4 Brazil      2000   80488
5 China       1999  212258
```

##### gather 함수
`tidyr` 패키지는 1.0 버전이 출시되면서 많은 변화가 있었다. 이전 버전의 에서는 `gather()` 함수가 `pivot_longer()` 함수의 역할을 수행하였다. 그리고 호환성을 위해 현재의 버전에서도 `gather()` 함수를 사용할 수 있다. 아직도 많은 R 관련 책에서 이 함수를 사용하고 있어서 사용법을 여기에 기술한다.
``` R
table4a %>%
  gather(`1999`, `2000`, key = "year", value ="cases")
```

##### pivot_wider : 한 열에 기술된 여러 변수의 데이터를 여러 열로 넓게 펼치키
``` R
> table2
# A tibble: 12 × 4
   country      year type            count
   <chr>       <dbl> <chr>           <dbl>
 1 Afghanistan  1999 cases             745
 2 Afghanistan  1999 population   19987071
 3 Afghanistan  2000 cases            2666
 4 Afghanistan  2000 population   20595360
 5 Brazil       1999 cases           37737
 6 Brazil       1999 population  172006362
 7 Brazil       2000 cases           80488
 8 Brazil       2000 population  174504898
 9 China        1999 cases          212258
10 China        1999 population 1272915272
11 China        2000 cases          213766
12 China        2000 population 1280428583
> table2 %>%
+   pivot_wider(names_from = type, values_from = count)
# A tibble: 6 × 4
  country      year  cases population
  <chr>       <dbl>  <dbl>      <dbl>
1 Afghanistan  1999    745   19987071
2 Afghanistan  2000   2666   20595360
3 Brazil       1999  37737  172006362
4 Brazil       2000  80488  174504898
5 China        1999 212258 1272915272
6 China        2000 213766 1280428583
> table2 %>%
+   pivot_wider(names_from = type, values_from = count) %>%
+   group_by(country) %>%
+   summarise(totol_case = sum(cases), mean_pop = mean(population))
# A tibble: 3 × 3
  country     totol_case    mean_pop
  <chr>            <dbl>       <dbl>
1 Afghanistan       3411   20291216.
2 Brazil          118225  173255630 
3 China           426024 1276671928.
> table2 %>%
+   pivot_wider(names_from = type, values_from = count) %>% 
+   mutate(cases_per_capita = cases / population)
# A tibble: 6 × 5
  country      year  cases population cases_per_capita
  <chr>       <dbl>  <dbl>      <dbl>            <dbl>
1 Afghanistan  1999    745   19987071        0.0000373
2 Afghanistan  2000   2666   20595360        0.000129 
3 Brazil       1999  37737  172006362        0.000219 
4 Brazil       2000  80488  174504898        0.000461 
5 China        1999 212258 1272915272        0.000167 
6 China        2000 213766 1280428583        0.000167 

> na_long_table4a <- na_table4a %>% 
+   pivot_longer(c(`1999`, `2000`), names_to = "year", values_to = "cases", values_drop_na = T)
> na_long_table4a
# A tibble: 5 × 3
  country     year   cases
  <chr>       <chr>  <dbl>
1 Afghanistan 1999     745
2 Afghanistan 2000    2666
3 Brazil      1999   37737
4 Brazil      2000   80488
5 China       1999  212258
> na_long_table4a %>%
+   pivot_wider(names_from = year, values_from = cases)
# A tibble: 3 × 3
  country     `1999` `2000`
  <chr>        <dbl>  <dbl>
1 Afghanistan    745   2666
2 Brazil       37737  80488
3 China       212258     NA
> na_long_table4a %>%
+   pivot_wider(names_from = year, values_from = cases, values_fill=0)
# A tibble: 3 × 3
  country     `1999` `2000`
  <chr>        <dbl>  <dbl>
1 Afghanistan    745   2666
2 Brazil       37737  80488
3 China       212258      0

```

 아래는 주요 함수와 기능을 간단히 요약한 내용입니다:

### **`spread()`**

- **역할**: 데이터를 넓은 형식으로 변환.
- **주요 인수**:
    - `key`: 새로운 열의 이름.
    - `value`: 열의 값.
- **예시**:
    
    ```r
    table2 %>%
      spread(key = type, value = count)
    ```
    

---

### **`separate()`**

- **역할**: 하나의 셀을 여러 셀로 분리.
- **주요 인수**:
    - `into`: 분리 후 생성할 열 이름.
    - `sep`: 분리 기준 문자(정규 표현식 가능).
    - `convert`: TRUE 설정 시 숫자형으로 변환.
- **예시**:
    
    ```r
    table3 %>%
      separate(rate, into = c("cases", "population"), sep = "/", convert = TRUE)
    ```
    

---

### **`unite()`**

- **역할**: 여러 셀의 데이터를 하나로 병합.
- **주요 인수**:
    - `col`: 병합 후 생성할 열 이름.
    - `sep`: 병합 시 사용할 구분자.
- **예시**:
    
    ```r
    table5 %>%
      unite(c(century, year), col = "year", sep = "")
    ```
    

---

### **`parse_number()`**

- **역할**: 문자열에서 숫자를 추출하여 숫자형으로 변환.
- **예시**:
    
    ```r
    games = mutate(games,
      audience = parse_number(audience, locale = locale(grouping_mark = ",")))
    ```
    

---

### **`parse_datetime()`**

- **역할**: 문자열 형식의 날짜 데이터를 날짜/시간 형식으로 변환.
- **예시**:
    
    ```r
    games = mutate(games,
      date = parse_datetime(date, format = "%Y/%m/%d"))
    ```
    

---

### 그래프 간격 문제 해결

- 날짜를 변환한 후에야 올바른 간격으로 그래프를 그릴 수 있음.
    
    ```r
    ggplot(games, aes(date, audience)) + geom_line()
    ```
    


___
# Chapter 10 R 프로그래밍 구조
# 조건문
##### if-else
`if (statement1) statement2 else statement3`
- statement1 : TRUE or FALSE 논리값을 결과로 주는 조건
	- TRUE : statement2 실행
	- FALSE : else statement3 실행
``` R
> x <- 4
> if(x >= 4) y <- 1 else y <- -1
> y
[1] 1
> x <- sample(1:6, size = 1)
> if(x >= 4) y <- 1 else y <- -1
> y
[1] -1
> x
[1] 3
> x <- sample(1:6, size = 1)
> y
[1] -1

> x <- sample(1:6, size = 1);if (x >= 4) {
+   y <- 1
+   cat("손님이 이겼습니다.\n")
+ } else {
+   y <- -1
+   cat("딜러가 이겼습니다.\n")
+ } ;cat("주사위 눈금:", x, "\n") ;cat("손익:",y, "\n")
손님이 이겼습니다.
주사위 눈금: 6 
손익: 1 
```

- **단순 if 조건문**: 조건이 참이면 특정 작업을 수행.
    
    ```r
    if (condition) {
      # 수행 작업
    }
    ```
    
- **if-else 조건문**: 조건이 참/거짓에 따라 작업 분기.
    
    ```r
    if (condition) {
      # 참일 때 작업
    } else {
      # 거짓일 때 작업
    }
    ```
    
- **복합 조건문**: 여러 조건을 처리.
    
    ```r
    if (cond1) {
      # 조건1 참
    } else if (cond2) {
      # 조건2 참
    } else {
      # 모든 조건 거짓
    }
    ```
    
- **중첩 조건문**: 조건문 안에 조건문을 포함.
    
    ```r
    if (cond1) {
      if (cond2) {
        # 조건1, 조건2 모두 참
      }
    }
    ```

- 여러 조건
	- 논리 연산자를 이용하여 두 개의 조건을 한 번에 표현
- AND 
	**`&` (벡터 연산)**:
	- 논리값 벡터의 **모든 요소**를 대상으로 AND 연산 수행.
	- 각 위치의 요소별로 연산.
	- 결과는 벡터로 반환.
	**`&&` (단일 요소 연산)**:
	- 논리값 벡터의 **첫 번째 요소만** 사용하여 AND 연산 수행.
	- 결과는 스칼라(단일 값)로 반환.
``` R
c(TRUE, FALSE, TRUE) & c(TRUE, TRUE, FALSE)
# 결과: c(TRUE, FALSE, FALSE)

c(TRUE, FALSE, TRUE) && c(TRUE, TRUE, FALSE)
# 결과: TRUE
```
- OR
  **| (벡터 연산)**
	- 논리값 벡터의 모든 요소를 대상으로 OR 연산 수행
	- 각 위치의 요소별로 연산
	- 결과는 벡터로 반환
  **||(단일 요소 연산)**
	- 논리값 벡터의 첫 번째 요소만 사용하여 OR 연산 수행
	- 결과는 스칼라(단일 값)로 반환
``` R
c(TRUE, FALSE, TRUE) | c(FALSE, TRUE, FALSE)
# 결과: c(TRUE, TRUE, TRUE)

c(TRUE, FALSE, TRUE) || c(FALSE, TRUE, FALSE)
# 결과: TRUE
```

#### **`if-else`와 `ifelse()` 함수의 차이 요약**

##### **1. `if-else 조건문`**

- **역할**: 프로그램의 실행 흐름을 조건에 따라 분기.
- **특징**:
    - 단일 조건을 평가.
    - 조건이 참일 때와 거짓일 때 각각 하나의 작업만 수행.
    - 조건문은 한 번만 실행.
- **예시**:
    
    ```r
    x <- -5
    if (x < 0) {
      x <- abs(x)
    } else {
      x <- x
    }
    print(x)
    # 결과: 5
    ```
    

---

##### **2. `ifelse()` 함수**

- **역할**: 논리값 벡터의 각 요소에 대해 조건을 평가하고, 결과에 따라 새 벡터를 생성.
- **특징**:
    - 벡터 요소별로 조건을 평가.
    - 각 요소에 대해 참일 때와 거짓일 때의 값을 반환.
    - 벡터화된 함수로 반복 작업에 적합.
- **예시**:
    
    ```r
    vec <- c(-5, 3, -2, 7)
    result <- ifelse(vec < 0, abs(vec), vec)
    print(result)
    # 결과: c(5, 3, 2, 7)
    ```
    

---

##### **핵심 차이**

|특징|`if-else 조건문`|`ifelse() 함수`|
|---|---|---|
|**용도**|프로그램 실행 흐름 제어|벡터 요소별로 조건에 따라 값 선택|
|**적용 대상**|단일 조건|논리값 벡터|
|**결과**|단일 작업 수행|새 벡터 생성|
|**반복 작업**|직접 반복문 필요|벡터화 함수로 자동 처리 가능|

`ifelse()`는 벡터를 다룰 때 효율적이고, `if-else`는 단일 조건으로 프로그램 제어가 필요할 때 사용됩니다.
	
### **`switch()` 함수 요약**

#### **1. `switch()` 함수 개요**

- **역할**: 조건에 따라 여러 표현식 중 하나를 실행하고 결과를 반환.
- **형식**:
    
    ```r
    switch(EXPR, expression_1, ..., expression_n)
    ```
    
    - `EXPR`: 숫자 또는 문자열로 평가되는 표현식.
    - `expression_n`: 실행할 표현식 목록.

---

#### **2. `EXPR` 값에 따른 작동**

1. **숫자 `EXPR`**:
    
    - 숫자가 1부터 n 사이면 해당 순서의 표현식을 실행.
    - 범위를 벗어나면 `NULL` 반환.
    
    ```r
    i <- 2
    switch(i, "A", "B", "C")
    # 결과: "B"
    ```
    
2. **문자열 `EXPR`**:
    
    - `EXPR` 값과 같은 이름의 표현식을 실행.
    - 일치하는 이름이 없으면 기본 표현식(`expression_default`)을 실행.
    
    ```r
    fruit <- "b"
    switch(fruit, 
           b = "Banana", 
           o = "Orange", 
           "Unknown")
    # 결과: "Banana"
    ```
    

---

#### **3. 예시**

1. **숫자 기반 선택**:
    
    ```r
    i <- 3
    switch(i, 10, 1:5, pi)
    # 결과: 3.141593
    ```
    
2. **문자열 기반 메뉴 선택**:
    
    ```r
    menu <- c("(b)anana", "(o)range", "(s)trawberry")
    repeat {
      cat("\n메뉴를 골라주세요:", paste(1:3, menu, sep="."), "\n")
      choice <- readline("선택 [b|o|s] 또는 종료 [q]: ")
      switch(choice,
             b = {cat("바나나 선택\n"); price <- 1000},
             o = {cat("오렌지 선택\n"); price <- 1200},
             s = {cat("딸기 선택\n"); price <- 1500},
             q = break,
             cat("잘못된 선택\n"))
      cat("가격:", price, "원\n")
    }
    ```
    

---

#### **4. `switch()`의 특징**

- **숫자 `EXPR`**: 순서대로 실행.
- **문자열 `EXPR`**: 이름이 일치하는 표현식 실행.
- **기본값 처리**: 이름이 없는 마지막 표현식으로 기본값 처리 가능.

`switch()`는 조건이 많은 경우 `if-else`보다 간결하게 코드 작성이 가능합니다.

# **반복문**

- **for 반복문**: 지정된 범위에서 반복.
    
    ```r
    for (var in sequence) {
      # 반복 작업
    }
    ```
    
- **while 반복문**: 조건이 참인 동안 반복.
    
    ```r
    while (condition) {
      # 반복 작업
    }
    ```
    
- **repeat 반복문**: 무한 반복, `break`로 종료.
    
    ```r
    repeat {
      if (condition) break
    }
    ```
    
- **break & next**:
    - `break`: 반복문 종료.
    - `next`: 현재 반복을 건너뛰고 다음 반복 수행.

# **함수**

- **함수 정의와 호출**:
    
    ```r
    func_name <- function(arg1, arg2 = default_value) {
      # 함수 본문
      return(result) # Optional
    }
    func_name(value1, value2)
    ```
    
- **가변 인수**: `...`로 전달.
    
    ```r
    func_name <- function(..., arg) {
      # ... 인수를 처리
    }
    ```
    
- **무기명 함수**:
    
    ```r
    sapply(list, function(x) x^2)
    ```
    
- **벡터화 함수**: 벡터 전체에 작업 수행.
    
    ```r
    g <- function(x) x * 2
    g(1:3)  # 결과: c(2, 4, 6)
    ```
    

# **반복 대신 벡터화된 함수 활용**

- **R은 벡터화 함수나 `apply` 계열 함수 권장**:
    - 벡터화 함수: `sum()`, `mean()`, `ifelse()` 등.
    - `apply()`, `lapply()`, `sapply()`로 리스트/행렬 작업 최적화.

# **변수 범위**

- **지역 변수와 전역 변수**:
    - 함수 내 지역 변수는 함수 호출 시 생성, 종료 시 제거.
    - 함수 외부 전역 변수는 함수 내부에서 참조 가능하나 기본적으로 변경 불가.
    - **수퍼 할당 연산자** `<<-`로 전역 변수 변경 가능.

# **R 함수 환경**

- 함수 내 자유 변수는 함수가 정의된 환경에서 값 검색.
- 함수 내부 정의 함수는 바깥 함수의 환경을 상속받음.
- 환경 탐색 순서:
    1. 함수 내부 → 2. 함수 정의 환경 → 3. 전역 환경 → 4. 검색 경로.

이 요약을 통해 R의 조건문, 반복문, 함수의 핵심 개념을 빠르게 이해할 수 있습니다. 추가적으로 필요한 내용은 말씀해주세요!