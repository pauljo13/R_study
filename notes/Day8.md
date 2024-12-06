___
# 리스트
지금까지는 객체에 포함되는 요소가 모두 같은 타입인 벡터나 행렬을 살펴보았다. 이 장에서는 숫자와 문자 등 다른 타입의 데이터를 결합시킬 수 있는 리스트라는 데이터 구조를 살펴본다.
실제 데이터 분석을 수행할 때 사용자가 리스트를 직접적으로 생성하는 경우는 그리 많지 않다. 그러나 리스트를 이해하는 것은 매우 중요한데 그 이유는 다음과 같다.
##### 리스트 이해의 중요성
1. 데이터 프레임은 리스트를 기반으로 하고 있다. 리스트의 이는 데이터를 효율적으로 조작하는 데 도움이 됨
2. R의 함수는 복잡한 분석의 결과를 리스트 타입으로 제공하는 경우가 많다.


## 1. 객체, 객체의 타입, 객체의 속성
##### Objects 
R에서는 메모리에 저장하거나 메모리에서 읽어 올 수 있는 모든 데이터 단위를 객체라고 부른다.

##### Objects's type
객체는 하나의 데이터 타입을 갖는다. (모드 mode, 라고도 한다.) 데이터 타입이 다른 객체는 다른 방식으로 메모리에 저장되고 읽어들여진다.
R에서는 함수를 나타내는 closure 타입, R의 표현식을 의마하는 expression 타입 등 다양한 타입이 존재한다. 그러한 데이터의 관점에서 보면 크게 두 가지 종류의 근본적인 데이터 타입이 존재한다.
- **원자적 벡터(Atomic vectors)** 
- **일반적 벡터(Generic vectors**

#### 원자적 벡터 atomic vectors
##### typeof()
- 객체의 데이터 타입을 반환하는 함수
```r
> a <- c(T, F, F, T); typeof(a)
[1] "logical"
> b <- 1:4; typeof(b)
[1] "integer"
> d <- c(1.5, 2.7, 3.3, 4.7); typeof(d)
[1] "double"
> e <- c("car", "bus", "train", "plane"); typeof(e)
[1] "character"

```

##### 데이터 자동 형변환
- 논리값, 정수, 실수, 문자 데이터 형식은 제시된 순서대로 데이터가 자동 형변환 된다.
```r
> f <- c(a,b); f; typeof(f)
[1] 1 0 0 1 1 2 3 4
[1] "integer"
> g <- c(b, d); g; typeof(g)
[1] 1.0 2.0 3.0 4.0 1.5 2.7 3.3 4.7
[1] "double"
> h <- c(d, e); h; typeof(h)
[1] "1.5"   "2.7"   "3.3"   "4.7"   "car"   "bus"   "train" "plane"
[1] "character"
> g * 2
[1] 2.0 4.0 6.0 8.0 3.0 5.4 6.6 9.4
> h * 2
Error in h * 2 : non-numeric argument to binary operator
```

##### 내재적 속성
- 객체의 데이터 타입은 모든 객체의 내제적 속성 중 하나이다. 모든 객체가 가지는 또 다른 내재적 속성은 길이이다. 길이 속성은 해당 객체의 데이터 요소가 몇 개인지를 알려준다.
```r
# length : 객체의 데이터 길이를 알려주는 함수
> length(a)
[1] 4
> length(b)
[1] 4
```

##### 행렬의 타입
- 행렬도 결국은 모두 같은 데이터 형식을 가지는 데이터 요소로 구성되어 있으므로, 원자적 벡터 형식의 데이터라고 할 수 있다. 따라서 행렬의 데이터 타입도 결국 벡터가 가지는 데이터 타입과 동일함을 확인할 수 있다.
``` r
> aa <- matrix(a, nrow = 2); aa; typeof(aa); length(aa)
      [,1]  [,2]
[1,]  TRUE FALSE
[2,] FALSE  TRUE
[1] "logical"
[1] 4
> bb <- matrix(b, nrow = 2); bb; typeof(bb); length(bb)
     [,1] [,2]
[1,]    1    3
[2,]    2    4
[1] "integer"
[1] 4
> dd <- matrix(d, nrow = 2); dd; typeof(dd); length(dd)
     [,1] [,2]
[1,]  1.5  3.3
[2,]  2.7  4.7
[1] "double"
[1] 4
> ee <- matrix(e, nrow = 2); ee; typeof(ee); length(ee)
     [,1]  [,2]   
[1,] "car" "train"
[2,] "bus" "plane"
[1] "character"
[1] 4

# class() 함수
## 클래스는 객체에 따라 부여되지 않을 수도 있고 여러 개가 부여될 수 있는 속성으로, 객체가 R 함수에 의해 처리될 때 어떤 방식으로 처리되어야 하는지를 알려준다.
> class(b)
[1] "integer"
> class(bb)
[1] "matrix" "array" 
```

##### attributes()
각 객체가 가진 내재적 속성인 데이터 타입과 길이를 제외한 모든 속성을 확인할 수 있다.
```r
> attributes(b)
NULL
> attributes(bb)
$dim
[1] 2 2
```
##### attr()
객체에서 특정 이름을 가진 속성을 보여주거나 해당 속성에 데이터를 할당하기 위해 이용된다.
``` r
> z <- 1:9; z
[1] 1 2 3 4 5 6 7 8 9
> class(z)
[1] "integer"
> attr(z, "dim")
NULL
> attr(z, "dim") <- c(3,3)
> attributes(z)
$dim
[1] 3 3

> z
     [,1] [,2] [,3]
[1,]    1    4    7
[2,]    2    5    8
[3,]    3    6    9

> attr(z, "dimnames") <-list(c("A", "B", "C"), 1:3)
> attributes(z)
$dim
[1] 3 3

$dimnames
$dimnames[[1]]
[1] "A" "B" "C"

$dimnames[[2]]
[1] "1" "2" "3"


> z
  1 2 3
A 1 4 7
B 2 5 8
C 3 6 9
```

##### 객체 속성 함수
attr() 함수를 이용하여 다양한 속성을 객체에 부가할 수 있다. 그러나 보통 속성 이름을 잘못 부여하여 오작동하는 것을 방지하고, 사용자의 편의를 도모하기 위해 자주 사용 되는 속성을 확인하거나 할당하는 dim(), dimnames(). names(), row.names(), class() 등의 각 속성 전용의 함수들이 정의되어 있다.

##### 모드와 타입의 차이
- 모드 : R의 전신인 S 언어에서 데이터의 기본 형식을 지정하기 위해서 사용한 개념이다. R은 S 언어에 대한 호환성을 보장하기 위해 모드라는 개념을 같이 혼용하여 사용하고 있다.
``` r
> typeof(a); mode(a)
[1] "logical"
[1] "logical"
> typeof(b); mode(b)
[1] "integer"
[1] "numeric"
> typeof(d); mode(d)
[1] "double"
[1] "numeric"
> typeof(e); mode(e)
[1] "character"
[1] "character"

> storage.mode(b)
[1] "integer"
> storage.mode(d)
[1] "double"
```
