___
# 6.5 데이터 프레임에 함수 적용
#### 리스트로서 각 열에 함수 적용
데이터 프레임은 리스트로서의 속성이 있기 때문에 lapply()나 sapply() 함수를 이용하여 열별로 함수를 적용할 수 있다.
``` R
# List function
> lapply(students[4:5], mean)
$midterm
[1] 80.8

$final
[1] 84

> sapply(students[4:5], mean)
midterm   final 
   80.8    84.0 
> sapply(students[4:5], summary)
        midterm final
Min.       67.0    77
1st Qu.    74.0    78
Median     82.0    86
Mean       80.8    84
3rd Qu.    89.0    88
Max.       92.0    91

# Matrix function
> nrow(students)
[1] 5
> ncol(students)
[1] 6
> t(students)
        [,1]   [,2]    [,3]    [,4]   [,5]   
name    "kim"  "young" "lee"   "joe"  "kung" 
grade   "1"    "4"     "3"     "2"    "1"    
gender  " M"   "F"     "M"     "F"    "M"    
midterm "74"   "82"    "67"    "89"   "92"   
final   "91"   "77"    "88"    "78"   "86"   
retake  "TRUE" "FALSE" "FALSE" "TRUE" "FALSE"

```

##### apply() 행이나 열에 함수 적용
데이터 프레임에도 apply() 함수를 적용할 수 있다. 그러나 여기서 주의할 점은 R은 apply() 함수를 적용하기 앞서 데이터 프레임을 행렬로 변환시킨다. 따라서 앞에 t() 함수의 적용 결과처럼 요소 중에 하나라도 문자가 있으면 모든 요소를 수용할 수 있는 문자 행렬로 변환하게 된다.
``` R
> apply(students, 2, mean)
   name   grade  gender midterm   final  retake      hw 
     NA      NA      NA      NA      NA      NA      NA 

> apply(students[4:5], 2, mean)
midterm   final 
   80.8    84.0 
> apply(students[4:5], 1, sum)
[1] 165 159 155 167 178
```

##### 긴 데이터 프레임의 앞 또는 뒷 부분 출력하기
``` R
> nrow(iris)
[1] 150
> head(iris)
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
1          5.1         3.5          1.4         0.2  setosa
2          4.9         3.0          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa
4          4.6         3.1          1.5         0.2  setosa
5          5.0         3.6          1.4         0.2  setosa
6          5.4         3.9          1.7         0.4  setosa
> tail(iris)
    Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
145          6.7         3.3          5.7         2.5 virginica
146          6.7         3.0          5.2         2.3 virginica
147          6.3         2.5          5.0         1.9 virginica
148          6.5         3.0          5.2         2.0 virginica
149          6.2         3.4          5.4         2.3 virginica
150          5.9         3.0          5.1         1.8 virginica
> head(iris,n = 3)
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
1          5.1         3.5          1.4         0.2  setosa
2          4.9         3.0          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa
> tail(iris,n = 3)
    Sepal.Length Sepal.Width Petal.Length Petal.Width   Species
148          6.5         3.0          5.2         2.0 virginica
149          6.2         3.4          5.4         2.3 virginica
150          5.9         3.0          5.1         1.8 virginica
```

# 6.6 파일에서 데이터 읽어오기
규모가 큰 데이터는 R 콘솔에서 직접 입력하기보다는 파일에서 불러오는 경우가 많다. R에서는 주로 텍스트 파일이나 Excel의 데이터를 읽어오는 경우가 많다.

#### 작업 디렉토리 설정
R 윈도우 버전에서 작업 디렉토리의 변경은 [파일]-[작업디렉토리변경] 메뉴를 이용하면 된다. 
RStudio에서는 [Session]-[Set Working Directory]-[Choose Directory] 메뉴를 이용하면 된다. 
현재의 작업 디렉터리가 어디인지를 알기 위해서는 getwd() 명령을 이용하면 된다. 현재 작업 디렉터리의 파일을 보고 싶으면 list.files() 명령을 이용한다.

R에서 현재 작업 디렉토리를 변경하려면 `setwd()` 함수를 사용하면 됩니다. 아래는 작업 디렉토리를 변경하는 다양한 방법과 확인 방법입니다.

---

### 작업 디렉토리 변경

1. **`setwd()` 함수 사용**
    
    ```R
    # 변경하고자 하는 디렉토리 경로 지정
    setwd("/Users/your_username/Desktop")
    
    # 변경된 작업 디렉토리 확인
    getwd()  # 출력: "/Users/your_username/Desktop"
    ```
    
2. **현재 디렉토리를 기준으로 하위 디렉토리로 이동**
    
    ```R
    # 현재 작업 디렉토리 확인
    current_dir <- getwd()
    print(current_dir)
    
    # 하위 디렉토리로 이동 (예: "data")
    setwd(file.path(current_dir, "data"))
    getwd()  # 출력: "/current_dir_path/data"
    ```
    
3. **상위 디렉토리로 이동**
    
    ```R
    setwd("..")  # 한 단계 상위 디렉토리로 이동
    getwd()      # 출력: 상위 디렉토리 경로
    ```
    
4. **홈 디렉토리로 이동**
    
    ```R
    setwd("~")  # 사용자의 홈 디렉토리로 이동
    getwd()     # 출력: "/Users/your_username" 또는 유사한 홈 경로
    ```
    

---

### 작업 디렉토리 변경 확인

1. **현재 작업 디렉토리 확인**
    
    ```R
    getwd()  # 현재 작업 디렉토리 반환
    ```
    
2. **디렉토리 내 파일 및 폴더 목록 확인**
    
    ```R
    list.files()  # 현재 디렉토리에 있는 파일과 폴더 목록 반환
    ```
    

---

### 변경 후 원래 디렉토리로 돌아가기

작업 디렉토리를 변경한 후 원래 디렉토리로 돌아가고 싶다면, 변경 전 디렉토리를 저장해 두세요.

```R
# 현재 작업 디렉토리 저장
original_dir <- getwd()

# 작업 디렉토리 변경
setwd("/path/to/new/directory")

# 원래 디렉토리로 돌아가기
setwd(original_dir)
```

---

### 유용한 팁

- **경로 자동 완성**: RStudio를 사용하는 경우 `setwd()` 안에 경로를 입력할 때 `Tab` 키로 경로를 자동 완성할 수 있습니다.
- **파일 경로 복사**: 파일 탐색기에서 파일이나 폴더 경로를 복사해 넣으면 경로 입력이 더 쉬워집니다.

``` R
# 변경하고자 하는 디렉토리 경로 지정
setwd("/Users/knu_cgl1/Desktop/Study/Obsidian/R_study/scripts/courses2")

# 변경된 작업 디렉토리 확인
WD <- getwd(); WD
# setwd(file.path(WD, "data"))
list.files(pattern = "txt")
prov.scores <- read.table("scores.txt", header = TRUE, fileEncoding = "UTF-8")
prov.scores
attributes(prov.scores)

prov.scores <- read.table(files_list[2], header = FALSE, fileEncoding = "UTF-8")
prov.scores
```

##### edit()
데이터 프레임에서 데이터를 편집하고 싶으면 edit() 함수를 이용한다. 다음 명령을 수행하면 데이터 프레임이 스프레이드시트 형태로 나타나 수정이 가능하다. 편집창에서 수정 후 편집창을 닫으면 변경한 내용이 반영되어 새로운 데이터 프레임 prov.scores.new가 생성된다.
``` R
prov.scores.new <- edit(prov.scores)
```


### CSV 파일에서 데이터 읽어오기
#### CSV 파일
많은 경우 데이터가 Excel로 저장되어 있다. Excel에서 데이터를 읽어오기 위해서는 먼저 Excel 파일을 CSV 형태의 파일로 작업 디렉토리에 저장하여야 한다.CSV 파일은 데이터의 각 필드가 쉼표로 분리되어 있는 파일이다. 대부분의 통계 패키지뿐 아니라 다수의 SW에서 지원하는 파일 형식이다. Excel의 버전에 따라 저장방식이 조금 차이가 있을 수 있으나, 대부분 ’다른 이름으로 저장’에서 파일 형식을 CSV 형식으로 지정해 주면 된다.
``` R
> sr <- read.csv(file = "suicide_rates.csv", fileEncoding = "UTF-8")
> nrow(sr)
[1] 105
> head(sr)
              Country Year Males Females
1             ALBANIA    3   4.7     3.3
2 ANTIGUA AND BARBUDA   95   0.0     0.0
3           ARGENTINA    8  12.6     3.0
4             ARMENIA    8   2.8     1.1
5           AUSTRALIA    6  12.8     3.6
6             AUSTRIA    9  23.8     7.1
> sr2 <- read.table(file = "suicide_rates.csv",header = TRUE, sep=",", fileEncoding = "UTF-8")
> nrow(sr2)
[1] 105
> head(sr2)
              Country Year Males Females
1             ALBANIA    3   4.7     3.3
2 ANTIGUA AND BARBUDA   95   0.0     0.0
3           ARGENTINA    8  12.6     3.0
4             ARMENIA    8   2.8     1.1
5           AUSTRALIA    6  12.8     3.6
6             AUSTRIA    9  23.8     7.1
```

