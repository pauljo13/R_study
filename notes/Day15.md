___
# 8.5 그래프 계층(layers)과 도형(geoms)
`gglot2` 의 장점은 필요에 따라 다양한 형식의 그래프를 쉽게 만들 수 있고, 만들 수 있는 형식도 무궁무진하다는데 있다. ggplot2 그래프의 계층적 구조와 데이터 열과 속성을 자유롭게 매핑할 수 있다는 점이 핵심

##### geom 함수의 순서와 그래프 계층
ggplot2 좌표평면 위에 여러 계층으로 그래프를 그려서 하나의 좌표평명에 나타냄으로써 복잡한 형식의 그래프를 만들어 낼 수 있다.
``` R
> ggplot() + geom_point(mapping = aes(x=displ, y=hwy), data=mpg)
> ggplot() + geom_smooth(mapping = aes(x=displ, y=hwy), data=mpg)
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'

# 두개의 각기 다른 그래프를 합쳐서 그릴 수 있다.
> ggplot() + 
+   geom_point(mapping = aes(x=displ, y=hwy), data = mpg) +
+   geom_smooth(mapping = aes(x=displ, y=hwy), data = mpg)
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

##### ggplot() 함수는 좌표축을 자동 조정한다.
``` R
> ggplot() +
+   geom_point(mapping = aes(x=displ, y=hwy), data = mpg) +
+   geom_smooth(mapping = aes(x=displ, y=hwy), data = mpg) +
+   geom_point(mapping = aes(x=displ, y=cty), data = mpg, col="red", shape=1) +
+   geom_smooth(mapping = aes(x=displ, y=cty), data = mpg, linetype=2, col="red")
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

##### 여러 데이터를 사용하여 그래프 계층 만들기
지금까지 동일한 데이터에 대해서 geom 함수들이 그래프를 그렸다. 그러나 사실 각 계층의 geom 함수가 이용할 data와 mapping 을 독립적으로 설정할 수 있다.
``` R
> ggplot() +
+   geom_point(mapping = aes(x=displ, y=hwy), data = mpg) +
+   geom_smooth(mapping = aes(x=displ, y=hwy), data = mpg) +
+   geom_point(mapping = aes(x=displ, y=cty), data = mpg, col="red", shape=1) +
+   geom_smooth(mapping = aes(x=displ, y=cty), data = mpg, linetype=2, col="red") +
+   geom_point(mapping = aes(x=iris$Sepal.Length, y=iris$Sepal.Width), col="orange")
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

##### 다른 데이터 범위로 그래프 계층 만들기
``` R
> ggplot() +
+   geom_point(mapping=aes(displ, hwy), data=mpg) +
+   geom_point(mapping=aes(displ, hwy), 
+              data=filter(mpg, displ > 5, hwy > 20), 
+              color="red", size=2)
```


#### 공통 data 와 mapping 의 설정
지금까지 geom 함수에 data와 mapping 인수를 각각 설정하였다. 그런데 공통된 data 와 mapping을 사용하여 여러 층으로 그래프를 겹쳐 그리는 경우, 이러한 방식으로 data와 mapping 을 일일이 설정하는 것은 귀찮을 뿐 아니라 명령문의 오류 가능성을 증가시키고 변경을 어렵게 만든다.

##### ggplot() 함수에 공통 데이터와 매팅 설정하기
ggplot() 함수는 좌표평면을 생성하는 기능뿐 아니라, 그래프 계층에 공통된 data와 mapping 을 설정하는 기능도 가지고 있다. 다음 예에서는 배기량과 고속도로 연비의 산점도와 추세선을 공통된 data와 mapping 설정을 이용하여 그렸다. 주의할 점은 data와 mapping 인수의 위치가 geom 함수와 ggplot() 함수에서 반대라는 것이다.
``` R
> ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + geom_point() + geom_smooth()
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'

> ggplot(data = mpg, mapping = aes(x=displ, y=cty)) + geom_point() + geom_smooth()
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

