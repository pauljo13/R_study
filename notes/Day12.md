___
# 6.2 데이터 프레임 만들기
### data.frame()
data.frame() 함수를 이용하여 벡터, 행렬, 요인, 심지어 다른 데이터 프레임을 묶어서 새로운 데이터 프레임을 만들 수 있다. 이 때 다음과 같은 제한 조건이 있다.
1. 벡터는 모두 같은 길이를 가져야 하며 행렬과 데이터 프레임은 모두 같은 행 수를 가져야 한다.
2. 벡터는 하나의 벡터가 데이터 프레임의 하나의 열이 되지만, 행렬, 데이터 프레임은 각 열이 데이터 프레임의 하나의 열이 된다.
``` R
> name <- c("Kim", "Lee", "Hung", "Joe", "Kaung")
> grade <- c(1, 4, 3, 2,1)
> gender <- c("M", "F", "M", "F", "M")
> student <- data.frame(name, grade, gender)
> student
   name grade gender
1   Kim     1      M
2   Lee     4      F
3  Hung     3      M
4   Joe     2      F
5 Kaung     1      M


> mindterm = c(74, 82, 67, 89,92)
> final = c(91, 77, 88, 78, 86)
> scores = cbind(mindterm, final); scores
     mindterm final
[1,]       74    91
[2,]       82    77
[3,]       67    88
[4,]       89    78
[5,]       92    86
> rf <- c(TRUE, FALSE, FALSE, TRUE, FALSE)
> students <- data.frame(student, scores, retake = rt)
> students
   name grade gender mindterm final retake
1   Kim     1      M       74    91   TRUE
2   Lee     4      F       82    77  FALSE
3  Hung     3      M       67    88  FALSE
4   Joe     2      F       89    78   TRUE
5 Kaung     1      M       92    86  FALSE
```

##### cbind()
새로운 열을 추가할 때 사용을 한다.
``` R
> total.scores <- mindterm + final ; total.scores
[1] 165 159 155 167 178
> cbind(students, total.scores)
   name grade gender mindterm final retake total.scores
1   Kim     1      M       74    91   TRUE          165
2   Lee     4      F       82    77  FALSE          159
3  Hung     3      M       67    88  FALSE          155
4   Joe     2      F       89    78   TRUE          167
5 Kaung     1      M       92    86  FALSE          178
```
##### rbind()
데이터 프레임에 새로운 데이터 행을 추가하고 싶을 때 사용한다,
```R
> a <- data.frame(name="Jane Eyre", grade=4, gender="F",
+                 mindterm=90, final=85, retake=F); a
       name grade gender mindterm final retake
1 Jane Eyre     4      F       90    85  FALSE
> rbind(students, a)
       name grade gender mindterm final retake
1       Kim     1      M       74    91   TRUE
2       Lee     4      F       82    77  FALSE
3      Hung     3      M       67    88  FALSE
4       Joe     2      F       89    78   TRUE
5     Kaung     1      M       92    86  FALSE
6 Jane Eyre     4      F       90    85  FALSE
```


___
# 6.3  데이터 프레임 각 열의 지정
##### 데이터 프레임은 리스트 타입
생성된 데이터 프레임에 대해 typeof() 함수와 attributes() 함수를 이용하여 타입과 속성을 알아보자. 다음 결과에서 데이터 프레임은 리스트 타입이며, names 속성에 데이터 프레임의 각 열의 이름이 나열되어 있음을 볼 수 있다.
``` R
> typeof(students)
[1] "list"
> attributes(students)
$names
[1] "name"     "grade"    "gender"   "mindterm" "final"    "retake"  

$class
[1] "data.frame"

$row.names
[1] 1 2 3 4 5
```

##### 리스트 형식으로 데이터 프레임의 열 지정
리스트의 각 요소를 지정할 때와 마찬가지로, `$` 기호 또는 `[[ ]]`를 이용하여 다음과 같은 형태로 지정하면 된다.
``` R
data_frame_name$column_name
data_frame_name[[column_number]]
data_frame_name[[column_name]]


> students$gender
[1] "M" "F" "M" "F" "M"
> students[["mindterm"]]
[1] 74 82 67 89 92
> students$mindterm[5] <- 50
> students[[4]][3:5]
[1] 67 89 50
> students$hw <- c(8, 9, 7, 8, 10); students
   name grade gender mindterm final retake hw
1   Kim     1      M       74    91   TRUE  8
2   Lee     4      F       82    77  FALSE  9
3  Hung     3      M       67    88  FALSE  7
4   Joe     2      F       89    78   TRUE  8
5 Kaung     1      M       50    86  FALSE 10
```


___
# 6.4 데이터 프레임의 필터링
데이터를 분석하다 보면 작업 중인 데이터 프레임의 일부만을 선택하여 작업을 할필요가 있다. 어떤 경우에는 데이터의 일부분만 변경할 필요가 있다. 필요 없는 열을 제거하거나 새로운 열을 추가하기 위해서는 여러 열을 한번에 지정할 수도 있어야 한다.