##### read.csv()와 관련된 흔한 실수
read.csv() 함수를 이용할 때 초보자가 가장 자주 하는 실수가 일반 텍스트 파일인데 read.csv() 함수로 데이터를 읽어들이는 것이다.
``` R
> prov.scores <- read.table("scores.txt", header=TRUE, fileEncoding="UTF-8")
> prov.scores
  prov scores
1 서울     25
2 대전     35
3 천안     42
> prov.scores.csv <- read.csv("scores.txt", fileEncoding="UTF-8")
> prov.scores.csv
  prov..scores
1     서울  25
2     대전  35
3     천안  42
> mean(prov.scores$scores)
[1] 34
> mean(prov.scores.csv$scores)
[1] NA
Warning message:
In mean.default(prov.scores.csv$scores) :
  argument is not numeric or logical: returning NA
> ncol(prov.scores)
[1] 2
> names(prov.scores)
[1] "prov"   "scores"
> ncol(prov.scores.csv)
[1] 1
> names(prov.scores.csv)
[1] "prov..scores"
```


# 데이터 프레임을 파일로 쓰기
##### write.table() & write.csv()
데이터 프레임의 작업 결과를 추후에 다시 이용하기 위해서, 또는 다른 통계 패키지에서 작업 결과를 이용하기 위해서는 데이터 프레임을 파일로 지정할 수 있어야 한다.
``` R
write.table(students, "students.txt", row.names = FALSE, fileEncoding = "UTF-8")
write.csv(students, "students.csv", row.names = FALSE, fileEncoding = "UTF-8")
write.csv(students, "students_rn.csv", row.names = TRUE, fileEncoding = "UTF-8")

> read.table("students.txt", header=TRUE, fileEncoding="UTF-8")
   name grade gender midterm final retake hw
1   kim     1      M      74    91   TRUE  8
2 young     4      F      82    77  FALSE  9
3   lee     3      M      67    88  FALSE  7
4   joe     2      F      89    78   TRUE  8
5  kung     1      M      92    86  FALSE 10
> read.csv("students.csv", header=TRUE, fileEncoding="UTF-8")
   name grade gender midterm final retake hw
1   kim     1      M      74    91   TRUE  8
2 young     4      F      82    77  FALSE  9
3   lee     3      M      67    88  FALSE  7
4   joe     2      F      89    78   TRUE  8
5  kung     1      M      92    86  FALSE 10
> write.table(students, "students.csv", sep=",", row.names=FALSE, fileEncoding="UTF-8")
> write.table(students, "students_rn.csv", sep=",", row.names=TRUE, fileEncoding="UTF-8")
```


##### 바이너리 형식으로 데이터 객체 저장 및 복원
데이터 프레임뿐 아니라 R의 모든 객체들을 `saveRDS()`와 `readRDS()`, 또는 `save()`와 `load()` 함수를 이용하여 바이너리 형식으로 저장하고 복원할 수 있다. 이 경우 메모리에 적재되는 형태대로 파일에 저장되었다가 복원되므로 별도의 처리 과정이 불필요해진다. 그러므로 대용량의 데이터를 R 플랫폼 내에서 저장하거나 복원할 때 매우 유용하다.
``` R
> x <- 1:3; x
[1] 1 2 3
> y <- matrix(4:12, nrow = 3, ncol = 3); y
     [,1] [,2] [,3]
[1,]    4    7   10
[2,]    5    8   11
[3,]    6    9   12
> z <- data.frame(x,y); z
  x X1 X2 X3
1 1  4  7 10
2 2  5  8 11
3 3  6  9 12
> save(x, y, z, file = "xyz.RData")
> rm(x, y, z)
> x; y; z
Error: object 'x' not found
> load("xyz.RData")
> x; y; z
[1] 1 2 3
     [,1] [,2] [,3]
[1,]    4    7   10
[2,]    5    8   11
[3,]    6    9   12
  x X1 X2 X3
1 1  4  7 10
2 2  5  8 11
3 3  6  9 12
```


# 6.8 데이터 프레임의 열을 변수처럼 이용
#### 변수 검색 경로
`$` 기호를 이용하는 방법보다 좀 더 간편하게 데이터 프레임의 열에 접근할 수 있는 방법이 있다. attach() 함수를 이용하면 데이터 프레임의 각 열을 변수로 등록할 수 있다. attach() 함수가 실행되면 해당 데이터 프레임의 각 열을 변수로 검색 경로(search path)에 등록한다. 검색 경로란 R이 어떤 변수를 참조할 때 변수에 대한 정보를 검색하는 경로를 의미한다. 현재의 검색 경로를 파악하기 위해서는 search() 함수를 이용하면 된다.
``` R
> search()
 [1] ".GlobalEnv"                   "package:SummarizedExperiment"
 [3] "package:Biobase"              "package:GenomicRanges"       
 [5] "package:GenomeInfoDb"         "package:IRanges"             
 [7] "package:MatrixGenerics"       "package:matrixStats"         
 [9] "package:limma"                "package:S4Vectors"           
[11] "package:BiocGenerics"         "package:stats4"              
[13] "tools:rstudio"                "package:stats"               
[15] "package:graphics"             "package:grDevices"           
[17] "package:utils"                "package:datasets"            
[19] "package:methods"              "Autoloads"                   
[21] "package:base" 
```

##### attach()로 데이터 프레임을 검색 경로에 등록하기
``` R
> search()
 [1] ".GlobalEnv"                   "package:SummarizedExperiment"
 [3] "package:Biobase"              "package:GenomicRanges"       
 [5] "package:GenomeInfoDb"         "package:IRanges"             
 [7] "package:MatrixGenerics"       "package:matrixStats"         
 [9] "package:limma"                "package:S4Vectors"           
[11] "package:BiocGenerics"         "package:stats4"              
[13] "tools:rstudio"                "package:stats"               
[15] "package:graphics"             "package:grDevices"           
[17] "package:utils"                "package:datasets"            
[19] "package:methods"              "Autoloads"                   
[21] "package:base"                
> obj <- ls()
> rm(list = obj[which(obj ~= "students")])
Error: unexpected '=' in "rm(list = obj[which(obj ~="
> ls()
 [1] "ckap4_expr"      "ckap4_group"     "ckap4_id"        "clinical"        "cont.matrix"    
 [6] "cts"             "deg_results"     "design"          "ex"              "expr_data"      
[11] "files_list"      "final"           "fit"             "fit2"            "gbm_data"       
[16] "gender"          "gene_metadata"   "grade"           "groups"          "gs"             
[21] "gset"            "gsms"            "idx"             "LogC"            "median_value"   
[26] "midterm"         "name"            "obj"             "prov.scores"     "prov.scores.csv"
[31] "query_gbm"       "qx"              "rt"              "scores"          "sel"            
[36] "sml"             "sr"              "sr2"             "student"         "students"       
[41] "WD"              "x"               "y"               "z"              
> rm(obj)
> ls()
 [1] "ckap4_expr"      "ckap4_group"     "ckap4_id"        "clinical"        "cont.matrix"    
 [6] "cts"             "deg_results"     "design"          "ex"              "expr_data"      
[11] "files_list"      "final"           "fit"             "fit2"            "gbm_data"       
[16] "gender"          "gene_metadata"   "grade"           "groups"          "gs"             
[21] "gset"            "gsms"            "idx"             "LogC"            "median_value"   
[26] "midterm"         "name"            "prov.scores"     "prov.scores.csv" "query_gbm"      
[31] "qx"              "rt"              "scores"          "sel"             "sml"            
[36] "sr"              "sr2"             "student"         "students"        "WD"             
[41] "x"               "y"               "z"              
> retake
Error: object 'retake' not found
> attach(students)
The following objects are masked _by_ .GlobalEnv:

    final, gender, grade, midterm, name

> retake
[1]  TRUE FALSE FALSE  TRUE FALSE
> search()
 [1] ".GlobalEnv"                   "students"                    
 [3] "package:SummarizedExperiment" "package:Biobase"             
 [5] "package:GenomicRanges"        "package:GenomeInfoDb"        
 [7] "package:IRanges"              "package:MatrixGenerics"      
 [9] "package:matrixStats"          "package:limma"               
[11] "package:S4Vectors"            "package:BiocGenerics"        
[13] "package:stats4"               "tools:rstudio"               
[15] "package:stats"                "package:graphics"            
[17] "package:grDevices"            "package:utils"               
[19] "package:datasets"             "package:methods"             
[21] "Autoloads"                    "package:base"    

```

