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