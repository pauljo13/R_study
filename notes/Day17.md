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
- name: 축의 이름
- breaks: 축에 표시될 눈금의 위치
- minor_breaks: 축에 표시될 세부 눈금의 위치
- labels: 축 눈금에 씌여질 레이블
- limits: 축의 상한과 하한
- trans: 축에 별도의 변환을 적용할지 여부
- position: 축의 그래프 상에서의 위치 등
``` R
> midwest
# A tibble: 437 × 28
     PID county    state  area poptotal popdensity popwhite popblack popamerindian popasian popother percwhite percblack
   <int> <chr>     <chr> <dbl>    <int>      <dbl>    <int>    <int>         <int>    <int>    <int>     <dbl>     <dbl>
 1   561 ADAMS     IL    0.052    66090      1271.    63917     1702            98      249      124      96.7    2.58  
 2   562 ALEXANDER IL    0.014    10626       759      7054     3496            19       48        9      66.4   32.9   
 3   563 BOND      IL    0.022    14991       681.    14477      429            35       16       34      96.6    2.86  
 4   564 BOONE     IL    0.017    30806      1812.    29344      127            46      150     1139      95.3    0.412 
 5   565 BROWN     IL    0.018     5836       324.     5264      547            14        5        6      90.2    9.37  
 6   566 BUREAU    IL    0.05     35688       714.    35157       50            65      195      221      98.5    0.140 
 7   567 CALHOUN   IL    0.017     5322       313.     5298        1             8       15        0      99.5    0.0188
 8   568 CARROLL   IL    0.027    16805       622.    16519      111            30       61       84      98.3    0.661 
 9   569 CASS      IL    0.024    13437       560.    13384       16             8       23        6      99.6    0.119 
10   570 CHAMPAIGN IL    0.058   173025      2983.   146506    16559           331     8033     1596      84.7    9.57  
# ℹ 427 more rows
# ℹ 15 more variables: percamerindan <dbl>, percasian <dbl>, percother <dbl>, popadults <int>, perchsd <dbl>, percollege <dbl>,
#   percprof <dbl>, poppovertyknown <int>, percpovertyknown <dbl>, percbelowpoverty <dbl>, percchildbelowpovert <dbl>,
#   percadultpoverty <dbl>, percelderlypoverty <dbl>, inmetro <int>, category <chr>
# ℹ Use `print(n = ...)` to see more rows
	- area: 면적
	- poptotal: 총 인수수
	- popdensity: 인구밀도
	- popwhite: 백인 거주자수
	- popblack: 흑인 거주자수
	- popamerindian: 인디언 거주자수 popasian: 아시아인 거주자수
	- popother: 다른 인종 거주자수
	- percwhite, percwhite, percamerindan, percasian, percother: 각 인종의 비율
	- popadults: 성인 거주자수
	- percollege: 대학 졸업자 비율
	- percprof: 전문직 비율

> p <- ggplot(midwest, aes(percwhite, percollege)) + geom_point()
> p
> p + scale_x_continuous(breaks = seq(0, 100, by=10), 
+                        labels = paste0(seq(0, 100, by=10), "%"))
> p + scale_x_continuous(breaks = seq(0, 100, by=10))
> p + scale_x_continuous(labels = paste0(seq(0, 100, by=10), "%"))
Error in `scale_x_continuous()`:
! `breaks` and `labels` have different lengths.
Run `rlang::last_trace()` to see where the error occurred.


> p + scale_x_continuous(breaks = seq(0, 100, by=10), 
+                        labels = paste0(seq(0, 100, by=10), "%"),
+                        limits = c(60, 100)) +
+   scale_y_continuous(name = "Percent college educated")
Warning message:
Removed 2 rows containing missing values or values outside the scale range (`geom_point()`).


> p + scale_x_continuous(position = "top") +
+   scale_y_continuous(position = "right")


> ap + scale_y_continuous(trans = "log10")
`geom_smooth()` using formula = 'y ~ x'
```

##### 좌표계의 변경
``` R
> p <- ggplot(mpg, aes(cty)) + geom_histogram(binwidth = 1); p

- coord_flip() 함수는 그래프의 가로축과 세로축을 바꾸어 준다.
> p + coord_flip()

- coord_polar()는 직교좌표계를 극좌표계로 변경해 준다
> p + coord_polar() 
> ggplot(mpg, aes(class, fill=drv)) + 
  geom_bar(position="fill") + coord_polar()
```


##### 색상 척도(color scales) 변경
1. **자동 색상 매핑**
    
    - ggplot2는 `color` 또는 `fill` 속성에 매핑된 데이터가 **연속형**인지 **이산형**인지에 따라 자동으로 색상을 지정함.
    - **연속형 변수**: 색상 그라데이션 사용.
    - **이산형 변수**: 구분되는 색상 사용.