##### attach()로 등록된 변수는 데이터 프레임과 독립적인 복사본이다.
``` R
> retake[1] <- NA; retake
[1]    NA FALSE FALSE  TRUE FALSE
> students$retake
[1]  TRUE FALSE FALSE  TRUE FALSE
> students$retake[5] <- NA
> students$retake
[1]  TRUE FALSE FALSE  TRUE    NA
> retake
[1]    NA FALSE FALSE  TRUE FALSE
```

##### detach()
데이터 프레임을 검색 경로에서 제거할 수 있다.
``` R
> detach(students)
> search()
 [1] ".GlobalEnv"                   "package:SummarizedExperiment"
 [3] "package:Biobase"              "package:GenomicRanges"       
 [5] "package:GenomeInfoDb"         "package:IRanges"             
 [7] "package:MatrixGenerics"       "package:matrixStats"         
 [9] "package:limma"                "package:S4Vectors"           
[11] "package:BiocGenerics"         "package:stats4"              
[13] "tools:rstudio"                "package:stats"               
[15] "package:graphics"             "package:grDevices"           
[17] "package:utils"                "package:datasets"            
[19] "package:methods"              "Autoloads"                   
[21] "package:base" 
```


___
# Chapter 7 dplyr을 이용한 데이터 변환
데이터를 분석하려면 데이터를 분석에 적절한 형식으로 변환하는 전처리가 필요하다. 또한 기본적인 분석을 위해서도 데이터를 요약하는 작업이 필요하다.

# 7.1 tidy data
### 정돈 데이터 (Tidy Data)
- **정돈 데이터의 조건**
    1. 각 행은 **관측 대상**(observation)을 나타냄.
    2. 각 열은 **변수**(variable)를 나타냄.
    3. 각 셀은 **측정값**(value)을 나타냄.

### 비정돈 데이터
- 데이터가 여러 변수에 관련된 값들이 여러 열에 흩어져 있는 경우.  
    예: 월별/국가별 감염병 발생 사례를 각 국가 열로 나눠 표현.
- **장점**: 데이터를 압축적으로 표현하고 특정 값 비교가 용이.

### 정돈 데이터를 사용하는 이유

- 데이터 변환 및 시각화를 표준화된 방식으로 효율적으로 처리 가능.
- 한 행이 관측 대상을, 한 열이 변수를, 한 셀이 값을 나타내는 형식은 분석 과정에서 일관성과 유연성을 제공.

**결론**: 비정돈 데이터는 비교와 압축에 유리하나, 정돈 데이터는 분석과 변환 작업에서 효율적이고 표준화된 작업을 가능하게 함.

##### tidyverse 패키지

정돈 데이터 패러다임을 따른 패키지
``` R
# 설치
install.packages("tidyverse")
# 패키지 적재
> library(tidyverse)
── Attaching core tidyverse packages ─────────────────────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.4     ✔ readr     2.1.5
✔ forcats   1.0.0     ✔ stringr   1.5.1
✔ ggplot2   3.5.1     ✔ tibble    3.2.1
✔ lubridate 1.9.4     ✔ tidyr     1.3.1
✔ purrr     1.0.2     
── Conflicts ───────────────────────────────────────────────────────── tidyverse_conflicts() ──
✖ lubridate::%within%() masks IRanges::%within%()
✖ dplyr::collapse()     masks IRanges::collapse()
✖ dplyr::combine()      masks Biobase::combine(), BiocGenerics::combine()
✖ dplyr::count()        masks matrixStats::count()
✖ dplyr::desc()         masks IRanges::desc()
✖ tidyr::expand()       masks S4Vectors::expand()
✖ dplyr::filter()       masks stats::filter()
✖ dplyr::first()        masks S4Vectors::first()
✖ dplyr::lag()          masks stats::lag()
✖ ggplot2::Position()   masks BiocGenerics::Position(), base::Position()
✖ purrr::reduce()       masks GenomicRanges::reduce(), IRanges::reduce()
✖ dplyr::rename()       masks S4Vectors::rename()
✖ lubridate::second()   masks S4Vectors::second()
✖ lubridate::second<-() masks S4Vectors::second<-()
✖ dplyr::slice()        masks IRanges::slice()
ℹ Use the conflicted package to force all conflicts to become errors
```

## dplyr 패키지와 정돈 데이터의 변환
정돈 데이터의 변환에는 tidyverse 패키지가 포함하고 있느 dplyr 패키지가 이용된다. tidyverse를 적재하였으면 이미 dplyr 이 적재되어 있으므로 다시 할 필요없다.
정돈 데이터의 변환은 크게 5가지 변환 작업이 있다.

1. 행 선택:
	- `filter()`: 데이터에서 특정 열의 값이 조건에 맞는 행만 선택한다.
	- `slice()`: 데이터에서 특정 위치의 행만 선택한다.
2. 행 정렬
	- `arrange()`: 특정 열의 값을 기준으로 데이터의 행을 정렬한다.
3. 열 선택:
	- `select()`: 열의 이름, 위치, 데이터 형식 등으로 일부 열만 데이터에서 선택한다.
4. 열 추가:
	- `mutate()`: 기존 열을 사용하여 새로운 열을 데이터에 추가한다.
5. 데이터 요약:
	- `summarize()`: 데이터 전체 또는 특정 열을 하나의 통계량으로 요약한다.
	- `group_by()`: 데이터 요약에만 사용되는 것은 아니나, 그룹별로 데이터를 통계 요약할 때 자주 사용된다.

# filter()
##### 선택 조건이 하나인 경우
`filter(데이터프레임, 조건)`
'데이터프레임'에는 filter() 를 적용할 데이터 프레임을 '조건'에는 행 선택 조건을 기술한다. '조건'은 논리값 벡터이어야 한다. 많은 경우 '조건'은 다음처럼 변수와 어떤 값을 비교연산자로 비교한다. 다음 예에서 보는 것처럼 dplyr 패키지의 함수들은 첫번째 인수로 데이터프레임을 지정한 후, 나머지 부분에서 그 데이터프레임의 열을 변수처럼 사용할 수 있다.
``` R
> filter(mpg, manufacturer=="hyundai")
# A tibble: 14 × 11
   manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
   <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
 1 hyundai      sonata    2.4  1999     4 auto(l4)   f        18    26 r     midsize   
 2 hyundai      sonata    2.4  1999     4 manual(m5) f        18    27 r     midsize   
 3 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize   
 4 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize   
 5 hyundai      sonata    2.5  1999     6 auto(l4)   f        18    26 r     midsize   
 6 hyundai      sonata    2.5  1999     6 manual(m5) f        18    26 r     midsize   
 7 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize   
 8 hyundai      tiburon   2    1999     4 auto(l4)   f        19    26 r     subcompact
 9 hyundai      tiburon   2    1999     4 manual(m5) f        19    29 r     subcompact
10 hyundai      tiburon   2    2008     4 manual(m5) f        20    28 r     subcompact
11 hyundai      tiburon   2    2008     4 auto(l4)   f        20    27 r     subcompact
12 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact
13 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
14 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
> filter(mpg, cty> 28)
# A tibble: 3 × 11
  manufacturer model      displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>      <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 volkswagen   jetta        1.9  1999     4 manual(m5) f        33    44 d     compact   
2 volkswagen   new beetle   1.9  1999     4 manual(m5) f        35    44 d     subcompact
3 volkswagen   new beetle   1.9  1999     4 auto(l4)   f        29    41 d     subcompact
> filter(mpg, cty >= 28)
# A tibble: 5 × 11
  manufacturer model      displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>      <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 honda        civic        1.6  1999     4 manual(m5) f        28    33 r     subcompact
2 toyota       corolla      1.8  2008     4 manual(m5) f        28    37 r     compact   
3 volkswagen   jetta        1.9  1999     4 manual(m5) f        33    44 d     compact   
4 volkswagen   new beetle   1.9  1999     4 manual(m5) f        35    44 d     subcompact
5 volkswagen   new beetle   1.9  1999     4 auto(l4)   f        29    41 d     subcompact
> filter(mpg, sqrt(cty) < 3.2)
# A tibble: 5 × 11
  manufacturer model               displ  year   cyl trans      drv     cty   hwy fl    class 
  <chr>        <chr>               <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr> 
1 dodge        dakota pickup 4wd     4.7  2008     8 auto(l5)   4         9    12 e     pickup
2 dodge        durango 4wd           4.7  2008     8 auto(l5)   4         9    12 e     suv   
3 dodge        ram 1500 pickup 4wd   4.7  2008     8 auto(l5)   4         9    12 e     pickup
4 dodge        ram 1500 pickup 4wd   4.7  2008     8 manual(m6) 4         9    12 e     pickup
5 jeep         grand cherokee 4wd    4.7  2008     8 auto(l5)   4         9    12 e     suv   
```

