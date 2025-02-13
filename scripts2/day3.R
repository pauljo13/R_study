# Day 3
# If and loop in R
## If...else if...else
a <- TRUE
if (a) {
  print('a is true')
}

a <- 5
threshold <- 3
if (a > threshold) {
  print(sprintf('a is greater than %s', threshold))
}

b <- seq(1, 10, by=2)
if (a %in% b) {
  print(sprintf('a is one of %s', paste(b, collapse = ", ")))
}

c <- 1:5
d <- 6:10
if (c %in% b) {
  print(sprintf('%s is in b', c[1]))
}

a <- 5
if (a < 0) {
  print('a is a negative number')
} else (
  print('a is not a negative number')
)

# Quiz
a <- sample(1:10, 1)
if (a %% 2 == 0) {
  print(sprintf('a = %d, is an even number', a))
} else {
  print(sprintf('a = %d, is an odd number', a))
}

# if else in a single line
a <- sample(1:10, 1); a
if (a %% 2 == 1) {
  b <- a + 1 
} else {
  b <- a
}; b

if (a %% 3 == 2) b <- a + 1 else b <- a; b
b <- if (a %% 2 == 1) a + 1 else a; b
b <- ifelse(a %% 2 == 1, a + 1, a); b

# Quiz
x <- sample(1:100, 1); x
y <- sample(1:100, 1); y
a <- ifelse(x > y, x, y);a

# if else if else
if (x > y) {
  a <- x
} else if (x == y){
  a <- x
  print('x is equal to y')
} else {
  a <- y
}
a

# Quiz
book <- 10000.0
coffee <- 3000.0
candy <- 500.0

budget <- 4500
myItem <- c()
if (budget >= book) {
  myItem <- c(myItem, 'book')
} else if (budget >= coffee) {
  myItem <- c(myItem, 'coffee')
} else if (budget >= candy){
  myItem <- c(myItem, 'candy')
} else {
  print('there is nothing I can buy')
}; myItem


# While
n <- 10
i <- 0
while (i < n) {
  i = i + 2
  print(i)
}

## Infinite loop
a <- TRUE
while (a) {
  print("if you want to escape the loop, press 'cmd + .'")
}

# Nested while loops
i <- 0
while (i < 5){
  i = i + 1
  j <- 0
  while (j < i){
    j <- j + 1
    print(sprintf('i = %d, j = %d', i, j))
  }
} 

# while + if
n <- 10
i <- 0
oddL <- c()
evenL <- c()
while (i < n) {
  i <- i + 1
  if (i %% 2 == 1) {
    oddL <- c(oddL, i)
  } else {
    evenL <- c(evenL, i)
  }
} ; oddL; evenL

# Quiz
s <- 0
i <- 0
while (i < 101){
  i <- i + 1
  if (i %% 7 == 0){
    s <- s + i
  }
}; s

# Break : statement terminates the loop
i <- 3
while (TRUE) {
  i <- i - 1
  if (i < 0){
    break
  } else {
    print(i)
  }
}

# Quiz
myVec <- c('watermelon', 'banana', 'apple', 'tomato', 'peach')
vege_list <- c('tomato', 'carrot', 'radish')
i <- 0
while (TRUE) {
  i <- i + 1
  if (myVec[i] %in% vege_list) {
    break
  } else {
    print(myVec[i])
  }
}

# next : statement skip the code inside the loop
i <- 0
while (i < 10) {
  i <- i + 1
  if (i %% 2 == 1) {
    next
  }
  print(i)
}

# Quiz
myVec <- c('watermelon', 'banana', 'apple', 'tomato', 'peach')
vege_list <- c('tomato', 'carrot', 'radish')
i <- 0
while (i < length(myVec)) {
  i <- i + 1
  if (myVec[i] %in% vege_list) {
    next
  } else {
    print(myVec[i])
  }
}

# For, repeat
for (i in seq(2, 10, by=2)) {
  print(i)
}

n <- 10
i <- 0
oddL <- c()
evenL <- c()
while (i < n) {
  i <- i + 1
  if (i %% 2 == 1) {
    oddL <- c(oddL, i)
  } else {
    evenL <- c(evenL, i)
  }
}; oddL; evenL
oddL <- c()
evenL <- c()
for (i in 1:10) {
  if (i %% 2 == 1) {
    oddL <- c(oddL, i)
  } else {
    evenL <- c(evenL, i)
  }
}; oddL; evenL

# Quiz
myVec <- c('watermelon', 'banana', 'apple', 'tomato', 'peach')
vege_list <- c('tomato', 'carrot', 'radish')
for (i in 1:length(myVec)) {
  if (myVec[i] %in% vege_list) {
    print(sprintf('%s : %d', myVec[i], i))
  }
}

# repeat 
i <- 0
repeat {
  i <- i + 2
  print(i)
  if (i >= 10) {
    break
  }
}

# Quiz