##### geom 함수에서 데이터와 매핑의 재정의
- geom 함수는 `ggplot()` 함수에 설정된 `data`와 `mapping`을 상속받아 그래프를 그린다.
- 만약 geom 함수에 `data` 인수가 설정되면 `ggplot()` 함수에 설정된 `data`는 무시된다.
- 만약 geom 함수에 `mapping` 인수가 설정되면 `ggplot()` 함수에 설정된 `mapping`에 geom 함수에 설정된 `mapping`이 추가된다. 만약 동일한 도형 속성에 대한 정의가 두 군데 나타나면 geom 함수의 설정이 사용된다.
``` R
> ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + geom_point() + geom_smooth()
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
> ggplot(data = mpg, mapping = aes(x=displ, y=cty)) + geom_point() + geom_smooth()
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
> ggplot(data = mpg, mapping = aes(x=displ, y=hwy, color=drv)) + geom_point() + geom_smooth()
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
> ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + geom_point(mapping = aes(color=drv)) + geom_smooth()
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
> ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + geom_point() + geom_smooth(mapping = aes(color=drv))
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
> ggplot(data = mpg, mapping = aes(x=displ, y=hwy, color=drv)) + geom_point(mapping = aes(shape=drv)) + geom_smooth(mapping = aes(linetype=drv))
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
> ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) +
+   geom_point() + geom_smooth() +
+   geom_point(mapping = aes(y = cty), col="red", shape=1) +
+   geom_smooth(mapping = aes(y = cty), linetype=2, col="red")
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
> ggplot(data=mpg, mapping = aes(x=displ, y=hwy)) +
+   geom_point(aes(color=class)) +
+   geom_smooth(data = filter(mpg, class=="suv"))
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

##### ggplot() 과 geom 함수에서 대표 인수의 이름을 생량하기
지금까지 공통 데이터와 매핑을 ggplot() 함수에 기술하여 명령문을 단순화하였다. 그런데 이 명령문들은 더 단순화할 수 있다.
즉, 굳이 안수의 이름 없이 순서만 지켜서 대입하면 된다.
``` R
> ggplot(mpg, aes(displ, hwy)) +
+   geom_point() + geom_smooth() +
+   geom_point(aes(y=cty), col="red", shape=1) +
+   geom_smooth(aes(y=cty), linetype=2, col="red")
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```


# ggplot 명령문을 입력할 때 자주 발생하는 문제
ggplot 은 매우 강력한 기능을 가지고 있지만 Excel 등으 GUI 프로그램에만 익순한 사람은 문자 기반 명령어를 입력하는 것에 어려움을 느낄 수 있다. 컴퓨터는 사람만큼의 유연성을 발휘하지 못하므로 컴퓨터는 자신이 실행해야 할 명령문의 문법에 매우 까다롭게 반응한다.
- R 명령문은 대소문자를 구분한다. 따라서 `Color`와 `color`는 ggplot에서 서로 다른 인수로 인식되어 오류가 발생한다.
- ggplot 명령문의 키워드의 철자가 틀리면 다른 키워드로 간주하기 때문에 오류가 발생할 수 있다. 이를 방지하려면 키워드의 일부만 입력한 후 `Tab` 키를 눌러 자동완성 기능을 사용하여 입력하는 것을 권장한다.
- R 명령문이 조금 길어지면 가장 흔하게 발생하는 실수가 `( )`와 `" "`을 짝을 맞추어 제대로 입력하지 못하는 것이다. `ggplot2`의 명령문도 많은 함수를 사용하다 보니 이를 주의하여야 한다. R 콘솔은 명령이 계속 입력 중이라고 생각하여 `>`가 아니라 `+`를 콘솔의 프롬프트로 표시한다. 이 경우 가장 간단한 해결책은 `Esc` 키를 눌러 명령 입력에서 빠져나와 다시 명령문을 입력하는 것이다.
- `ggplot2`의 명령문을 입력할 때 여러 함수를 합쳐서 실행하기 위하여 `+` 연산자를 이용한다.[7](https://kilhwan.github.io/rprogramming/ch-visualization.html#fn7) `ggplot2`의 명령문이 길어지면 명령문을 여러 줄로 쓰는 것이 필요한데, 보통 `+`로 연결되는 곳에서 줄바꿈하는 것이 읽기에 좋다. 이 때 주의할 점이, 줄바꿈을 `+` 앞이 아니라 뒤에서 해야 한다는 것이다. `+` 앞에서 하면 R은 명령문의 입력이 완성된 것으로 간주하기 때문이다.
``` R
> ggplot(mpg, aes(displ, hwy, color=drv)) + geom_point() + geom_smooth()
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
> ggplot(mpg, aes(displ, hwy, color=drv)) + 
+   geom_point() + 
+   geom_smooth()
`geom_smooth()` using method = 'loess' and formula = 'y ~ x'
>   + geom_smooth()
Error in `+.gg`:
! Cannot use `+` with a single argument.
ℹ Did you accidentally put `+` on a new line?
Run `rlang::last_trace()` to see where the error occurred.
```


# 8.6 통계 변환
### 범주형 변수의 통계 요약
ggplot2 패키지의 diamonds 는 약 54,000개의 대한 측정데이터이다.
- `caret`: 다이아 몬드 무게
- `cut`: 가공의 품질. Fair, Good, Very Good, Premium, Ideal
- `color`: 색상. D(최상)에서 F(최하)까지
- `clarity`: 투명도. I1(최하), SI2, SI1, VS2, VS1, VVS2, VVS1, IF(최상)
- `x`, `y`, `z`: 길이, 폭, 깊이
- `depth`: 깊이 비율 = `z / mean(x, y)`
- `table`: 최대폭 대비 윗면의 폭의 길이 비율
``` R
> diamonds
# A tibble: 53,940 × 10
   carat cut       color clarity depth table price     x     y     z
   <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <int> <dbl> <dbl> <dbl>
 1  0.23 Ideal     E     SI2      61.5    55   326  3.95  3.98  2.43
 2  0.21 Premium   E     SI1      59.8    61   326  3.89  3.84  2.31
 3  0.23 Good      E     VS1      56.9    65   327  4.05  4.07  2.31
 4  0.29 Premium   I     VS2      62.4    58   334  4.2   4.23  2.63
 5  0.31 Good      J     SI2      63.3    58   335  4.34  4.35  2.75
 6  0.24 Very Good J     VVS2     62.8    57   336  3.94  3.96  2.48
 7  0.24 Very Good I     VVS1     62.3    57   336  3.95  3.98  2.47
 8  0.26 Very Good H     SI1      61.9    55   337  4.07  4.11  2.53
 9  0.22 Fair      E     VS2      65.1    61   337  3.87  3.78  2.49
