# Matrix 2
## Matrix operation
A <- matrix(1:9, nrow = 3, ncol = 3); A
B <- matrix(seq(from=10, length=9, by=10), nrow = 3, ncol = 3); B
A + B
B - A
A * B
B / A

C <- cbind(A, 10:12); C
B + c
C <- rbind(A, 1:3); C
B * C

a <- 9:1
a + A
a <- c(0, 10, 100)
a + A
A * a
10 * A
b <- 1:10
b * A


## function
A <- matrix(1:4, nrow = 2, ncol = 2); A
t(A)

nrow(A)
ncol(A)
dim(A)
attributes(A)

rownames(A)
colnames(A)
rownames(A) <- c("upper", "lower")
colnames(A) <- c("left", "right")
A
attributes(A)

X <- rbind(1:5, 5:1); X
x <- as.vector(X); x
attributes(x)
y <- c(X); y
attributes(y)

sum(X)
mean(X)
sd(X)
range(X)

### apply()
set.seed(123)
a <- sample(1:25); a
A <- matrix(a, nrow = 5, ncol = 5); A
apply(A, 2, sum)
apply(A, 1, sum)
sum(A)
colnames(A) <- LETTERS[1:5]
rownames(A) <- paste("X", 1:5, sep = "")
A
apply(A, 1, min)
apply(A, 2, max)
