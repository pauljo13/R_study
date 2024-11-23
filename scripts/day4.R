# Vector
## numbers vector
### c()
y <- c(2, 4, 6, 8, 10)
y

x <- c(1,3,5,7,9.2)
x

z <- c(x, y)
z

w <- c(x,y,z)
w


### pattern
#### n:m
1:10

10 : 1

-4:8

0.7:8

2.3:-5


#### seq()
seq(5,15)

seq(5, 15, by = 2)

seq(length = 10, from = -3, by = 0.5)

y
seq(along = y)


#### rep()
y = c(1:5, 0:-5)
y
rep(y, times = 2)

rep(1, times = 10)

rep(y, each = 2)


# Elementwise operation
x = seq(length = 5, from = 0, by = 10)
x
y = 1:5
y
x + y
x - y
x * y
x / y


# recycling
z = rep(x, times = 2)
z
z + y

w = c(z, 50)
w
w + y

x = 1:5
10 * x
x + 10
10/x
x^2

x = c(11, 3, 4, 20, 5)
x
length(x)
sum(x)
mean(x)
var(x)
sd(x)
range(x)
sum( ((x - mean(x))^2 ) / ( length(x) - 1))
min(x)
max(x)
median(x)
which.max(x)
which.min(x)
which(x)
which(x > 10)
which(x > 10 & x < 15)