10  0.23 Very Good H     VS1      59.4    61   338  4     4.05  2.39
# ℹ 53,930 more rows
# ℹ Use `print(n = ...)` to see more rows
> cut_table <- diamonds %>%
+   group_by(cut) %>%
+   summarize(n=n()) ; cut_table
# A tibble: 5 × 2
  cut           n
  <ord>     <int>
1 Fair       1610
2 Good       4906
3 Very Good 12082
4 Premium   13791
5 Ideal     21551
> ggplot(cut_table) + geom_col(aes(x=cut, y=n))
					==
> ggplot(diamonds) + geom_bar(aes(cut), stat="count")
`geom_bar()` 함수에서 `stat` 인수가 어떻게 작동하는지를 보여준다. `geom_bar()` 함수는 `stat` 인수에 `"count"`가 설정되면 `stat_count()` 함수를 사용하여 원래 데이터를 통계 요약한다. `stat_count()`는 `x`에 맵핑된 열을 수준(level; 구분되는 값) 별로 절대적 빈도와 상대적 빈도를 계산하여 `count`와 `prop`라는 열을 가지는 요약 데이터를 만든다. 그리고 이 요약 데이터를 이용하여 x-축에 원래 변수의 수준을, y-축에 `count` 변수를 맵핑하여 막대 그래프를 그린다.

ggplot(diamonds) + geom_bar(aes(x=color))
	- geom_bar() 함수는 stat는 count가 디폴드이다. 생략을 해도 count로 계산된다.
ggplot(diamonds) + geom_bar(aes(clarity, after_stat(prop), group=1))
	- prop : 상대 빈도수
	- after_stat() : 원래 데이터가 아닌 요약 데이터에서 찾아서 매핑한다.
```

### 수치형 변수의 통계 요약
``` R
- geom_bar는 모든 수치를 빈도로 계산하기에 연속형 변수에 적합하지 않다.
ggplot(diamonds) + geom_bar(aes(carat))

- stat = "bin" 으로 연속형 변수는 구분되는 값이 아니라 일정한 구간 별로 빈도를 계산하여 그린다.
ggplot(diamonds) + geom_bar(aes(carat), stat="bin")