##### 여러 조건을 만족하는 행 추출하기
`filter(데이터프레임, 조건1, 조건2, ..., 조건 n)`
``` R
> filter(mpg, manufacturer=="hyundai", cty>=20)
# A tibble: 4 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize   
2 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize   
3 hyundai      tiburon   2    2008     4 manual(m5) f        20    28 r     subcompact
4 hyundai      tiburon   2    2008     4 auto(l4)   f        20    27 r     subcompact
> filter(mpg, manufacturer=="hyundai", cty>=20, displ >= 2.4)
# A tibble: 2 × 11
  manufacturer model  displ  year   cyl trans      drv     cty   hwy fl    class  
  <chr>        <chr>  <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>  
1 hyundai      sonata   2.4  2008     4 auto(l4)   f        21    30 r     midsize
2 hyundai      sonata   2.4  2008     4 manual(m5) f        21    31 r     midsize
```


##### 논이 연산자로 복합 조건 만들기
``` R
> filter(mpg, model=="sonata" | cty >= 28)
# A tibble: 12 × 11
   manufacturer model      displ  year   cyl trans      drv     cty   hwy fl    class     
   <chr>        <chr>      <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
 1 honda        civic        1.6  1999     4 manual(m5) f        28    33 r     subcompact
 2 hyundai      sonata       2.4  1999     4 auto(l4)   f        18    26 r     midsize   
 3 hyundai      sonata       2.4  1999     4 manual(m5) f        18    27 r     midsize   
 4 hyundai      sonata       2.4  2008     4 auto(l4)   f        21    30 r     midsize   
 5 hyundai      sonata       2.4  2008     4 manual(m5) f        21    31 r     midsize   
 6 hyundai      sonata       2.5  1999     6 auto(l4)   f        18    26 r     midsize   
 7 hyundai      sonata       2.5  1999     6 manual(m5) f        18    26 r     midsize   
 8 hyundai      sonata       3.3  2008     6 auto(l5)   f        19    28 r     midsize   
 9 toyota       corolla      1.8  2008     4 manual(m5) f        28    37 r     compact   
10 volkswagen   jetta        1.9  1999     4 manual(m5) f        33    44 d     compact   
11 volkswagen   new beetle   1.9  1999     4 manual(m5) f        35    44 d     subcompact
12 volkswagen   new beetle   1.9  1999     4 auto(l4)   f        29    41 d     subcompact
> filter(mpg, model=="sonata" | cty >= 28, year == 2008)
# A tibble: 4 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class  
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>  
1 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize
2 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize
3 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize
4 toyota       corolla   1.8  2008     4 manual(m5) f        28    37 r     compact
> filter(mpg, (model=="sonata" | cty >= 28) & year == 2008)
# A tibble: 4 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class  
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>  
1 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize
2 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize
3 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize
4 toyota       corolla   1.8  2008     4 manual(m5) f        28    37 r     compact
> filter(mpg, model=="sonata" | cty >= 28 & year == 2008)
# A tibble: 8 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class  
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>  
1 hyundai      sonata    2.4  1999     4 auto(l4)   f        18    26 r     midsize
2 hyundai      sonata    2.4  1999     4 manual(m5) f        18    27 r     midsize
3 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize
4 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize
5 hyundai      sonata    2.5  1999     6 auto(l4)   f        18    26 r     midsize
6 hyundai      sonata    2.5  1999     6 manual(m5) f        18    26 r     midsize
7 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize
8 toyota       corolla   1.8  2008     4 manual(m5) f        28    37 r     compact
```

##### %in% 연산자
``` R
> filter(mpg, year==2008, hwy >= 28, model == "sonata"| model == "corolla" | model == "jetta")
# A tibble: 9 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class  
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>  
1 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize
2 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize
3 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize
4 toyota       corolla   1.8  2008     4 manual(m5) f        28    37 r     compact
5 toyota       corolla   1.8  2008     4 auto(l4)   f        26    35 r     compact
6 volkswagen   jetta     2    2008     4 auto(s6)   f        22    29 p     compact
7 volkswagen   jetta     2    2008     4 manual(m6) f        21    29 p     compact
8 volkswagen   jetta     2.5  2008     5 auto(s6)   f        21    29 r     compact
9 volkswagen   jetta     2.5  2008     5 manual(m5) f        21    29 r     compact
> a <- 1:3
> 0 %in% a
[1] FALSE
> 1 %in% a
[1] TRUE
> 3 %in% a
[1] TRUE
> filter(mpg, year==2008, hwy >= 28, model %in% c("sonata", "corolla", "jetta"))
# A tibble: 9 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class  
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>  
1 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize
2 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize
3 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize
4 toyota       corolla   1.8  2008     4 manual(m5) f        28    37 r     compact
5 toyota       corolla   1.8  2008     4 auto(l4)   f        26    35 r     compact
6 volkswagen   jetta     2    2008     4 auto(s6)   f        22    29 p     compact
7 volkswagen   jetta     2    2008     4 manual(m6) f        21    29 p     compact
8 volkswagen   jetta     2.5  2008     5 auto(s6)   f        21    29 r     compact
9 volkswagen   jetta     2.5  2008     5 manual(m5) f        21    29 r     compact
```


# slice()
`slice(데이터프레임, 선택위치1, 선택위치2, ...)`
- 선택위치 : 양의 정수 또는 음의 정수 벡터가 지정된다.
	- 양의 정수 : 해당 위치의 행 선택
	- 음의 정수 : 해당 위치의 음 선택

``` R
> a <- filter(mpg, manufacturer == "hyundai", year == 2008); a
# A tibble: 8 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize   
2 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize   
3 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize   
4 hyundai      tiburon   2    2008     4 manual(m5) f        20    28 r     subcompact
5 hyundai      tiburon   2    2008     4 auto(l4)   f        20    27 r     subcompact
6 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact
7 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
8 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
> slice(a, 1)
# A tibble: 1 × 11
  manufacturer model  displ  year   cyl trans    drv     cty   hwy fl    class  
  <chr>        <chr>  <dbl> <int> <int> <chr>    <chr> <int> <int> <chr> <chr>  
1 hyundai      sonata   2.4  2008     4 auto(l4) f        21    30 r     midsize
> slice(a, 1:3)
# A tibble: 3 × 11
  manufacturer model  displ  year   cyl trans      drv     cty   hwy fl    class  
  <chr>        <chr>  <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>  
1 hyundai      sonata   2.4  2008     4 auto(l4)   f        21    30 r     midsize
2 hyundai      sonata   2.4  2008     4 manual(m5) f        21    31 r     midsize
3 hyundai      sonata   3.3  2008     6 auto(l5)   f        19    28 r     midsize
> slice(a, 1:3, 6:7)
# A tibble: 5 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize   
2 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize   
3 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize   
4 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact
5 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
> slice(a, -1)
# A tibble: 7 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize   
2 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize   
3 hyundai      tiburon   2    2008     4 manual(m5) f        20    28 r     subcompact
4 hyundai      tiburon   2    2008     4 auto(l4)   f        20    27 r     subcompact
5 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact
6 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
7 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
> slice(a, -1, -(4:6))
# A tibble: 4 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize   
2 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize   
3 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
4 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
```

