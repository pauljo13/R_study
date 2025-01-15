___
##### 한 수치형 변수의 그래
한 수치형 변수에서 일차적으로 확인해야 할 내용은 그 변수의 분포이다. 분포를 확인하는 가장 단순한 방법은 수치를 구간으로 나누어 빈도를 나타내는 히스토그램을 그려보는 것이다.
``` R
ggplot(mpg, aes(hwy)) + geom_histogram(binwidth = 2)
ggplot(mpg, aes(hwy)) + geom_histogram(binwidth = 1)
ggplot(mpg, aes(hwy, fill=drv)) + geom_histogram(binwidth = 1)

ggplot(mpg, aes(hwy)) + geom_freqpoly(binwidth=2)
ggplot(mpg, aes(hwy, color=drv)) + geom_freqpoly(binwidth=2)
ggplot(mpg, aes(hwy, after_stat(density), color=drv)) + geom_freqpoly(binwidth=2)
ggplot(mpg, aes(hwy)) + geom_density()
```