- geom_histogram() : stat_bin()을 디폴트 stat로 사용하여 geom 함수이다.
> ggplot(diamonds) + geom_histogram(aes(carat))
`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
> ggplot(diamonds) + geom_histogram(aes(table), bins = 50)
	- bins & binwidth : 인수를 사용하여 구간의 수 또는 구간의 길이를 직접 지정하여 히스토그램을 그릴 수 있다.

- `stat_bin()`은 구간 별 절대 빈도수(count)뿐 아니라 구간의 밀도(density)와 빈도수와 밀도의 최대 값이 1이 되도록 규모를 변환한 ncount와 ndensity 변수도 생성한다. 그러므로 필요에 따라 이 값을 이용하여 히스토그램을 그림 수 있다.
> ggplot(diamonds) + geom_histogram(aes(x, after_stat(density)))
`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
> ggplot(diamonds) + geom_histogram(aes(y, after_stat(count)))
`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
> ggplot(diamonds) + geom_histogram(aes(z, after_stat(ndensity)))
`stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```
##### geom_boxplot()
geom_boxplot() 함수는 수치 변수를 4분위수와 이상치로 요약하여 그래프를 그려준다. 다음은 다이아몬드의 중량(carat) 변수에 대한 4분위수와 이상치를 상자 그래프로 표시한 예이다.
- 상자의 상단의 3분위수를 표현한다.
- 상자의 하단은 1분위수를 표현한다.
- 상자의 가운데 선분은 중위수(2분위수)를 표현한다.
- 상자의 상단과 하단의 길이를 inter-quartile range라고 하고 IQR이라고 표현한다.
- 일반적으로 3분위 수에서 1.5 IQR보다 큰 수치나, 1분위수에서 1.5 IQR보다 작은 수치는 이상치(outliers)라고 판단한다.
- 상자의 하단과 상단에 나타나는 선분은 1.5 IQR 내의 최소치와 최대치를 나타낸다.
- 상자의 상하단에서 1.5 IQR 바깥에 있는 데이터는 이상치로 보고 점으로 표시한다.
``` R
> ggplot(diamonds) + geom_boxplot(aes(y = carat))
> ggplot(diamonds) + geom_boxplot(aes(x = carat))
```

##### 수치형 변수의 범주별 통계요약
`geom_boxplot()` 함수는 상자그림으로 수치 데이터를 표현한다. 이 함수는 `stat`로 `stat_boxplot()`을 디폴트로 사용한다. `stat_boxplot()`은 `x`에 매핑된 열의 수준 별로 `y`에 매핑된 데이터를 모아서 상자그림에 필요한 통계량을 계산한다.
``` R
> ggplot(diamonds) + geom_boxplot(aes(cut, price))
> ggplot(diamonds) + geom_boxplot(aes(cut, carat), notch = T)

이 외에도 `stat_summary()`를 이용하면 연속형 변수 데이터를 범주별로 나누어 함수를 적용한 결과를 출력할 수 있다. `fun`, `fun.max`, `fun.min`에 각각 수치 변수를 요약할 함수를 지정하면 해당 함수로 수치의 값을 `y`, `ymax`, `ymin`이라는 변수로 요약한다. 다음은 가공품질(`cut`) 별로 다이아몬드의 깊이(`depth`)의 중위수, 최대값, 최소값을 점과 구간으로 나타낸 결과이다.
> ggplot(diamonds, aes(cut, depth)) +
+   stat_summary(fun=median, fun.max = max, fun.min = min)
```

# 8.7 위치 조정
geom_bar()는 막대의 색상과 관련된 fill, color, alpha 라는 속성으로 색, 테두리, 투명도를 조정할 수 있다.
``` R
ggplot(mpg) + geom_bar(aes(class), fill="dark blue")
	- 막대 내부를 칠함
ggplot(mpg) + geom_bar(aes(class), color="dark blue")
	- 막대 태두리 색
ggplot(mpg) + geom_bar(aes(class, fill = drv))

ggplot(mpg) + geom_bar(aes(class, fill = drv), position = "dodge")
ggplot(mpg) + geom_bar(aes(class, fill = drv), position = "fill")
ggplot(mpg) + geom_bar(aes(class, col = drv), position = "identity", alpha=0.1)
ggplot(mpg) + geom_freqpoly(aes(hwy, color=drv), position = "identity")
ggplot(mpg) + geom_freqpoly(aes(hwy, color=drv))
```

# 8.8 ggplot2 그래프의 종류
|함수|도형|도형의.속성|
|:--|:--|:--|
|geom_bar()|Bar chart|color, fill, alpha|
|geom_boxplot()|Box plot|color, fill, alpha, notch, width|
|geom_density()|Density plot|color, fill, alpha, linetype|
|geom_histogram()|Histogram|color, fill, alpha, linetype, binwidth|
|geom_hline()|Horizontal lines|color, alpha, linetype, size|
|geom_jitter()|Jittered points|color, size, alpha, shape|
|geom_line()|Line graph|color, alpha, linetype, size|
|geom_point()|Scatterplot|color, alpha, shape, size|
|geom_rug()|Rug plot|color, side|
|geom_smooth()|Fitted line|method, formula, color, fill, linetype, size|
|geom_text()|Text annotations|많은 옵션이 있으므로 도움말 참조|
|geom_violin()|Violin plot|color, fill, alpha, linetype|
|geom_vline()|Vertical lines|color, alpha, linetype, size|
한편 그래프는 데이터에 대한 시각적 표현이므로 표현하려는 데이터의 형식에 따라 그래프를 구분해 볼 수도 있다. 데이터의 각 변수는 크게 수치형 변수와 범주형 변수로 나누어 볼 수 있다. 앞으로 우리는 그래프에서 표현하려는 데이터가 무엇인지에 따라 다음처럼 그래프를 분류하여 살펴보고자 한다.

- 하나의 범주형 변수를 나타내는 그래프
- 하나의 수치형 변수를 나타내는 그래프
- 두 개의 범주형 변수의 관계를 나타내는 그래프
- 하나의 범주형 변수와 하나의 수치형 변수의 관계를 나타내는 그래프
- 두 개의 수치형 변수의 관계를 나타내는 그래프
- 세 개 이상의 변수의 관계를 나타내는 그래프

#### 직선을 그리는 그래픽 함수
직선을 그리는 그래픽 함수를 살펴보기 위해 mpg 데이터에 대한 도심 연비와 고속도로 연비를 나타내는 산점도 그래프를 고려해 보자
``` R
> p <- ggplot(mpg, aes(cty, hwy)) + geom_point(); p
> p + geom_vline(xintercept = mean(mpg$cty), linetype=2, color="red")
	- 수직선을 그린다.

