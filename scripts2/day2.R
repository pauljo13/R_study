# day 2.
## Get character length of a string
### nchar() : To get the number of characters in a text
a <- 'I love R'
length(a)
nchar(a)

## Sunstring
a[1]
substring(a, 1,1)
substring(a, 3,6)

## String formatting
### sprintf() : returns a character vector containing a formatted combination of text and variable values.
sprintf('I need to study Python%d', 2)
sprintf('I need to study Python%f', 2.7)
sprintf('I need to study Python%s', 2.7)
sprintf('I need to study Python%.1f', 2.7)
sprintf('humans share about %s%% of DNA with chimpanzees', 99)

## String formatting
lang = 'Python'
ver = '2.7'
paste('I need to study ', lang, ver, sep = '')
sprintf('I need to study %s%s', lang, ver)
sprintf('I need to study %s%.2f', lang, as.numeric(ver))

# Quiz
circ = 'pi'
pi
sprintf("The ratio of a circle's circumference to its diameter is called %s, and the value of %s is %.2f", circ, circ, pi)


# R data structure
# Vector : A vector is a sequence of data elements of the same basic type.
## Creating a vector
### c() : make vector
a = c(1, 2, 3)
b = c('abc', 'def')
c = c('abc', 1, 2, 3)
d = c(1,2,3,c('1', '2', '3'))
1:10
1:-10

#seq(from = 1, to = 1, by = ((to - from)/(length.out - 1)), length.out = NULL, along.with = NULL, ...)
##length.out: desired length of the sequence
##along.with: take the length from the length of an argument
seq(2,10)
seq(2,10,by=2)
seq(2,10, length.out = 3)
seq(2, 10, along.with = c(1,2,2,3))
length(c(1,2,2,3))

rep(1:4)
rep(1:4, times=2)
rep(1:4, length.out=5)
rep(1:4, each=2)
rep(1:4, each=2, times=3)
rep(1:4, c(3,1,2,1))

#Operators in vector
v1 = c('a', 'b', 'c')
v2 = c(1, 2, 3, 4)
v3 = 1:2
v1 + v2
v1 * 2
c(v1, v2)
rep(v1, 2)
v2 + v3
v2 * v3
v2 - v3
v2 / v3

# Logical operators
a = c(TRUE, FALSE, 1, 0)
b = c(TRUE, TRUE, TRUE, TRUE)
c = c(F, F, F, F)
d = c(0, 1, F, T)
!a
a & b
a && b
a & c
a && c
a | b
a || b
c | d

# Access elements in a vector
a = paste('vector', 1:5, sep='')
a
a[1]
a[5]
a[c(1,3)]
a[1:3]
a[6]

# Access elements in a vector
a[c(T, F, T, F, T)]
a = -3:3
a > 0
a[a>0]
a[!(a>0)]
a[a==1]
a[a %in% seq(-3,1)]
which(a > 0)
a[which(a > 0)]
which(!(a %in% c(1,0)))

# Name the elements in a vector
names(a)
b <- paste('vector', seq_along(a), sep = "")
b
names(a) <- b
names(a)
a
a['vector1']
a['vector5']
a[c('vector1', 'vector3')]
a[7] <- 7;a
a[a < 0] <- 0;a
a['vector3'] = '3';a
a2 <- a[-1]; a2
a2 <- a[1:3]; a2

# Quiz
myVec <- paste('vec', rep(1:3,each=2),sep = " ")
myVec
names(myVec)[2] <- "rep.of.vec1"
myVec
names(myVec)
myVec[5] <- "0"; myVec
myVec = myVec[-1]; myVec

# Factor
v1 = c('C', 'T', 'C', 'C', 'A', 'G', 'C')
is.vector(v1)
is.factor(v1)
f1 = as.factor(v1)
f1
f2 = factor(f1, levels=c('A', 'T','C','G'))
f2
f2[1] = 'N'
f2

myVec = c('watermelon','banana','apple','tomato','peach')
myFac = factor(myVec, levels = myVec)
myVec
myFac

# Matrix
matrix(c(1:8), nrow = 2)
matrix(c(1:8), nrow = 3, byrow = T)
matrix(c(1:8), nrow = 2, byrow = T)

# Creating a matrix
## cbind()/rbind()
a1 = 1:4
a2 <- 5:8
m1 <- cbind(a1, a2);m1
m2 <- rbind(a1, a2);m2
dim(m2)
dim(m1)
cbind(m2, a1)

matrix(c(1:8), nrow=2, byrow = T, dimnames = list(c('r1','r2'),c(paste('c',1:4,sep = ""))))
rownames(m1) <- c(paste('r', 1:4, sep = ''))
colnames(m1) <- c('c1', 'c2')
m1
rownames(m1)[2] <- 'row2'
m1

#Access elements in a matrix
m1
m1[1,]
m1[4,1]
m1[2:3,2]
m1[,2]
m1['row2',]
m1['row2',][2]
m1 > 3
which(m1 > 3)
which(m1 > 3, arr.ind = T)
m1[m1 > 3] = 10
m1

# Matrix computations
m1 <- matrix(1:9, nrow=3); m1
m2 <- matrix(1:9, nrow = 3, byrow = T); m2
m1 + m2
m1 * m2
m1 * 0

# Quiz
