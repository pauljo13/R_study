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


# rank()
x
rank(x)

# sort()
sort(x)

# order(x)
order(x)



# Logic vector
a = c(T, F, T); a
a

## comparison operations
y = 1:5
y > 3
y >= 3
y < 5
y <= 5
y == 2
y != 2

# logic operations
b = !a; b
a & b
a | b

# logic vector funtion
any( c(F, F, F))
any( c(F, F, T))

all( c(F, F, T))
all( c(T, T, T))

c = cars$dist
c
any(c > 100)
any(c > 200)

all(c > 5)
all(c > 0) # for checking data errors


# ifelse()
x = c(T, F, F, T, F)
a = 1:5
b = -1:-5
y = ifelse(x, a, b); y

y = ifelse(y > 0, y, 0)
y

y > 0
