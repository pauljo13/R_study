___
# Chapter 8 ggplot2를 이용한 데이터 시각화

ggplot2 패키지는 시각화 패키지로 tidyverse 패키지로 설치 할 수 있다.
``` R
> library(tidyverse)
── Attaching core tidyverse packages ────────────────────────────────────────────────────────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.1.4     ✔ readr     2.1.5
✔ forcats   1.0.0     ✔ stringr   1.5.1
✔ ggplot2   3.5.1     ✔ tibble    3.2.1
✔ lubridate 1.9.4     ✔ tidyr     1.3.1
✔ purrr     1.0.2     
── Conflicts ──────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
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

# ggplot2 
ggplot2에서 제공하는 mpg 데이터를 이용하여 '베기량이 커지면 연비가 낮아지는지?' 라는 물음을 그래프를 이용하여 탐색한다.
``` R
> mpg
# A tibble: 234 × 11
   manufacturer model      displ  year   cyl trans      drv     cty   hwy fl    class  
   <chr>        <chr>      <dbl> <int> <int> <chr>      <chr> <int> <int> <chr> <chr>  
 1 audi         a4           1.8  1999     4 auto(l5)   f        18    29 p     compact
 2 audi         a4           1.8  1999     4 manual(m5) f        21    29 p     compact
 3 audi         a4           2    2008     4 manual(m6) f        20    31 p     compact
 4 audi         a4           2    2008     4 auto(av)   f        21    30 p     compact
 5 audi         a4           2.8  1999     6 auto(l5)   f        16    26 p     compact
 6 audi         a4           2.8  1999     6 manual(m5) f        18    26 p     compact
 7 audi         a4           3.1  2008     6 auto(av)   f        18    27 p     compact
 8 audi         a4 quattro   1.8  1999     4 manual(m5) 4        18    26 p     compact
 9 audi         a4 quattro   1.8  1999     4 auto(l5)   4        16    25 p     compact
10 audi         a4 quattro   2    2008     4 manual(m6) 4        20    28 p     compact
# ℹ 224 more rows
# ℹ Use `print(n = ...)` to see more rows
> ggplot() + geom_point(mapping = aes(x = displ, y = hwy), data = mpg)
	- ggplot() : ggplot2 그래프의 좌표축과 좌표평면을 만드는 함수이다.
	- geom_point() : ggplot()  함수가 만들어 놓은 좌표명면 위에, 점이라는 동형을 이용하여 그래프를 그린다. 
	- ggplot2 : 입력할 때 여러 함수를 합쳐서 실행하기 위해여 + 연산자를 이용한다., dplyr 패키지의 파이프연산자와 유사한 역할을 한다.
	- data : 도형으로 표현할 데이터 프레임
	- mapping : 도형의 시각적 속성과 data에 지정된 데이터 프레임의 열을 쌍으로 대응시킨다.
		- aes() 함수 내에 <도형속성> = <데이터 열 이름> 형식으로 기술한다.
```


# 도형의 속성에 데이터 열을 대응시키기(aesthetic mapping)

##### color 속성
color = 열 이름, 열에 있는 종류에 개수 만큼 색을 다르게 해서 표현
``` R
ggplot() + geom_point(mapping = aes(x = displ, y = hwy, color = class), data = mpg)

```

##### shape 속성
shape 속성으로 점의 모양을 결정 할 수 있다.
! : 최대 6개의 모양으로만 구분된다.
``` R
ggplot() + geom_point(mapping = aes(x = displ, y = hwy, shape = drv), data = mpg)

ggplot() + geom_point(mapping = aes(x = displ, y = hwy, shape = class), data = mpg)
Warning messages:
1: The shape palette can deal with a maximum of 6 discrete values because more than 6 becomes difficult to discriminate
ℹ you have requested 7 values. Consider specifying shapes manually if you need that many have them. 
2: Removed 62 rows containing missing values or values outside the scale range (`geom_point()`). 
```

##### 연속형 변수를 size, alpha, color 속성 매핑
``` R
size : 점의 크기가 변수의 값에 의해 커지거나 작아진다.
ggplot() + geom_point(mapping = aes(x = cty, y = hwy, size = displ), data = mpg)

color : 할당한 값이 연속형 변수인 경우 색의 채도로 표시된다.
ggplot() + geom_point(mapping = aes(x = cty, y = hwy, color = displ), data = mpg)

alpha : 할당한 값에 따라 점의 투명도가 달라진다.
ggplot() + geom_point(mapping = aes(x = cty, y = hwy, alpha = displ), data = mpg)

> ggplot() + geom_point(mapping = aes(x = displ, y = hwy, size=class), data = mpg)
Warning message:
Using size for a discrete variable is not advised. 
```

##### 도형의 여러 속성에 데이터 열을 매핑
``` R
ggplot() + geom_point(mapping = aes(x = displ, y = hwy, color=drv, shape=drv), data = mpg)

ggplot() + geom_point(mapping = aes(x=cty, y=hwy, color=drv, shape=drv), data = mpg)

> head(iris)
  Sepal.Length Sepal.Width Petal.Length Petal.Width Species