### 리스트 형식으로 필터링
데이터 프레임은 리스트 구조를 가지고 있으며, 데이터 프레임의 열은 리스트의 각 요소가 된다. 리스트의 부분 필터링을 수행하는 방법으로 데이터 프레임의 일부 열만 필터링을 수행할 수 있다.

##### 리스트로서 필터링은 1차원 인덱스 구조를 갖는다.
리스트로서 데이터 프레임을 필터링하는 방법은 아래와 같이 인덱스 벡터를 이용하는 것이다. 여기서 인덱스 벡터는 벡터나 리스트의 인덱스 벡터와 만찬가지로 숫자, 이름, 논리값 벡터가 될 수 있다.
`date_frame_name[index_vector]`
``` R
> students.new <- students[1:2]
> students.new
   name grade
1   Kim     1
2   Lee     4
3  Hung     3
4   Joe     2
5 Kaung     1
> students.new <- students[-(1:2)]
> students.new
  gender mindterm final retake hw
1      M       74    91   TRUE  8
2      F       82    77  FALSE  9
3      M       67    88  FALSE  7
4      F       89    78   TRUE  8
5      M       50    86  FALSE 10
> student.new <- students[c("gender", "grade")]
> student.new
  gender grade
1      M     1
2      F     4
3      M     3
4      F     2
5      M     1
> student.new <- students[c(T, F, F, T, T, F)]
> student.new
   name mindterm final hw
1   Kim       74    91  8
2   Lee       82    77  9
3  Hung       67    88  7
4   Joe       89    78  8
5 Kaung       50    86 10
> height <- c(172, 167, 181, 162, 178)
> students.new <- data.frame(students[2:3], height=height)
> students.new
  grade gender height
1     1      M    172
2     4      F    167
3     3      M    181
4     2      F    162
5     1      M    178
```

##### 열 지정하기 vs, 한 열만 데이터 프레임으로 필터링
앞서 설명하였듯이 데이터 프레임은 리스트이므로 데이터 프레임의 한 열만을 지정할 때 [ ] 뿐 아니라 [[]]와 $를 이용해 한 열을 지정할 수 있다. 두 방식의 차이는 전자가 데이터 프레임에서 지정된 열만으로 이루어진 새로운 데이터 프레임을 반환하는 반면, 후자는 데이터 프레임에 있는 열 자체, 즉 벡터를 반환한다.
``` R
> a <- student[2]; a
  grade
1     1
2     4
3     3
4     2
5     1
> typeof(a)
[1] "list"
> attributes(a)
$names
[1] "grade"

$row.names
[1] 1 2 3 4 5

$class
[1] "data.frame"

> a <- students[[2]]; a
[1] 1 4 3 2 1
> typeof(a)
[1] "double"
> attributes(a)
NULL
```

##### 행렬로서 필터링은 2차원 인덱스 구조를 갖는다.
`data_frame_name[row_index_vector, column_index_vector]`
``` R
> students[1,]
  name grade gender mindterm final retake hw
1  Kim     1      M       74    91   TRUE  8
> students[2:3, ]
  name grade gender mindterm final retake hw
2  Lee     4      F       82    77  FALSE  9
3 Hung     3      M       67    88  FALSE  7
> students[-(2:3), ]
   name grade gender mindterm final retake hw
1   Kim     1      M       74    91   TRUE  8
4   Joe     2      F       89    78   TRUE  8
5 Kaung     1      M       50    86  FALSE 10
> students[ ,4]
[1] 74 82 67 89 50
> students[ ,-4]
   name grade gender final retake hw
1   Kim     1      M    91   TRUE  8
2   Lee     4      F    77  FALSE  9
3  Hung     3      M    88  FALSE  7
4   Joe     2      F    78   TRUE  8
5 Kaung     1      M    86  FALSE 10
> students[ ,c(2, 4)]
  grade mindterm
1     1       74
2     4       82
3     3       67
4     2       89
5     1       50
> students[2:4, 3:5]
  gender mindterm final
2      F       82    77
3      M       67    88
4      F       89    78
> students$mindterm >= 80
[1] FALSE  TRUE FALSE  TRUE FALSE
> students[students$mindterm >= 80, ]
  name grade gender mindterm final retake hw
2  Lee     4      F       82    77  FALSE  9
4  Joe     2      F       89    78   TRUE  8
> students[students$mindterm >= 80, c("name", "grade", "gender")]
  name grade gender
2  Lee     4      F
4  Joe     2      F
> students[students$grade != 1, c("name", "grade", "gender")]
  name grade gender
2  Lee     4      F
3 Hung     3      M
4  Joe     2      F
```