##### slice_sample() 로 표본 추출하기
데이터를 분석할 때 데이터의 일부 행만 임의로 추출해야하는 경우가 있다. slice_sample()을 사용하면 데이터에서 원하는 수 또는 비율만큼 행을 임의 추출할 수 있다.
``` R
# A tibble: 3 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
2 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
3 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize   
> slice_sample(a, prop = 0.8)
# A tibble: 6 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact
2 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize   
3 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize   
4 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
5 hyundai      tiburon   2    2008     4 auto(l4)   f        20    27 r     subcompact
6 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
```


##### slice_head() 와 slice_tail()
데이터의 맨 앞의 행들이나, 맨 뒤의 행을 추출할 때 사용한다.
``` R
> slice_head(mpg, n=4)
# A tibble: 4 × 11
  manufacturer model displ  year   cyl trans      drv     cty   hwy fl    class  
  <chr>        <chr> <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>  
1 audi         a4      1.8  1999     4 auto(l5)   f        18    29 p     compact
2 audi         a4      1.8  1999     4 manual(m5) f        21    29 p     compact
3 audi         a4      2    2008     4 manual(m6) f        20    31 p     compact
4 audi         a4      2    2008     4 auto(av)   f        21    30 p     compact
> slice_tail(mpg, prop=0.05)
# A tibble: 11 × 11
   manufacturer model      displ  year   cyl trans      drv     cty   hwy fl    class     
   <chr>        <chr>      <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
 1 volkswagen   new beetle   2    1999     4 manual(m5) f        21    29 r     subcompact
 2 volkswagen   new beetle   2    1999     4 auto(l4)   f        19    26 r     subcompact
 3 volkswagen   new beetle   2.5  2008     5 manual(m5) f        20    28 r     subcompact
 4 volkswagen   new beetle   2.5  2008     5 auto(s6)   f        20    29 r     subcompact
 5 volkswagen   passat       1.8  1999     4 manual(m5) f        21    29 p     midsize   
 6 volkswagen   passat       1.8  1999     4 auto(l5)   f        18    29 p     midsize   
 7 volkswagen   passat       2    2008     4 auto(s6)   f        19    28 p     midsize   
 8 volkswagen   passat       2    2008     4 manual(m6) f        21    29 p     midsize   
 9 volkswagen   passat       2.8  1999     6 auto(l5)   f        16    26 p     midsize   
10 volkswagen   passat       2.8  1999     6 manual(m5) f        18    26 p     midsize   
11 volkswagen   passat       3.6  2008     6 auto(s6)   f        17    26 p     midsize 
```

##### slice_min() & slice_max()
특정 열을 기준으로 가장 값이 작은 행 또는 가장 값이 큰 행을 추출하는 함수이다. 사실 뒤에서 설명할 arrange() 함수를 적용한 후 slice() 함수를 적용하면 같은 효과를 구현할 수 있다.
``` R
> slice_min(a, cty, n=2)
# A tibble: 3 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
2 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact
3 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
> slice_min(a, hwy, n=2)
# A tibble: 3 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact
2 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
3 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
> slice_max(a, hwy, n=2)
# A tibble: 2 × 11
  manufacturer model  displ  year   cyl trans      drv     cty   hwy fl    class  
  <chr>        <chr>  <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>  
1 hyundai      sonata   2.4  2008     4 manual(m5) f        21    31 r     midsize
2 hyundai      sonata   2.4  2008     4 auto(l4)   f        21    30 r     midsize
```

# arrange() 
`arrange(데이터프레임, 첫번째 정렬 기준 변수, 두번째 정렬 기준 변수,  ...)
``` R
> a <- filter(mpg, manufacturer == "hyundai", year == 2008)
> a
# A tibble: 8 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize   
2 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize   
3 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize   
4 hyundai      tiburon   2    2008     4 manual(m5) f        20    28 r     subcompact
5 hyundai      tiburon   2    2008     4 auto(l4)   f        20    27 r     subcompact
6 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact
7 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
8 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
> arrange(a, cyl)
# A tibble: 8 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize   
2 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize   
3 hyundai      tiburon   2    2008     4 manual(m5) f        20    28 r     subcompact
4 hyundai      tiburon   2    2008     4 auto(l4)   f        20    27 r     subcompact
5 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize   
6 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact
7 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
8 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
> arrange(a, cyl, cty)
# A tibble: 8 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      tiburon   2    2008     4 manual(m5) f        20    28 r     subcompact
2 hyundai      tiburon   2    2008     4 auto(l4)   f        20    27 r     subcompact
3 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize   
4 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize   
5 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
6 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact
7 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
8 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize   
> arrange(a, model, trans)
# A tibble: 8 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize   
2 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize   
3 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize   
4 hyundai      tiburon   2    2008     4 auto(l4)   f        20    27 r     subcompact
5 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact
6 hyundai      tiburon   2    2008     4 manual(m5) f        20    28 r     subcompact
7 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
8 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact


# desc() 로 내림차순으로 정렬하기

> arrange(a, desc(cyl))
# A tibble: 8 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize   
2 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact
3 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
4 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
5 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize   
6 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize   
7 hyundai      tiburon   2    2008     4 manual(m5) f        20    28 r     subcompact
8 hyundai      tiburon   2    2008     4 auto(l4)   f        20    27 r     subcompact
> arrange(a, desc(cyl), cty)
# A tibble: 8 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
2 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact
3 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
4 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize   
5 hyundai      tiburon   2    2008     4 manual(m5) f        20    28 r     subcompact
6 hyundai      tiburon   2    2008     4 auto(l4)   f        20    27 r     subcompact
7 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize   
8 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize   
> arrange(a, model, desc(trans))
# A tibble: 8 × 11
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>     
1 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize   
2 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize   
3 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize   
4 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact
5 hyundai      tiburon   2    2008     4 manual(m5) f        20    28 r     subcompact
6 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact
7 hyundai      tiburon   2    2008     4 auto(l4)   f        20    27 r     subcompact
8 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact
```



# select()를 이용하여 변수 이름으로 열 선택하기
##### 변수 이름을 나열하여 선택하기
```
select(데이터프레임, 범위시작_변수이름:범위종료_변수이름, ...)
```

``` R
> select(a, model, year, cty, hwy)
# A tibble: 8 × 4
  model    year   cty   hwy
  <chr>   <int> <int> <int>
1 sonata   2008    21    30
2 sonata   2008    21    31
3 sonata   2008    19    28
4 tiburon  2008    20    28
5 tiburon  2008    20    27
6 tiburon  2008    17    24
7 tiburon  2008    16    24
8 tiburon  2008    17    24
> select(a, model:trans)
# A tibble: 8 × 5
  model   displ  year   cyl trans     
  <chr>   <dbl> <int> <int> <chr>     
1 sonata    2.4  2008     4 auto(l4)  
2 sonata    2.4  2008     4 manual(m5)
3 sonata    3.3  2008     6 auto(l5)  
4 tiburon   2    2008     4 manual(m5)
5 tiburon   2    2008     4 auto(l4)  
6 tiburon   2.7  2008     6 auto(l4)  
7 tiburon   2.7  2008     6 manual(m6)
8 tiburon   2.7  2008     6 manual(m5)
> select(a, model:trans, cty:hwy)
# A tibble: 8 × 7
  model   displ  year   cyl trans        cty   hwy
  <chr>   <dbl> <int> <int> <chr>      <int> <int>
1 sonata    2.4  2008     4 auto(l4)      21    30
2 sonata    2.4  2008     4 manual(m5)    21    31
3 sonata    3.3  2008     6 auto(l5)      19    28
4 tiburon   2    2008     4 manual(m5)    20    28
5 tiburon   2    2008     4 auto(l4)      20    27
6 tiburon   2.7  2008     6 auto(l4)      17    24
7 tiburon   2.7  2008     6 manual(m6)    16    24
8 tiburon   2.7  2008     6 manual(m5)    17    24
```

```
select(데이터프레임, -(범위시작_변수이름:범위종료_변수이름), ...)
```

``` R
> select(a, -(model:trans))
# A tibble: 8 × 6
  manufacturer drv     cty   hwy fl    class     
  <chr>        <chr> <int> <int> <chr> <chr>     
