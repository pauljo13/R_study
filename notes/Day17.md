___
##### 세 변수 이상의 그래프
3개 변수 이상의 관계를 파악하고자 할 때 조건부 그래프이다. 조건부 그래프는 관심의 대상인 한 변수의 분포 또는 두 변수의 관계가 다른 변수의 값이 변함에 따라 어떻게 변하는지를 보여준다. ggplot2 에서는 facet을 사용하여 이를 수행한다.
``` R
> ggplot(mpg, aes(displ, cty)) + 
+   geom_point() + geom_smooth(method = "lm") + 
+   facet_wrap(~drv)
`geom_smooth()` using formula = 'y ~ x'

> ggplot(mpg, aes(displ, cty)) + 
+   geom_point() + geom_smooth(method = "lm") + 
+   facet_wrap(~class)
`geom_smooth()` using formula = 'y ~ x'

- 3개 변수 이상의 관계를 파악할 때 조건부 그래프뿐 아니라, 산점도 상에서 색상 등의 다른 aethetics를 사용하여 제 3의 변수의 영향을 살펴볼 수도 있다.
> ggplot(mpg, aes(displ, cty, col=drv)) +
+   geom_point() + geom_smooth(method = "lm")
`geom_smooth()` using formula = 'y ~ x'

- 색상 등의 aesthetics를 제 3의 변수에 매핑하여 그래프를 그리는 것은 한 그래프에 그래프가 모두 함께 표시되어 비교가 쉬운 장점이 있다. 그러나 제 3의 변수가 여러 값을 가지거나 제3, 4, 5의 변수들이 관심있는 두 변수에 영향을 미치는 것을 살펴보려면 너무 그래프가 복잡해서 파악이 어려운 단점이 있다.
> ggplot(mpg, aes(displ, cty, col=drv, linetype=factor(year))) +
+   geom_point() + geom_smooth(method = "lm") + labs(linetype="year")
`geom_smooth()` using formula = 'y ~ x'

- facet을 사용하면 제3, 4 변수의 값에 따라 그래프 각각 그린 후 행과 열로 배치해 주므로 그래프를 좀 더 체계적으로 비교해 볼 수 있다.
> ggplot(mpg, aes(displ, cty)) + 
+   geom_point() + geom_smooth(method = "lm") +
+   facet_grid(year~drv)
`geom_smooth()` using formula = 'y ~ x'
```


# 8.9 그래프의 외양 바꾸기
ggplot2는 사용자가 데이터를 geom의 각 aesthetics 요소로 매핑하여 자동으로 가로축과 세로축의 스케일을 결정하고, 표시할 색상의 스케일도 결정하고, 축과 범례에 표시될 레이블도 결정하여 그래프를 그려준다. 이러한 ggplot2의 기능은 사용자가 그래프의 세부 사항이 아니라 그래프의 핵심적인 매핑과 형태에만 집중할 수 있게 해주므로 매우 편리하다.

#### 좌표축의 조정
ggplot2는 데이터가 x와 y aesthetics에 매핑되면, 이를 이용하여 가로축과 세로축의 축척scale 를 생성한다. `x`와 `y`에 매핑된 변수가 수치형 변수이면 `scale_x_continous()`와 `scale_y_continous()`가, 범주형 변수이면 `scale_x_discrete()`와 `scale_y_discrete()`가 사용되어 가로축과 세로축의 축척을 생성한다.
