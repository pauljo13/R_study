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

apply(A, 2, range)
apply(A, 1, range)
apply(A, 1, summary)


# arrange
x <- 11:20; x
x[1]
x[6:7]
x <- matrix(11:19, nrow = 3, ncol = 3); x
x[1,2]
x[2:3, 1]

### array()
x <- array(11:28, dim = c(3,3,2)); x

x[2, 1, 1]
x[2, 1, 2]
x[1, 2:3, 2]
x <- array(11:19, c(3,3)); x

### 3 dimension
x <- array(1, dim = c(2, 3, 2));x
x <- array(1:6, dim = c(3, 3, 2));x
x <- array(1:5, dim = c(3, 3, 2));x
x <- array(1:30, dim = c(3, 3, 2));x

### 4 dimension
y <- array(1:30, dim = c(2, 3, 2, 2)); y

### array is vector
typeof(x)
class(x)
attributes(x)

x <- 1:12
dim(x)
x
dim(x) <- c(3,4)
x
dim(x) <- c(2, 3, 2)
x
dim(x) <- NULL
x

### dimnames & dimanmes()
dim(x) <- c(2, 3, 2)
dimnames(x) <- list(c("A", "B"),
                    paste("group", 1:3, sep="-"),
                    c("Male", "Female")); x
attributes(x)

## array operation and filtering
a <- array(1:8, c(2, 2, 2)); a
b <- array(10^(0:7), c(2,2,2)); b
a + b
a * b
d <- array(11:30, c(2, 3, 2)); d
a + d
2 * a
1:2 * a

##### drop
x
x[ , , 2]
x[1, 2:3, 2]
x[1, 2:3, 1:2]
x[1, 2:3, 1:2, drop=F]
x[,-2,c(T,F)]
x["A", "group-2", "Female"]

# matrix multiplication
A <- array(1:4, c(2,2)); A
B <- array(10^(0:3), c(2,2)); B
A * B
B * A
A %*% B
B %*% A

x <- c(1,1)
x %*% A
A %*% x
x %*% A %*% x


# diagonal
A
diag(A)
diag(1:4)
diag(3)
diag(3, nrow = 2)

# simultaneous equations & inverse matrix
A <- matrix(c(2, -2, -3, 4), nrow = 2, ncol = 2); A
b <- c(5, -4); b
x <- solve(A, b); x
A %*% x

A.inverse <- solve(A); A.inverse
A %*% A.inverse
A.inverse %*% b


# eigenvalues & eigenvectors
A
ev <- eigen(A); ev
ev$values
ev$vectors
eigen(A, only.values = TRUE)
