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
