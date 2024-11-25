# Vector 2
## Character vector
students = c("한국", "Allen", "Tom")
students

n = 1:3
n

### as.character(n)
num <- as.character(n)
num

### paste()
paste(students, num)

paste(students, num, sep="")

paste(students, num, sep = "-")

paste(students, 1:2)

paste(students, num, c("A", "B", "C"), "!")


### strsplit()
x <- c("2015-3-15 10:12:12", "2016-10-11 11:12:14", "2024-11-25 02:03:04")
x
strsplit(x, split = " ")

strsplit(x, split = "-")

strsplit(x, split = ":")

strsplit(x, split = c("-",":"," "))

### nchar()
nchar("Day")

a <- c("날짜", "day", "date", "day and time")
nchar(a)


## Missing Values
### is.na() & na.omit()
z <- c(11:13, NA)
z

is.na(z)

na.omit(z)


### na.rm
sum(z)

sum(z, na.rm = TRUE)

### NaN
1/0

Inf * 5

0/0

Inf - Inf

### is.nan()
z <- -1:1 / 0
z

is.na(z)

r <- c(z, NA)
r

is.na(r)

is.nan(r)


## Index vector & filtering
### natural index vector
x <- 11:20
x

x[6]

x[c(6, 10)]

x[seq(3, 9, by=2)]

x[rep(c(2,4), times=3)]

x[6, 10]


x <- c(7, 9, 4, 6, 13, 4, 1, 11)
x[which.min(x)]

x[which.max(x)]

x[which(x > 10)]

x[order(x)]


### negative integer index vector
x <- 11 : 20; x
x[-2]

x[c(-2. -4)]

x[-(3:6)]


### logical index vector
x = 1:5
y = c(T, F, T, T, F)
x[y]

x > 3
x[x>3]

x > 3 & x < 5
x[x > 3 & x < 5]

y <- c(TRUE, FALSE)
x[y]


### name index vector
animals <- c(5, 7, 3, 2)
names(animals) <- c("cats", "dogs", "camels", "donkeys")
animals

animals["camels"]

animals[c("dogs", "donkeys")]


### Assigning values to vector elements using index vectors
a <- 1:5; a

a[2] <- 20; a

a[c(3, 5)] <- c(100, 300); a

a[c(1, 3, 5)] <- -5; a

a[-1] <- 0; a

x <- c(NA, 2:4, NA) ; x

x[is.na(x)] <- 0 ; x

y <- c(-2, 0 , 4, -7, 8) ; y

y[y<0] <- -y[y<0]
y



