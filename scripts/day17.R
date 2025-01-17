# Day 17
library(ggplot2)
library(dplyr)
# ggplot2 type
ggplot(mpg, aes(displ, cty)) + 
  geom_point() + geom_smooth(method = "lm") + 
  facet_wrap(~drv)

ggplot(mpg, aes(displ, cty)) + 
  geom_point() + geom_smooth(method = "lm") + 
  facet_wrap(~class)

ggplot(mpg, aes(displ, cty, col=drv)) +
  geom_point() + geom_smooth(method = "lm")

ggplot(mpg, aes(displ, cty, col=drv, linetype=factor(year))) +
  geom_point() + geom_smooth(method = "lm") + labs(linetype="year")

ggplot(mpg, aes(displ, cty)) + 
  geom_point() + geom_smooth(method = "lm") +
  facet_grid(year~drv)


midwest
p <- ggplot(midwest, aes(percwhite, percollege)) + geom_point()
p
p + scale_x_continuous(breaks = seq(0, 100, by=10), 
                       labels = paste0(seq(0, 100, by=10), "%"))
p + scale_x_continuous(breaks = seq(0, 100, by=10))
p + scale_x_continuous(labels = paste0(seq(0, 100, by=10), "%"))

p + scale_x_continuous(breaks = seq(0, 100, by=10), 
                       labels = paste0(seq(0, 100, by=10), "%"),
                       limits = c(60, 100)) +
  scale_y_continuous(name = "Percent college educated")

p + scale_x_continuous(position = "top") +
  scale_y_continuous(position = "right")

ap <- ggplot(midwest, aes(area, poptotal)) + geom_point() + 
  geom_smooth(method = "lm")
ap

ap + scale_y_continuous(trans = "log10")

p <- ggplot(mpg, aes(cty)) + geom_histogram(binwidth = 1); p
p + coord_flip()
p + coord_polar()
ggplot(mpg, aes(class, fill=drv)) + 
  geom_bar(position="fill") + coord_polar()


install.packages("gridExtra")
library(gridExtra)

p1 <- ggplot(mpg, aes(drv, displ)) + geom_jitter()
p2 <- ggplot(mpg, aes(drv, displ)) + geom_boxplot()
p3 <- ggplot(mpg, aes(drv, displ)) + geom_violin()
grid.arrange(p1, p2, p3, ncol=3)
grid.arrange(p1, p2, p3, nrow=2, ncol=2)
grid.arrange(p1, p2, p3, ncol=3, widths = c(0.5, 0.25, 0.25))
grid.arrange(p1, p2, p3, nrow=3, heights = c(0.25, 0.25, 0.5))
grid.arrange(p1, arrangeGrob(p2, p3, ncol = 2, widths = c(0.6, 0.4)), nrow=2, heights=c(0.4, 0.6))


p <- ggplot(mpg, aes(cty, hwy)) + geom_point()
ggsave(file="myplot.png", plot=p, width=5, height = 4)
