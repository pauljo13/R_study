# Matrix
### matrix()
n <- 1:10; n
m <- matrix(n, nrow = 2, ncol = 5); m
m <- matrix(n, nrow = 2); m

matrix(n, nrow = 2, ncol = 5, byrow = T)

### dim, attributes()
attributes(n)
attributes(m)

m <- matrix(n, nrow = 5, ncol = 2); m
attributes(m)

m <- matrix(1:9, nrow = 3, ncol = 3); m
m <- matrix(1, nrow = 3, ncol = 3); m
m <- matrix(1:3, nrow = 3, ncol = 3); m
m <- matrix(11:30, nrow = 3, ncol = 3); m


### cbind() & rbind()
cbind(1:5, 10:6)
rbind(1:5, 10:6, 11:15)

A <- matrix(1:9, nrow = 3, ncol = 3); A
cbind(A, 10:12)
rbind(10:12, A)

cbind(A, A)
t <- rbind(A, 10:12); t
rbind(A, t)
cbind(A, t)
attributes(A)
attributes(t)

A <- cbind(1:6, 7:9); A
cbind(A, 10:11)
rbind(1, 1:5)


## Matrix filtering
z <- matrix(1:25, nrow = 5, ncol = 5); z
z[1,1]
z[5,5]
z[1:3, 1]
z[2, 1:3]
z[c(3,5) ,c(2,4)]
c(3,5)
c(2,4)
z[,2]
z[3,]
z[,c(3,5)]
z[,]

z[,-2]
z[-3,]
z[,-c(2,4)]
z[-3,-2]

z[5:1,]
z[,c(3:5, 1:2)]

a <- matrix(sample(1:16), nrow = 4, ncol = 4); a
a[,1]
order(a[,1])
a[order(a[,1]), ]

### logic index vector
height <- c(180, 172, 167, 175, 182)
weight <- c(72, 78, 58, 64, 68)
year <- c(1, 3, 2, 4, 2)
A <- cbind(height, weight, year)
A[ , c(F, T, T)]
A[ A[,1] > 180, ]
A[ A[,2] < 70, ]


### rownames() & colnames()
colnames(A)
rownames(A)
rownames(A) <- paste("student", 1:5, sep=""); A
A[,"year"]
A["student1",]
A["student2", "weight"]
A["student2", 2]


### vector filtering
z
z[10]
z[z>15]







