# Day 16
library(ggplot2)
library(dplyr)
mpg %>%
  group_by(class) %>%
  summarise(hwy_mean = mean(hwy)) %>%
  arrange(hwy_mean)
ggplot(mpg, aes(class, fill=factor(year))) + geom_bar() + labs(fill = "year")

ggplot(mpg, aes(class, fill=factor(year))) + geom_bar(position = "fill") + labs(fill = "year")


ggplot(mpg, aes(hwy)) + geom_histogram(binwidth = 2)
ggplot(mpg, aes(hwy)) + geom_histogram(binwidth = 1)
ggplot(mpg, aes(hwy, fill=drv)) + geom_histogram(binwidth = 1)

ggplot(mpg, aes(hwy)) + geom_freqpoly(binwidth=2)
ggplot(mpg, aes(hwy, color=drv)) + geom_freqpoly(binwidth=2)
ggplot(mpg, aes(hwy, after_stat(density), color=drv)) + geom_freqpoly(binwidth=2)
ggplot(mpg, aes(hwy)) + geom_density()
