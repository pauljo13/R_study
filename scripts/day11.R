# day 11
## lapply()
b <- list(1:5, 21:29, seq(2, 20, by=2)); b
mean(b[[1]])
mean(b[[3]])
lapply(b, mean)
lapply(b, mean)[[1]]
lapply(b, mean)[[3]]

lapply(b, max)
names(b) <- c("A", "B", "C")
lapply(b, range)

## sapply()
sapply(b, length)
sapply(b, range)
lb <- lapply(b, length)
typeof(lb)
sb <- sapply(b, length)
typeof(sb)

sapply(b, function(x){
  sum(x > 10)
})

## mapply()
a <- list(1:5, 10:5, letters[1:4])
b <- list(6:4, 4:7, LETTERS[5:1])
mapply(c, a, b)
a
b

mapply(rep, times=2:4, x=list(1:2, 11:12, 21:22))

# list
## lm
x <- lm(dist~speed, data = cars); x
typeof(x)
class(x)
names(x)
x$residuals
x$terms

## unclass()
unclass(x)

## data frame
head(cars)
typeof(cars)
class(cars)
unclass(cars)

y <- list(a = 11:15, b = letters[11:15]); y
typeof(y); class(y)
z <- as.data.frame(y); z
typeof(z); class(z)



#6 Data frame