1 hyundai      f        21    30 r     midsize   
2 hyundai      f        21    31 r     midsize   
3 hyundai      f        19    28 r     midsize   
4 hyundai      f        20    28 r     subcompact
5 hyundai      f        20    27 r     subcompact
6 hyundai      f        17    24 r     subcompact
7 hyundai      f        16    24 r     subcompact
8 hyundai      f        17    24 r     subcompact
> select(a, -(model:trans), -manufacturer)
# A tibble: 8 × 5
  drv     cty   hwy fl    class     
  <chr> <int> <int> <chr> <chr>     
1 f        21    30 r     midsize   
2 f        21    31 r     midsize   
3 f        19    28 r     midsize   
4 f        20    28 r     subcompact
5 f        20    27 r     subcompact
6 f        17    24 r     subcompact
7 f        16    24 r     subcompact
8 f        17    24 r     subcompact
```

##### 변수 위치로 매칭하여 선택하기

``` R
> select(a, 1:3)
# A tibble: 8 × 3
  manufacturer model   displ
  <chr>        <chr>   <dbl>
1 hyundai      sonata    2.4
2 hyundai      sonata    2.4
3 hyundai      sonata    3.3
4 hyundai      tiburon   2  
5 hyundai      tiburon   2  
6 hyundai      tiburon   2.7
7 hyundai      tiburon   2.7
8 hyundai      tiburon   2.7
> select(a, 1:3, 5)
# A tibble: 8 × 4
  manufacturer model   displ   cyl
  <chr>        <chr>   <dbl> <int>
1 hyundai      sonata    2.4     4
2 hyundai      sonata    2.4     4
3 hyundai      sonata    3.3     6
4 hyundai      tiburon   2       4
5 hyundai      tiburon   2       4
6 hyundai      tiburon   2.7     6
7 hyundai      tiburon   2.7     6
8 hyundai      tiburon   2.7     6
> select(a, -(4:10))
# A tibble: 8 × 4
  manufacturer model   displ class     
  <chr>        <chr>   <dbl> <chr>     
1 hyundai      sonata    2.4 midsize   
2 hyundai      sonata    2.4 midsize   
3 hyundai      sonata    3.3 midsize   
4 hyundai      tiburon   2   subcompact
5 hyundai      tiburon   2   subcompact
6 hyundai      tiburon   2.7 subcompact
7 hyundai      tiburon   2.7 subcompact
8 hyundai      tiburon   2.7 subcompact
```

##### 변수 이름을 매칭하여 선택하기
`dplyr` 패키지는 다양한 형태로 변수를 선택할 수 있도록 다음의 변수 이름 매칭 함수를 제공한다. 이러한 함수는 변수의 수가 많을 때 매우 유용하다.

- `starts_with("abs")`: abc로 이름이 시작하는 모든 변수
- `ends_with("abs")`: abc로 이름이 끝나는 모든 변수
- `contains("abs")`: abc를 이름에 포함하고 있는 모든 변수
- `matches("(.)\\1")`: 정규 표현식을 만족하는 이름을 가진 모든 변수
- `num_range("x", 1:3)`: “x1”, “x2”, “x3”이라는 이름의 변수

``` R
> select(a, starts_with("c"))
# A tibble: 8 × 3
    cyl   cty class     
  <int> <int> <chr>     
1     4    21 midsize   
2     4    21 midsize   
3     6    19 midsize   
4     4    20 subcompact
5     4    20 subcompact
6     6    17 subcompact
7     6    16 subcompact
8     6    17 subcompact
```


##### 변수의 형식이나 조건으로 매칭하여 선택하기
``` R
> select(a, where(is.character))
# A tibble: 8 × 6
  manufacturer model   trans      drv   fl    class     
  <chr>        <chr>   <chr>      <chr> <chr> <chr>     
1 hyundai      sonata  auto(l4)   f     r     midsize   
2 hyundai      sonata  manual(m5) f     r     midsize   
3 hyundai      sonata  auto(l5)   f     r     midsize   
4 hyundai      tiburon manual(m5) f     r     subcompact
5 hyundai      tiburon auto(l4)   f     r     subcompact
6 hyundai      tiburon auto(l4)   f     r     subcompact
7 hyundai      tiburon manual(m6) f     r     subcompact
8 hyundai      tiburon manual(m5) f     r     subcompact
> select(a, where(function(x) is.numeric(x) && mean(x) >= 10))
# A tibble: 8 × 3
   year   cty   hwy
  <int> <int> <int>
1  2008    21    30
2  2008    21    31
3  2008    19    28
4  2008    20    28
5  2008    20    27
6  2008    17    24
7  2008    16    24
8  2008    17    24
> select(a, where(~ is.numeric(.x) && mean(.x) < 10))
# A tibble: 8 × 2
  displ   cyl
  <dbl> <int>
1   2.4     4
2   2.4     4
3   3.3     6
4   2       4
5   2       4
6   2.7     6
7   2.7     6
8   2.7     6
```

##### 변수 이름 바꾸기
`select()` 함수에서 변수 이름을 지정할 때, (새로운 변수 이름) = (기존 변수 이름) 형식으로 지정하면 변수의 이름을 바꿀 수 있다.
``` R
> select(a, model, city=cty, highway=hwy)
# A tibble: 8 × 3
  model    city highway
  <chr>   <int>   <int>
1 sonata     21      30
2 sonata     21      31
3 sonata     19      28
4 tiburon    20      28
5 tiburon    20      27
6 tiburon    17      24
7 tiburon    16      24
8 tiburon    17      24

> rename(a, city=cty, highway=hwy)
# A tibble: 8 × 11
  manufacturer model   displ  year   cyl trans      drv    city highway fl    class     
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int>   <int> <chr> <chr>     
1 hyundai      sonata    2.4  2008     4 auto(l4)   f        21      30 r     midsize   
2 hyundai      sonata    2.4  2008     4 manual(m5) f        21      31 r     midsize   
3 hyundai      sonata    3.3  2008     6 auto(l5)   f        19      28 r     midsize   
4 hyundai      tiburon   2    2008     4 manual(m5) f        20      28 r     subcompact
5 hyundai      tiburon   2    2008     4 auto(l4)   f        20      27 r     subcompact
6 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17      24 r     subcompact
7 hyundai      tiburon   2.7  2008     6 manual(m6) f        16      24 r     subcompact
8 hyundai      tiburon   2.7  2008     6 manual(m5) f        17      24 r     subcompact
```


##### 변수 순서 바꾸기
``` R
> select(a, cty, hwy)
# A tibble: 8 × 2
    cty   hwy
  <int> <int>
1    21    30
2    21    31
3    19    28
4    20    28
5    20    27
6    17    24
7    16    24
8    17    24
> select(a, hwy, cty)
# A tibble: 8 × 2
    hwy   cty
  <int> <int>
1    30    21
2    31    21
3    28    19
4    28    20
5    27    20
6    24    17
7    24    16
8    24    17
> select(a, cty, hwy, everything())
# A tibble: 8 × 11
    cty   hwy manufacturer model   displ  year   cyl trans      drv   fl    class     
  <int> <int> <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <chr> <chr>     
1    21    30 hyundai      sonata    2.4  2008     4 auto(l4)   f     r     midsize   
2    21    31 hyundai      sonata    2.4  2008     4 manual(m5) f     r     midsize   
3    19    28 hyundai      sonata    3.3  2008     6 auto(l5)   f     r     midsize   
4    20    28 hyundai      tiburon   2    2008     4 manual(m5) f     r     subcompact
5    20    27 hyundai      tiburon   2    2008     4 auto(l4)   f     r     subcompact
6    17    24 hyundai      tiburon   2.7  2008     6 auto(l4)   f     r     subcompact
7    16    24 hyundai      tiburon   2.7  2008     6 manual(m6) f     r     subcompact
8    17    24 hyundai      tiburon   2.7  2008     6 manual(m5) f     r     subcompact
```



# mutate()
`mutate()`는 기존 변수를 이용하여 새로운 변수를 만들어 데이터 프레임의 가장 마지막 열로 추가한다.
```
mutate(데이터프레임, 새로운_변수=기존_변수_연산식, ....)
```

``` R
> b <- select(a, -(cyl:drv), -(fl:class)); b
# A tibble: 8 × 6
  manufacturer model   displ  year   cty   hwy
  <chr>        <chr>   <dbl> <int> <int> <int>