1          5.1         3.5          1.4         0.2  setosa
2          4.9         3.0          1.4         0.2  setosa
3          4.7         3.2          1.3         0.2  setosa
4          4.6         3.1          1.5         0.2  setosa
5          5.0         3.6          1.4         0.2  setosa
6          5.4         3.9          1.7         0.4  setosa
> ggplot() + geom_point(mapping = aes(x=Sepal.Length, y=Sepal.Width, color=Species, shape=Species), data = iris)
> ggplot() + geom_point(mapping = aes(x=iris$Sepal.Length, y=iris$Sepal.Width, color=iris$Species, shape=iris$Species))
```

#### 도형의 속성에 대응시키기 vs. 도형의 속성 인수를 설정
##### 도형의 속성 인수 설정
점의 속성에 데이터 열을 대응시켜 관측치의 값에 따라 점을 시각적으로 표현할 수도 있지만, 데이터와 상관없이 직접 속성값을 설정할 수 있다.
``` R
> ggplot() + geom_point(mapping = aes(x=displ, y=hwy), data=mpg, color="blue")
```
- `color` 인수: 색상의 이름이 문자열로 부여된다. 부여할 수 있는 생상의 이름을 확인하려면 `colors()` 함수를 실행해 본다.
- `size` 인수: 점의 크기가 mm 단위로 설정된다.
- `shape` 인수: 표시할 문자를 직접 설정할 수도 있고, 0에서 24까지의 숫자로도 지정할 수 있다. 다음은 `color="red"`와 `fill="blue"`로 인수가 설정되었을 때 `shape` 인수의 값에 따라 점의 모양을 보여준다.
##### 도형의 속성 인수를 속성 대응시키기에 잘못 설정하는 경우
``` R
ggplot() + geom_point(mapping = aes(x=displ, y=hwy, color="blue"), data=mpg)
```
`aes()` 함수 안에 설정되었기 때문에 ggplot은 `color="blue"`를 `color` 속성에 “blue”라는 하나의 값을 가진 열이 대응된 것으로 간주한다. 그러므로 이 값에 적절한 색-이 예에서는 빨간색-을 대응시켜 점을 표시한 후, 범례에 blue라는 값이 빨간색으로 대응되었음을 표시하였다. 따라서 도형 속성을 데이터 열에 대응시키기와 도형의 속성 인수를 설정하는 것을 구분하여 사용하지 않으면 이렇듯 엉뚱한 결과를 얻을 수 있으므로 주의가 필요하다.

### group 속성
도형의 시각적 속성을 직접 변형하는 것이 아니라, 도형을 그릴 때 데이터를 어떤 식으로 그룹으로 묶어 사용할지만 지정한다. 이를 통해 그래프의 전체 모양에 영향을 준다.

##### 그룹으로 나누어 선 그래프 그리기
``` R
Orange
names(Orange)
ggplot() + geom_point(mapping = aes(x=age, y=circumference), data = Orange)
ggplot() + geom_line(mapping = aes(x=age, y=circumference), data = Orange)
ggplot() + geom_line(mapping = aes(x=age, y=circumference, group= Tree), data = Orange)
- `Tree`의 값에 따라 그룹으로 묶여 선이 각각 그려졌음
```
##### 이산형 변수는 group 속성으로 자동 매핑된다.
``` R
> Orange$Tree
 [1] 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3 3 3 3 3 3 4 4 4 4 4 4 4 5 5 5 5 5 5 5
Levels: 3 < 1 < 5 < 2 < 4
> ggplot() + geom_line(mapping = aes(x=age, y=circumference, group=Tree, color=Tree), data =Orange)
> ggplot()
> ggplot() + geom_line(mapping = aes(x=Orange$age, y=Orange$circumference, color=Orange$Tree))
> ggplot() + geom_line(mapping = aes(x=Orange$age, y=Orange$circumference, linetype=Orange$Tree))
```

##### geom_smooth() 함수에서 group 속성
geom_smooth 함수는 group에 매핑된 정보에 따라 데이터를 그룹화하여 추세선을 그린다.
``` R
> ggplot() + geom_smooth(mapping = aes(x=age, y=circumference), data=Orange)
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
> ggplot() + geom_smooth(mapping = aes(x=age, y=circumference, color=Tree), data = Orange)
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
> ggplot() + geom_smooth(mapping = aes(x=age, y=circumference, color=Tree), data = Orange, se=F)
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
	- se = FALSE : 신뢰구간이 표시되지 않도록 설정가능
```


# facets으로 나누어 그리기
원래 그래프를 또 다른 변수의 측면에서 세분화하거나 해당 변수값에 따른 다른 열들을 대입할 때 facets 로 여러 그래프를 나누어 그릴 수 있다.
##### facet_wrap() 일차원 측면 그래프 그리시
`facet_wrap()` 함수는 `~` 우변에 기술된 변수를 측면(facets)으로 하여 데이터를 나누어 그래프를 그린다. 이 때 측면(facets)으로 사용되는 변수는 범주형 데이터이어야 한다.
`ncol`이나 `ncol`을 설정하면 그래프의 행과 열의 수를 지정
두 개 이상의 변수를 조합하여 측면을 만드려면 다음처럼 수식의 우변에 두 개의 변수를 `+`로 연결
``` R
> ggplot() + 
+   geom_point(mapping = aes(x=displ, y=hwy), data=mpg) +
+   facet_wrap(~class, nrow = 2)

> ggplot() + 
+   geom_point(mapping = aes(x=displ, y=hwy), data=mpg) +
+   facet_wrap(~drv + year, nrow = 2)
```

##### facet_grid() 이차원 측면 그래프 그리기
원래 그래프를 두 변수의 측면에서 나누어 그리기를 하려면 `facet_grid()`를 사용하는 것이 좋다. `facet_grid()`도 수식은 인수로 입력 받는데, 수식의 좌변과 우변에 데이터의 변수를 지정할 수 있다. 그러면 수식의 좌변에 기술된 변수를 그래프의 행으로, 우변에 기술된 변수를 그래프의 열로 하여 측면 그래프를 그린다.
``` R
> ggplot() + geom_point(mapping = aes(x=displ, y=hwy), data = mpg) +
+   facet_grid(drv~cyl)
> ggplot() + geom_point(mapping = aes(x=displ, y=hwy), data=mpg) +
+   facet_grid(drv+year~cyl)
```