2. **이산형 변수 처리**
    
    - 수치형 데이터가 이산형 데이터인 경우, `factor()`로 변환하여 올바르게 매핑 가능.
    
    ```R
    p + geom_point(aes(color=factor(year)), size=2)
    ```
    
3. **색상 팔레트 변경**
    
    - **이산형 변수**: `scale_color_brewer()` 사용 (e.g., "Set1", "Accent").
    - **연속형 변수**: `scale_color_distiller()` 사용 (e.g., "RdPu", "Greens").
    
    ```R
    p_drv + scale_color_brewer(palette = "Set1")
    p_cty + scale_color_distiller(palette = "Greens")
    ```
    
4. **팔레트 정보 확인**
    
    - `RColorBrewer::display.brewer.all()`: 사용 가능한 팔레트 시각화.
    - `RColorBrewer::brewer.pal.info`: 팔레트 상세 정보 제공.

---

### 레이블 조정

- `labs()`를 사용해 그래프 제목, 축 이름, 범례 이름을 수정.
    
    ```R
    p + labs(title="Graph Title", x="X Axis", y="Y Axis", color="Legend")
    ```
    

---

### 테마 변경

1. **기본 제공 테마**
    
    - ggplot2는 다양한 기본 테마 제공:
        - `theme_gray()`, `theme_bw()`, `theme_minimal()` 등.
    
    ```R
    p + theme_classic()
    ```
    
2. **ggthemes 확장 테마**
    
    - `ggthemes` 패키지를 설치하면 추가 테마 사용 가능:
        - `theme_economist()`, `theme_excel()`, `theme_tufte()`, 등.
3. **테마 설정 변경**
    
    - 특정 테마를 모든 그래프에 일괄 적용하려면:
        - `theme_set()`: 기본 테마 변경.
        - `theme_get()`: 현재 테마 저장 및 복원.
    
    ```R
    oldTheme <- theme_get()
    theme_set(theme_classic())
    theme_set(oldTheme)  # 복원
    ```
    
4. **테마 요소 수정**
    
    - `theme()` 함수로 테마 세부 요소 조정:
        
        - 범례 위치, 배경색, 글자 스타일 등.
        
        ```R
        myTheme <- theme(
            plot.title = element_text(size=16, face="bold.italic"),
            panel.background = element_rect(fill="lightyellow"),
            legend.position = "top"
        )
        p + myTheme
        ```
        
5. **테마 업데이트**
    
    - `theme_update()`로 기본 테마 요소 일부 변경 가능.
    
    ```R
    oldTheme <- theme_update(
        plot.title = element_text(size=16, face="bold.italic"),
        panel.background = element_rect(fill="lightyellow"),
        legend.position = "top"
    )
    theme_set(oldTheme)  # 복원
    ```

# 기타 유용한 팁들
##### 여러 그래프를 한 도표에 넣기
ggplot2에서 그린 여러 그래프를 한 도표에 넣으려면 gridExtra 패키지의 grid.arrange() 함수를 이용하면 편리하다.
``` R
# 설치
install.packages("gridExtra")

# 탑재
library(gridExtra)

p1 <- ggplot(mpg, aes(drv, displ)) + geom_jitter()
p2 <- ggplot(mpg, aes(drv, displ)) + geom_boxplot()
p3 <- ggplot(mpg, aes(drv, displ)) + geom_violin()
grid.arrange(p1, p2, p3, ncol=3)
grid.arrange(p1, p2, p3, nrow=2, ncol=2)
grid.arrange(p1, p2, p3, ncol=3, widths = c(0.5, 0.25, 0.25))
grid.arrange(p1, p2, p3, nrow=3, heights = c(0.25, 0.25, 0.5))
grid.arrange(p1, arrangeGrob(p2, p3, ncol = 2, widths = c(0.6, 0.4)), nrow=2, heights=c(0.4, 0.6))

```

# 그래프 저장하기
RStudio 사용자가 R에서 그린 그래프를 저장하려면, RStudio의 [Plot] 패널에서 [Export]-[Save as Image…] 메뉴를 이용하면 된다. 이 메뉴를 사용하면 그래프를 저장할 파일 형식, 위치, 이름, 크기를 지정하여 저장할 수 있다. R 콘솔에서 그래프를 저장하려면 다음처럼 `ggsave()` 함수를 이용한다.
``` R
p <- ggplot(mpg, aes(cty, hwy)) + geom_point()
ggsave(file="myplot.png", plot=p, width=5, height = 4)
```