##### 행렬 필터링 방법을 이용한 데이터 프레임 정렬
행렬과 마찬가지로 데이터 프레임을 특정 열을 기준으로 정렬할 수 있다.
``` R
> order(students$grade)
[1] 1 5 4 3 2
> students[order(students$grade), ]
   name grade gender mindterm final retake hw
1   Kim     1      M       74    91   TRUE  8
5 Kaung     1      M       50    86  FALSE 10
4   Joe     2      F       89    78   TRUE  8
3  Hung     3      M       67    88  FALSE  7
2   Lee     4      F       82    77  FALSE  9
> order(students$final, decreasing = TRUE)
[1] 1 3 5 4 2
> students[order(students$final, decreasing = TRUE), ]
   name grade gender mindterm final retake hw
1   Kim     1      M       74    91   TRUE  8
3  Hung     3      M       67    88  FALSE  7
5 Kaung     1      M       50    86  FALSE 10
4   Joe     2      F       89    78   TRUE  8
2   Lee     4      F       82    77  FALSE  9
```
order() 함수는 길이가 같은 여러 개의 벡터를 차례대로 비교하여 순위를 결정할 수 있다. 
- 첫 번째 인수 : 나열된 벡터 기준으로 순서를 결정
- 두 번째 인수 : 첫 번째 인수 중 동률인 인수들의 순서를 결정
``` R
> order(students$grade, students$final)
[1] 5 1 4 3 2
> students[order(students$grade, students$final), ]
   name grade gender mindterm final retake hw
5 Kaung     1      M       50    86  FALSE 10
1   Kim     1      M       74    91   TRUE  8
4   Joe     2      F       89    78   TRUE  8
3  Hung     3      M       67    88  FALSE  7
2   Lee     4      F       82    77  FALSE  9
```
order() 함수의 decreasing 인수 : TRUE로 낮은 순으로 변경됨
``` R
> students[order(students$grade, students$final, decreasing=T), ]
   name grade gender mindterm final retake hw
2   Lee     4      F       82    77  FALSE  9
3  Hung     3      M       67    88  FALSE  7
4   Joe     2      F       89    78   TRUE  8
1   Kim     1      M       74    91   TRUE  8
5 Kaung     1      M       50    86  FALSE 10

> students[order(students$grade, -students$final), ]
   name grade gender mindterm final retake hw
1   Kim     1      M       74    91   TRUE  8
5 Kaung     1      M       50    86  FALSE 10
4   Joe     2      F       89    78   TRUE  8
3  Hung     3      M       67    88  FALSE  7
2   Lee     4      F       82    77  FALSE  9
```

### subset() 이용한 필터링
subset() 함수는 벡터, 행렬, 데이터 프레임에서 조건에 맞는 부분을 반환하는 함수이다.
`subset(x, subset, select, drop=FALSE, ...)`
- subset() 함수와 기존의 벡터 필터링의 차이점
	**subset() 함수와 인덱스 벡터의 비교:**
	1. **행 필터링 조건**
	    - `subset()` 함수: `subset` 인수에 논리값으로 조건 작성.
	    - 인덱스 벡터: 자연수, 음의 정수, 논리값, 문자열 등 다양한 방식 가능.
	2. **NA 처리**
	    - `subset()` 함수: 조건식 결과가 `NA`인 경우 `FALSE`로 간주하여 해당 행 자동 제거.
	    - 인덱스 벡터: 조건식 결과가 `NA`여도 해당 행 제거되지 않음.
	3. **열 필터링 방법**
	    - `subset()` 함수: `select` 인수에 열 이름을 변수처럼 기술 (따옴표 없이 사용 가능).
	    - 인덱스 벡터: 열 번호나 이름을 지정 (열 이름은 반드시 문자열로 표시).
	4. **작성 간편성**
	    - `subset()` 함수: 변수 이름을 직접 기술 가능하여 간편함.
	    - 인덱스 벡터: 열 이름, 번호 등 구체적으로 지정해야 하므로 상대적으로 복잡.
	5. **결과 처리 방식**
	    - `subset()` 함수: 조건과 선택이 변수처럼 처리되어 간단하고 직관적임.
	    - 인덱스 벡터: 열과 행을 번호, 논리값, 이름으로 세밀히 조정 가능하지만 코드가 길어질 수 있음.
``` R
> x <- c(7, 9, NA, 5, 2)
> x[x>6]
[1]  7  9 NA
> subset(x, x>6)
[1] 7 9
> y <- 1:5
> z <- -1 : -5
> long.name <- data.frame(x, y, z); long.name
   x y  z
1  7 1 -1
2  9 2 -2
3 NA 3 -3
4  5 4 -4
5  2 5 -5
> rm(x, y, z)
> long.name[long.name$x > 6, ]
    x  y  z
1   7  1 -1
2   9  2 -2
NA NA NA NA
> subset(long.name, x>6)
  x y  z
1 7 1 -1
2 9 2 -2
> long.name[long.name$x >6, 2:3]
    y  z
1   1 -1
2   2 -2
NA NA NA
> subset(long.name, x>6, y:z)
  y  z
1 1 -1
2 2 -2
> long.name[long.name$x >6, c("x", "z")]
    x  z
1   7 -1
2   9 -2
NA NA NA
> subset(long.name, x>6, c(x, z))
  x  z
1 7 -1
2 9 -2
> subset(long.name, x>6, -z)
  x y
1 7 1
2 9 2
```