> p1 <- p + geom_vline(xintercept = mean(mpg$cty), linetype=2, color="red") +
+   geom_hline(yintercept = mean(mpg$hwy), linetype=2, color="red"); p1
	- 수평선을 그린다.

> p1 + geom_abline(a=0, b=1, linetype=3, color="blue") +
+   scale_x_continuous(limits = c(0,45)) +
+   scale_y_continuous(limits = c(0,45))
	- `geom_abline()`은 절편이 `a`, 기울기가 `b`인 직선을 그래프에 그려준다
	- scale_x_continuous : 그래프의 x 축 값을 조정
	- scale_y_continuous : 그래프의 y 축 값을 조정
Warning message:
In geom_abline(a = 0, b = 1, linetype = 3, color = "blue") :
  Ignoring unknown parameters: `a` and `b`

```

##### 한 범주형 변수의 그래프
범주형 변수란 변수의 값이 몇 개의 정해진 범주로 한정되는 변수라고 할 수 있다. 예를 들어 gender라는 변수가 어떤 수업의 수강생의 성별 정보를 표현하고 있다면, 남자 또는 여자라는 두 가지 범주에 의해서 데이터가 표현될 것이다.
``` R
ggplot(data=데이터, mapping=aes(x=범주형.변수.이름)) + geom_bar()
ggplot(데이터, aes(범주형.변수.이름)) + geom_bar()
ggplot(데이터) + geom_bar(aes(범주형.변수.이름))
ggplot() + geom_bar(aes(범주형.변수.이름), 데이터)

```

``` R
unique(mpg$class)
ggplot(mpg, aes(class)) + geom_bar()
ggplot(mpg, aes(cyl)) + geom_bar()

unique(mpg$cty)
ggplot(mpg, aes(cty)) + geom_bar()
ggplot(mpg, aes(drv)) + geom_bar()
ggplot(mpg, aes(factor(drv, levels = c("f", "r", "4")))) +
  geom_bar() +
  labs(x="drv")
  
ggplot(mpg) + 
  geom_bar(aes(reorder(class, class, length))) +
  labs(x="calss")
	- reorder() 함수는 첫 번째 인수인 factor를 두 번째 인수로 주어진 벡터를 factor의 범주 별로 나누어 세 번째 인수로 주어진 함수를 적용한 결고의 순서로 정렬한다.
	- labs : 그래프 라벨에 들어갈 글자를 입력

ggplot(mpg) + 
  geom_bar(aes(reorder(class, class, function(x) -length(x)))) + labs(x="class")
ggplot(mpg) +
  geom_bar(aes(reorder(class, hwy, mean))) + labs(x="class")
```

``` R
> mpg %>%
+   group_by(class) %>%
+   summarise(hwy_mean = mean(hwy)) %>%
+   arrange(hwy_mean)
# A tibble: 7 × 2
  class      hwy_mean
  <chr>         <dbl>
1 pickup         16.9
2 suv            18.1
3 minivan        22.4
4 2seater        24.8
5 midsize        27.3
6 subcompact     28.1
7 compact        28.3


> ggplot(mpg, aes(class, fill=factor(year))) + geom_bar() + labs(fill = "year")
> ggplot(mpg, aes(class, fill=factor(year))) + geom_bar(position = "fill") + labs(fill = "year")

```
