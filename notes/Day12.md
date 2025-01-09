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
st
```