1 hyundai      sonata    2.4  2008    21    30
2 hyundai      sonata    2.4  2008    21    31
3 hyundai      sonata    3.3  2008    19    28
4 hyundai      tiburon   2    2008    20    28
5 hyundai      tiburon   2    2008    20    27
6 hyundai      tiburon   2.7  2008    17    24
7 hyundai      tiburon   2.7  2008    16    24
8 hyundai      tiburon   2.7  2008    17    24
> mutate(b, sum=cty + hwy)
# A tibble: 8 × 7
  manufacturer model   displ  year   cty   hwy   sum
  <chr>        <chr>   <dbl> <int> <int> <int> <int>
1 hyundai      sonata    2.4  2008    21    30    51
2 hyundai      sonata    2.4  2008    21    31    52
3 hyundai      sonata    3.3  2008    19    28    47
4 hyundai      tiburon   2    2008    20    28    48
5 hyundai      tiburon   2    2008    20    27    47
6 hyundai      tiburon   2.7  2008    17    24    41
7 hyundai      tiburon   2.7  2008    16    24    40
8 hyundai      tiburon   2.7  2008    17    24    41
> mutate(b,
+        sum=cty + hwy,
+        mean=(cty + hwy)/2,
+        ratio= cty / hwy * 100)
# A tibble: 8 × 9
  manufacturer model   displ  year   cty   hwy   sum  mean ratio
  <chr>        <chr>   <dbl> <int> <int> <int> <int> <dbl> <dbl>
1 hyundai      sonata    2.4  2008    21    30    51  25.5  70  
2 hyundai      sonata    2.4  2008    21    31    52  26    67.7
3 hyundai      sonata    3.3  2008    19    28    47  23.5  67.9
4 hyundai      tiburon   2    2008    20    28    48  24    71.4
5 hyundai      tiburon   2    2008    20    27    47  23.5  74.1
6 hyundai      tiburon   2.7  2008    17    24    41  20.5  70.8
7 hyundai      tiburon   2.7  2008    16    24    40  20    66.7
8 hyundai      tiburon   2.7  2008    17    24    41  20.5  70.8
```

##### transmute() 새로운 변수만 남기기
``` R
> transmute(b,
+            sum=cty + hwy,
+            mean=(cty + hwy)/2,
+            ratio= cty / hwy * 100)
# A tibble: 8 × 3
    sum  mean ratio
  <int> <dbl> <dbl>
1    51  25.5  70  
2    52  26    67.7
3    47  23.5  67.9
4    48  24    71.4
5    47  23.5  74.1
6    41  20.5  70.8
7    40  20    66.7
8    41  20.5  70.8
```

##### 새로운 변수를 만들 때 사용할 수 있는 함수들
``` R
> mutate(b, newName=paste(manufacturer, model, sep="-"), dis3=displ >= 3)
# A tibble: 8 × 8
  manufacturer model   displ  year   cty   hwy newName         dis3 
  <chr>        <chr>   <dbl> <int> <int> <int> <chr>           <lgl>
1 hyundai      sonata    2.4  2008    21    30 hyundai-sonata  FALSE
2 hyundai      sonata    2.4  2008    21    31 hyundai-sonata  FALSE
3 hyundai      sonata    3.3  2008    19    28 hyundai-sonata  TRUE 
4 hyundai      tiburon   2    2008    20    28 hyundai-tiburon FALSE
5 hyundai      tiburon   2    2008    20    27 hyundai-tiburon FALSE
6 hyundai      tiburon   2.7  2008    17    24 hyundai-tiburon FALSE
7 hyundai      tiburon   2.7  2008    16    24 hyundai-tiburon FALSE
8 hyundai      tiburon   2.7  2008    17    24 hyundai-tiburon FALSE
```
- `row_number()`: 각 행의 행번호. 각 행에 일련번호를 붙일 때 유용.
- `lead()`: 기존 변수를 한 행, 또는 여러 행 빠르게 시작하는 변수
- `lag()`: 기존 변수를 한 행, 또는 여러 행 늦게 시작하는 변수
- `cumsum()`, `cummean()`: 누적 합과 평균
- `min_rank()`: 가장 작은 것부터 차례대로 크기 순서로 등수를 매기는 함수. `desc()` 함수를 변수에 적용한 후 등수를 매기면 가장 큰 것부터 순서를 매길 수 있다.
- `dense_rank()`, `percent_rank()`, `cume_dist()`, `ntile()` 등도 사용될 수 있다. 자세한 내용은 도움말을 참조하기 바란다.
``` R
> store <- data.frame(month=1:6, sales=c(23, 45, 34, 67, 30, 41)); store
  month sales
1     1    23
2     2    45
3     3    34
4     4    67
5     5    30
6     6    41

> mutate(store,
+        before = lag(sales, n = 1),
+        after = lead(sales, n = 1),
+        total = cumsum(sales),
+        mean = cummean(sales),
+        rank1 = min_rank(sales),
+        rank2 = min_rank(desc(sales)))
  month sales before after total  mean rank1 rank2
1     1    23     NA    45    23 23.00     1     6
2     2    45     23    34    68 34.00     5     2
3     3    34     45    67   102 34.00     3     4
4     4    67     34    30   169 42.25     6     1
5     5    30     67    41   199 39.80     2     5
6     6    41     30    NA   240 40.00     4     3

> mutate(b, id = row_number())
# A tibble: 8 × 7
  manufacturer model   displ  year   cty   hwy    id
  <chr>        <chr>   <dbl> <int> <int> <int> <int>
1 hyundai      sonata    2.4  2008    21    30     1
2 hyundai      sonata    2.4  2008    21    31     2
3 hyundai      sonata    3.3  2008    19    28     3
4 hyundai      tiburon   2    2008    20    28     4
5 hyundai      tiburon   2    2008    20    27     5
6 hyundai      tiburon   2.7  2008    17    24     6
7 hyundai      tiburon   2.7  2008    16    24     7
8 hyundai      tiburon   2.7  2008    17    24     8
```

# summarize() 변수 요약
```
summarize(데이터프레임, 요약변수이름=요약함수(변수), ....)
```
`summarize()` 함수는 데이터프레임을 하나의 행으로 요약한다. 하나의 행으로 요약하기 위하여 변수의 모든 값을 하나의 값으로 통계요약하는 함수를 주로 이용한다. 대표적인 통계요약 함수는 다음과 같다.

- `n()`: 행의 수를 구한다.
- `sum()`: 수치 변수의 합을 구한다.
- `mean()`: 수치 변수의 균을 구한다.
- `median()`: 수치 변수의 중위수를 구한다.
- `sd()`: 수치 변수의 표준편차를 구한다.
- `var()`: 수치 변수의 분산을 구한다.
- `min()`: 수치 변수의 최소값을 구한다.
- `max()`: 수치 변수의 최대값을 구한다.
- `quantile(변수, probs): 수치 변수의`probs` 분위수를 구한다.

``` R
> summarize(b, count=n(), mean=mean(cty), med=median(cty), 
+           min=min(cty), max=max(cty))
# A tibble: 1 × 5
  count  mean   med   min   max
  <int> <dbl> <dbl> <int> <int>
1     8  18.9  19.5    16    21

> summarize(b, meanCty=mean(cty), meanHwy=mean(hwy),
+           medianCty=median(cty), medianHqy=median(hwy))
# A tibble: 1 × 4
  meanCty meanHwy medianCty medianHqy
    <dbl>   <dbl>     <dbl>     <dbl>
1    18.9      27      19.5      27.5
```


`across()` 함수는 `select()`처럼 열을 선택하여 동일한 함수를 적용할 수 있게 해준다. `across()` 함수는 두 개의 주요 인수를 가지고 있다.

- 첫 번째 인수는 `.cols`로 함수를 적용할 열을 지정한다. 열의 지정은 `select()` 함수처럼 변수 이름, 위치, 형식으로 지정할 수 있다.
- 두 번재 인수는 `.fns`로 열에 적용할 함수를 지정한다.
``` R
> summarize(b, across(c(cty, hwy), mean))
# A tibble: 1 × 2
    cty   hwy
  <dbl> <dbl>
1  18.9    27
> summarize(b, across(c(cty, hwy), list(mean=mean, med=median)))
# A tibble: 1 × 4
  cty_mean cty_med hwy_mean hwy_med
     <dbl>   <dbl>    <dbl>   <dbl>
1     18.9    19.5       27    27.5
> summarize(b, 
+           across(c(cty, hwy), list(mean=mean, med=median), .names="{.fn}-{.col}"))
# A tibble: 1 × 4
  `mean-cty` `med-cty` `mean-hwy` `med-hwy`
       <dbl>     <dbl>      <dbl>     <dbl>
1       18.9      19.5         27      27.5

> summarize(b, across(c(cty, hwy), mean, .names="mean-{.col}"),
+           across(c(cty, hwy), median, .names="med-{.col}"))
# A tibble: 1 × 4
  `mean-cty` `mean-hwy` `med-cty` `med-hwy`
       <dbl>      <dbl>     <dbl>     <dbl>
1       18.9         27      19.5      27.5
> summarize(b, across(where(is.numeric), sd))
# A tibble: 1 × 4
  displ  year   cty   hwy
  <dbl> <dbl> <dbl> <dbl>
1 0.427     0  1.96  2.78
```


