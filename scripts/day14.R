# Day 14
library(tidyverse)
mpg
ggplot() + geom_point(mapping = aes(x = displ, y = hwy), data = mpg)

x <- c(10:30)
y <- seq(length = length(x), from = 5, by = 1)
ggplot() + geom_point(mapping = aes(x = x, y =y))

ggplot() + geom_point(mapping = aes(x = displ, y = hwy, color = class), data = mpg)
ggplot() + geom_point(mapping = aes(x = displ, y = hwy, shape = drv), data = mpg)
ggplot() + geom_point(mapping = aes(x = displ, y = hwy, shape = class), data = mpg)


ggplot() + geom_point(mapping = aes(x = cty, y = hwy, size = displ), data = mpg)
ggplot() + geom_point(mapping = aes(x = cty, y = hwy, color = displ), data = mpg)
ggplot() + geom_point(mapping = aes(x = cty, y = hwy, alpha = displ), data = mpg)

ggplot() + geom_point(mapping = aes(x = displ, y = hwy, size=class), data = mpg)
ggplot() + geom_point(mapping = aes(x = displ, y = hwy, alpha=class), data = mpg)                      

ggplot() + geom_point(mapping = aes(x = displ, y = hwy, color=drv, shape=drv), data = mpg)

ggplot() + geom_point(mapping = aes(x=cty, y=hwy, color=drv, shape=drv), data = mpg)

head(iris)
ggplot() + geom_point(mapping = aes(x=Sepal.Length, y=Sepal.Width, color=Species, shape=Species), data = iris)
ggplot() + geom_point(mapping = aes(x=iris$Sepal.Length, y=iris$Sepal.Width, color=iris$Species, shape=iris$Species))


ggplot() + geom_point(mapping = aes(x=displ, y=hwy), data=mpg, color="blue")
ggplot() + geom_point(mapping = aes(x=displ, y=hwy, color="blue"), data=mpg)

### group
Orange
names(Orange)
ggplot() + geom_point(mapping = aes(x=age, y=circumference), data = Orange)
ggplot() + geom_line(mapping = aes(x=age, y=circumference), data = Orange)
ggplot() + geom_line(mapping = aes(x=age, y=circumference, group= Tree), data = Orange)


Orange$Tree
ggplot() + geom_line(mapping = aes(x=age, y=circumference, group=Tree, color=Tree), data =Orange)
ggplot() + geom_line(mapping = aes(x=Orange$age, y=Orange$circumference, color=Orange$Tree))
ggplot() + geom_line(mapping = aes(x=Orange$age, y=Orange$circumference, linetype=Orange$Tree))







