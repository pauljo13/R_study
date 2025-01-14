# Day 15
library(ggplot2)
library(dplyr)

ggplot() + geom_point(mapping = aes(x=displ, y=hwy), data=mpg)
ggplot() + geom_smooth(mapping = aes(x=displ, y=hwy), data=mpg)
ggplot() + 
  geom_point(mapping = aes(x=displ, y=hwy), data = mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy), data = mpg)

ggplot() +
  geom_point(mapping = aes(x=displ, y=hwy), data = mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy), data = mpg) +
  geom_point(mapping = aes(x=displ, y=cty), data = mpg, col="red", shape=1) +
  geom_smooth(mapping = aes(x=displ, y=cty), data = mpg, linetype=2, col="red")

head(iris)
ggplot() +
  geom_point(mapping = aes(x=displ, y=hwy), data = mpg) +
  geom_smooth(mapping = aes(x=displ, y=hwy), data = mpg) +
  geom_point(mapping = aes(x=displ, y=cty), data = mpg, col="red", shape=1) +
  geom_smooth(mapping = aes(x=displ, y=cty), data = mpg, linetype=2, col="red") +
  geom_point(mapping = aes(x=iris$Sepal.Length, y=iris$Sepal.Width), col="orange")

ggplot() +
  geom_point(mapping = aes(displ, hwy), data=mpg) +
  geom_point(mapping = aes(displ, hwy),data=filter(mpg, displ > 5, hwy > 20),color="red", size=2)

ggplot() +
  geom_point(mapping=aes(displ, hwy), data=mpg) +
  geom_point(mapping=aes(displ, hwy), 
             data=filter(mpg, displ > 5, hwy > 20), 
             color="red", size=2)


ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + geom_point() + geom_smooth()
ggplot(data = mpg, mapping = aes(x=displ, y=cty)) + geom_point() + geom_smooth()


ggplot(data = mpg, mapping = aes(x=displ, y=hwy, color=drv)) + geom_point() + geom_smooth()
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + geom_point(mapping = aes(color=drv)) + geom_smooth()
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) + geom_point() + geom_smooth(mapping = aes(color=drv))
ggplot(data = mpg, mapping = aes(x=displ, y=hwy, color=drv)) + geom_point(mapping = aes(shape=drv)) + geom_smooth(mapping = aes(linetype=drv))
ggplot(data = mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point() + geom_smooth() +
  geom_point(mapping = aes(y = cty), col="red", shape=1) +
  geom_smooth(mapping = aes(y = cty), linetype=2, col="red")
ggplot(data=mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point(aes(color=class)) +
  geom_smooth(data = filter(mpg, class=="suv"))

ggplot(mpg, aes(displ, hwy)) +
  geom_point() + geom_smooth() +
  geom_point(aes(y=cty), col="red", shape=1) +
  geom_smooth(aes(y=cty), linetype=2, col="red")

ggplot(mpg, aes(displ, hwy, color=drv)) + geom_point() + geom_smooth()
ggplot(mpg, aes(displ, hwy, color=drv)) + 
  geom_point() + 
  geom_smooth()
ggplot(mpg, aes(displ, hwy, color=drv)) 
  + geom_point() 


# Statistical transformation
diamonds
cut_table <- diamonds %>%
  group_by(cut) %>%
  summarize(n=n()) ; cut_table
ggplot(cut_table) + geom_col(aes(x=cut, y=n))
ggplot(diamonds) + geom_bar(aes(cut), stat="count")

ggplot(diamonds) + geom_bar(aes(x=color))
ggplot(diamonds) + geom_bar(aes(clarity, after_stat(prop), group=1))

ggplot(diamonds) + geom_bar(aes(carat))
ggplot(diamonds) + geom_bar(aes(carat), stat="bin")
ggplot(diamonds) + geom_histogram(aes(carat))
ggplot(diamonds) + geom_histogram(aes(table), bins = 50)
ggplot(diamonds) + geom_histogram(aes(price), binwidth = 500)
ggplot(diamonds) + geom_histogram(aes(x, after_stat(density)))
ggplot(diamonds) + geom_histogram(aes(y, after_stat(count)))
ggplot(diamonds) + geom_histogram(aes(z, after_stat(ndensity)))


ggplot(diamonds) + geom_boxplot(aes(y = carat))
ggplot(diamonds) + geom_boxplot(aes(x = carat))

ggplot(diamonds) + geom_boxplot(aes(cut, price))
ggplot(diamonds) + geom_boxplot(aes(cut, carat), notch = T)
ggplot(diamonds, aes(cut, depth)) +
  stat_summary(fun=median, fun.max = max, fun.min = min)


ggplot(mpg) + geom_bar(aes(class), fill="dark blue")
ggplot(mpg) + geom_bar(aes(class), color="dark blue")
ggplot(mpg) + geom_bar(aes(class, fill = drv))
ggplot(mpg) + geom_bar(aes(class, fill = drv), position = "dodge")
ggplot(mpg) + geom_bar(aes(class, fill = drv), position = "fill")
ggplot(mpg) + geom_bar(aes(class, col = drv), position = "identity", alpha=0.1)
ggplot(mpg) + geom_freqpoly(aes(hwy, color=drv), position = "identity")
ggplot(mpg) + geom_freqpoly(aes(hwy, color=drv))


p <- ggplot(mpg, aes(cty, hwy)) + geom_point(); p
p + geom_vline(xintercept = mean(mpg$cty), linetype=2, color="red")
p1 <- p + geom_vline(xintercept = mean(mpg$cty), linetype=2, color="red") +
  geom_hline(yintercept = mean(mpg$hwy), linetype=2, color="red"); p1
p1 + geom_abline(a=0, b=1, linetype=3, color="blue") +
  scale_x_continuous(limits = c(0,45)) +
  scale_y_continuous(limits = c(0,45))