# group_by() 로 그룹별로 요약
`group_by(데이터프레임, 그룹기준변수1, 그룹기준변수2, ...)`

group_by() 함수는 기준이 되는 변수의 구분되는 값에 따라 데이터를 그룹화한다.  그룹화된 결과를 summarize() 함수에 전달하면 그룹별로 요약된 결과를 출력한다.
``` R
> byModel <- group_by(b, model)
> summarize(byModel, count=n(), mean=mean(cty), sd=sd(cty))
# A tibble: 2 × 4
  model   count  mean    sd
  <chr>   <int> <dbl> <dbl>
1 sonata      3  20.3  1.15
2 tiburon     5  18    1.87
> byModel
# A tibble: 8 × 6
# Groups:   model [2]
  manufacturer model   displ  year   cty   hwy
  <chr>        <chr>   <dbl> <int> <int> <int>
1 hyundai      sonata    2.4  2008    21    30
2 hyundai      sonata    2.4  2008    21    31
3 hyundai      sonata    3.3  2008    19    28
4 hyundai      tiburon   2    2008    20    28
5 hyundai      tiburon   2    2008    20    27
6 hyundai      tiburon   2.7  2008    17    24
7 hyundai      tiburon   2.7  2008    16    24
8 hyundai      tiburon   2.7  2008    17    24
> byModel <- group_by(a, model, cyl)
> summarize(byModel, count=n(), mean=mean(cty))
`summarise()` has grouped output by 'model'. You can override using the `.groups` argument.
# A tibble: 4 × 4
# Groups:   model [2]
  model     cyl count  mean
  <chr>   <int> <int> <dbl>
1 sonata      4     2  21  
2 sonata      6     1  19  
3 tiburon     4     2  20  
4 tiburon     6     3  16.7
```

##### 그룹별로 새 변수 추가하기
``` R
> mutate(b, rank=min_rank(desc(hwy)))
# A tibble: 8 × 7
  manufacturer model   displ  year   cty   hwy  rank
  <chr>        <chr>   <dbl> <int> <int> <int> <int>
1 hyundai      sonata    2.4  2008    21    30     2
2 hyundai      sonata    2.4  2008    21    31     1
3 hyundai      sonata    3.3  2008    19    28     3
4 hyundai      tiburon   2    2008    20    28     3
5 hyundai      tiburon   2    2008    20    27     5
6 hyundai      tiburon   2.7  2008    17    24     6
7 hyundai      tiburon   2.7  2008    16    24     6
8 hyundai      tiburon   2.7  2008    17    24     6
> mutate(byModel, rank=min_rank(desc(hwy)))
# A tibble: 8 × 12
# Groups:   model, cyl [4]
  manufacturer model   displ  year   cyl trans      drv     cty   hwy fl    class       rank
  <chr>        <chr>   <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>      <int>
1 hyundai      sonata    2.4  2008     4 auto(l4)   f        21    30 r     midsize        2
2 hyundai      sonata    2.4  2008     4 manual(m5) f        21    31 r     midsize        1
3 hyundai      sonata    3.3  2008     6 auto(l5)   f        19    28 r     midsize        1
4 hyundai      tiburon   2    2008     4 manual(m5) f        20    28 r     subcompact     1
5 hyundai      tiburon   2    2008     4 auto(l4)   f        20    27 r     subcompact     2
6 hyundai      tiburon   2.7  2008     6 auto(l4)   f        17    24 r     subcompact     1
7 hyundai      tiburon   2.7  2008     6 manual(m6) f        16    24 r     subcompact     1
8 hyundai      tiburon   2.7  2008     6 manual(m5) f        17    24 r     subcompact     1
```

##### count() 
``` R
> byModel <- group_by(b, model)
> summarise(byModel, n=n())
# A tibble: 2 × 2
  model       n
  <chr>   <int>
1 sonata      3
2 tiburon     5
> count(b, model)
# A tibble: 2 × 2
  model       n
  <chr>   <int>
1 sonata      3
2 tiburon     5
> count(mpg, class)
# A tibble: 7 × 2
  class          n
  <chr>      <int>
1 2seater        5
2 compact       47
3 midsize       41
4 minivan       11
5 pickup        33
6 subcompact    35
7 suv           62
> count(mpg, class, sort = TRUE)
# A tibble: 7 × 2
  class          n
  <chr>      <int>
1 suv           62
2 compact       47
3 midsize       41
4 subcompact    35
5 pickup        33
6 minivan       11
7 2seater        5
> count(mpg, class, cyl, sort = T)
# A tibble: 19 × 3
   class        cyl     n
   <chr>      <int> <int>
 1 suv            8    38
 2 compact        4    32
 3 midsize        6    23
 4 subcompact     4    21
 5 pickup         8    20
 6 midsize        4    16
 7 suv            6    16
 8 compact        6    13
 9 minivan        6    10
10 pickup         6    10
11 suv            4     8
12 subcompact     6     7
13 2seater        8     5
14 subcompact     8     5
15 pickup         4     3
16 compact        5     2
17 midsize        8     2
18 subcompact     5     2
19 minivan        4     1
```



#  `%>%` 파이프 연산자
### 여러 단계를 거쳐 데이터를 변환할 때
``` R
> byModel <- group_by(mpg, model, year)
> meanCty <- summarize(byModel, count=n(), mean=mean(cty))
`summarise()` has grouped output by 'model'. You can override using the `.groups` argument.
> filter(meanCty, mean >= 22)
# A tibble: 5 × 4
# Groups:   model [3]
  model       year count  mean
  <chr>      <int> <int> <dbl>
1 civic       1999     5  24.8
2 civic       2008     4  24  
3 corolla     1999     3  24.7
4 corolla     2008     2  27  
5 new beetle  1999     4  26  
> filter(summarize(group_by(mpg, model, year), count=n(), mean=mean(cty)), mean >= 22)
`summarise()` has grouped output by 'model'. You can override using the `.groups` argument.
# A tibble: 5 × 4
# Groups:   model [3]
  model       year count  mean
  <chr>      <int> <int> <dbl>
1 civic       1999     5  24.8
2 civic       2008     4  24  
3 corolla     1999     3  24.7
4 corolla     2008     2  27  
5 new beetle  1999     4  26 
```

## 파이프 연산자
데이터 변환이 여러 단계를 거칠 때 불필요한 변수의 생성 없이도 함수 간에 중간 데이터를 전달할 수 있게 해준다.
``` R
> mpg %>% group_by(model, year) %>%
+   summarize(count=n(), mean=mean(cty)) %>%
+   filter(mean >= 22)
`summarise()` has grouped output by 'model'. You can override using the `.groups` argument.
# A tibble: 5 × 4
# Groups:   model [3]
  model       year count  mean
  <chr>      <int> <int> <dbl>
1 civic       1999     5  24.8
2 civic       2008     4  24  
3 corolla     1999     3  24.7
4 corolla     2008     2  27  
5 new beetle  1999     4  26  

> b %>% group_by(model) %>% 
+   summarize(count=n(), mean=mean(cty)) %>% filter(mean >= 20)
# A tibble: 1 × 3
  model  count  mean
  <chr>  <int> <dbl>
1 sonata     3  20.3

```


##### ungroup()
파이프 연산자를 사용하여 데이터를 전달하다 보면 데이터가 그룹화 된 것을 중간 단계에서 해제하고 싶을 때가 있다. 이 경우에는 ungroup( ) 명령을 사용한다.
``` R
> byModel <- b %>% group_by(model) 
> byModel %>% summarize(count=n())
# A tibble: 2 × 2
  model   count
  <chr>   <int>
1 sonata      3
2 tiburon     5
> byModel %>% ungroup() %>% summarize(count=n())
# A tibble: 1 × 1
  count
  <int>
1     8
```

