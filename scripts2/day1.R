# Biology
# What is R
my.data = 'abc'
my_data <- 'def'
print(my_data)
my_data1 <- 'ghi'
1my_data <- 'jkl'

# Variable assignment
a = 'equal'
b <- 'left'
'right' -> c

# Arithmetic operators
1 + 2
1 - 2
2 * 3
2 / 3
11 %/% 5
2 ^ 3
11 %% 5

# Basoc data type
class(100L)
class(100)
class("100")
class("100" == 100)
class(TRUE)
class(1i+1)

# Change the data type of variables
a <- '2'
class(a)
b <- as.numeric(a)
class(b)
c <- as.integer(b)
class(c)
as.integer('abc')

# Quiz
a <- log2(128)
b <- log2(256)
a / b


# String(character)
"This is a string"
'This is a string'
print('I love "R"')
print('I love 'R'')
print("I love \"R\"")

# paste() : To concatenate strings
a = 'I'
b = 'love'
c = 'R'
a + b + c
paste(a, b, c, sep = ' ')
paste(a, b, c, sep = '_')
paste(a, b, c, sep = '')
d = 123
paste(a, b, c, d,  sep = '.')
paste(1:10, 'a')
paste(1:10, 'a', sep = '_')
paste(1:10, 'a', sep = '_', collapse = "/")

# Quiz
idx.string = paste('Index', 1:5, sep = ": ", collapse = ", ")
idx.string
