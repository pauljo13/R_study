___
##### 한 수치형 변수의 그래
한 수치형 변수에서 일차적으로 확인해야 할 내용은 그 변수의 분포이다. 분포를 확인하는 가장 단순한 방법은 수치를 구간으로 나누어 빈도를 나타내는 히스토그램을 그려보는 것이다.
``` R
ggplot(mpg, aes(hwy)) + geom_histogram(binwidth = 2)
ggplot(mpg, aes(hwy)) + geom_histogram(binwidth = 1)
ggplot(mpg, aes(hwy, fill=drv)) + geom_histogram(binwidth = 1)

ggplot(mpg, aes(hwy)) + geom_freqpoly(binwidth=2)
ggplot(mpg, aes(hwy, color=drv)) + geom_freqpoly(binwidth=2)
```
`geom_histogram()`과 `geom_freqpoly()` 모두 디필트 `stat`로 `stat_bin()`을 이용하는데, 이 함수는 x로 매핑된 변수를 구간으로 나누어 구간별 빈도(`count`), 밀도(`density`), 최대값이 1로 조정된 빈도(`ncount`), 최대값이 1로 조정된 밀도(`ndensity`) 등을 산출한다. 특별한 지시가 없으면 `stat_bin()`은 `count` 변수를 y로 매핑하여 준다. 그리고 이 y 값을 `geom_histogram()`에서는 막대의 높이로, `geom_freqpoly()`에서는 선의 y 값으로 이용한다. `count` 대신 `density`를 이용하여 그래프를 그리고 싶으면, `aes()` 매핑에서 `y`가 `density`가 되도록 매핑하면 된다. 단, 이 때 stat 함수에 의해 계산된 변수는 `after_stat(요약변수)` 형태로 표시한다.

``` R 
ggplot(mpg, aes(hwy, after_stat(density), color=drv)) + geom_freqpoly(binwidth=2)
ggplot(mpg, aes(hwy)) + geom_density()
ggplot(mpg, aes(hwy, color=drv)) + geom_density()
```

##### 두 범주형 변수의 그래프
fill aesthetics에 다른 범주형 변수를 매핑하여 두 변수의 관계를 살펴보거나, 아니면 다음처럼 facet을 이용하여 한 범주형 변수의 값을 고정시켜 놓고 다른 범주형 변수에 대해 막대 그래프를 그려 두 변수의 관계를 살펴본다.
``` R
ggplot(mpg, aes(class)) + geom_bar() + facet_wrap(~drv)
ggplot(mpg, aes(class, after_stat(prop), group=drv)) + geom_bar() + facet_wrap(~drv)
ggplot(mpg, aes(class, drv)) + geom_point()
ggplot(mpg, aes(class, drv)) + geom_jitter(width = 0.2, height = 0.2)
ggplot(mpg, aes(class, drv)) + geom_count()
```

##### 범주형 변수와 수치형 변수의 그래프
범주형 변수와 수치형 변수의 관계를 살펴보는 가장 쉬운 방법은 범주형 변수에 따른 수치형 변수의 분포를 산점도로 나타내 보는 것이다.
``` R
> p <- ggplot(mpg, aes(class, cty))
> p + geom_point()

> p + geom_jitter(width = 0.2)
> p + geom_boxplot()
> p + geom_boxplot(notch = T)
Notch went outside hinges
ℹ Do you want `notch = FALSE`?
Notch went outside hinges
ℹ Do you want `notch = FALSE`?
Notch went outside hinges
ℹ Do you want `notch = FALSE`?

p + geom_boxplot(notch = T) + 
  stat_summary(fun=mean, color="red", size=5, shape= "*", geom = "point")
  - `stat_summary()`를 이용하면 범주별 평균을 구할 수 있고, geom 함수로는 `geom_point()`를 설정하여 범주별 평균을 상자 그림 위에 점으로 덧붙일 수 있다.

```

상자 그래프는 수치형 데이터를 분위수와 이상치로 요약된 정보를 주는 장점이 있지만 실제 분포를 파악하기 어렵다. 바이올린 차트는 상자 그래프의 이러한 단점을 보완해 준다. 바이롤린 차트는 수치 변수의 확률밀도를 추정하여 확률밀도가 높은 곳은 폭이 넓게, 확률밀도가 낮은 곳은 폭이 좁게 그래프를 그려주는데, 이 모향이 바이올린 모양을 닯아서 바이올린 차트라 한다.
``` R
p + geom_violin()
p + geom_boxplot(width=0.1) +
  geom_violin(alpha=0.3)
```

### 두 수치형 변수의 그래프
우리는 앞선 여러 예제에서 geom_point() 를 이용하여 두 수치형 변수의 산점도와 geom_smooth() 를 이용하여 평균 적합선을 그려보았다.

##### geom_text()
두 수치형 변수의 데이터를 나타낼 때, 점 대신 텍스트로 표현하고 싶을 때가 있다.
``` R
> df <- filter(mpg, class == "midsize", year == 2008)
> ggplot(df, aes(cty, hwy)) + geom_text(aes(label=model))
> ggplot(df, aes(cty, hwy)) + 
+   geom_text(aes(label=model), size=3,
+             position = position_jitter(width = 0.3, height = 0.3))
 - `position_jitter()` 함수를 이용하여 텍스트 위치에 임의적인 변동을 주어 같은 자리의 데이터가 겹치지 않도록 해 본다.

> ggplot(df, aes(cty, hwy)) + geom_text(aes(label=model), check_overlap = T)
> ggplot(df, aes(cty, hwy)) + geom_point() +
+   geom_text(aes(label=model), nudge_y = 0.3, size=3)
	- `position_jitter()`를 이용하여 임의로 위치로 텍스트를 조정할 수도 있다. 참고로 `position_jitter()`와 `nudge_x`/`nudge_y`는 함께 사용될 수 없다.
```

##### geom_label
geom_text() 와 거의 유사한데, 덱스트를 박스 안에 넣어 글자를 구별하기 좀 더 쉽도록 해준다.
``` R
ggplot(df, aes(cty, hwy)) + 
  geom_point() + 
  geom_label(aes(label=model), nudge_y=0.2, size=3)
```


##### geom_bin2d()
두 변수의 결합 분포를 확인하고 싶을 때는 geom_bin2d()를 이용하여 두 수치형 변수를 각각 구간으로 나눈 후, 각 셀별로 빈도수를 계산한다. 그리고 각 셀의 빈도에 따라 색상을 다르게 하여 그래프에 표시한다.
``` R
ggplot(mpg, aes(cty, hwy)) + geom_bin2d(binwidth=c(2,2))
```