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
ggplot(mpg, aes(hwy, color=drv)) + geom_density()


ggplot(mpg, aes(class)) + geom_bar() + facet_wrap(~drv)
ggplot(mpg, aes(class, after_stat(prop), group=drv)) + geom_bar() + facet_wrap(~drv)
ggplot(mpg, aes(class, drv)) + geom_point()
ggplot(mpg, aes(class, drv)) + geom_jitter(width = 0.2, height = 0.2)
ggplot(mpg, aes(class, drv)) + geom_count()


p <- ggplot(mpg, aes(class, cty))
p + geom_point()

p + geom_jitter(width = 0.2)

### boxplot
p + geom_boxplot()
p + geom_boxplot(notch = T)
p + geom_boxplot(notch = T) + 
  stat_summary(fun=mean, color="red", size=5, shape= "*", geom = "point")

### violin
p + geom_violin()
p + geom_boxplot(width=0.1) +
  geom_violin(alpha=0.3)


### geom_text
mpg
unique(mpg$class)
df <- filter(mpg, class == "midsize", year == 2008)
ggplot(df, aes(cty, hwy)) + geom_text(aes(label=model))
ggplot(df, aes(cty, hwy)) + 
  geom_text(aes(label=model), size=3,
            position = position_jitter(width = 0.3, height = 0.3))
ggplot(df, aes(cty, hwy)) + geom_text(aes(label=model), check_overlap = T)
ggplot(df, aes(cty, hwy)) + geom_point() +
  geom_text(aes(label=model), nudge_y = 0.3, size=3)

### geom_label()
ggplot(df, aes(cty, hwy)) + 
  geom_point() + 
  geom_label(aes(label=model), nudge_y=0.2, size=3)

### geom_bin2d()
ggplot(mpg, aes(cty, hwy)) + geom_bin2d(binwidth=c(2,2))
