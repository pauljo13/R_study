# Day 3
## simple operation 2
### paste()
paste(2024, 3)

paste("March", 11, 2024)

paste(2024, 11, 22, sep = "-")

paste(2024, 11, 22, sep = "/")

paste(2024, 11, 22, sep = "")


### strsplit()
strsplit("2024-12-22", split = "-")

strsplit("2016-01-22 11:16:34", split = ":")

strsplit("2016-01-22 11:16:34", split = "16")

strsplit("2016-01-22 11:16:34", split = "[- :]")

strsplit("2016-01-22 11:16:34", split = "[- : 6]")

strsplit("2016-01-22 11:16:34", split = "[- , : ]")



# Variable & Assignments
x <- 5
y = 6

# variable operation
x + 2
x * 2
x^2
x

# reassignments
x <- 7
x + 2

x*2

x^2

2^x

# reassignments operation
x

x <- x + 1; x
x

x <- 2 + x; x
x

x <- x*2; x
x

x <- x^2; x
x

y = 2 * x
y

# rm()
x; y

rm(x, y)
x
y


# ls() 

a = 5
b = 7
ls()

rm(list = ls())
ls()


# assign()
x1
assign("x1", 5)
x1

assign("x1", x1+3)
x1
x1


# function
sqrt(4)

(sqrt(9) + 2) / 4

sin( (sqrt(9) + 2) / 4)


# ceiling(), floor(), trunc(), round()
a = 3.141593
ceiling(a)
floor(a)
trunc(a)
round(a)
round(a, digits = 2)


# factorial & combination
factorial(5)
factorial(30)

format(factorial(30), scientific = FALSE, )

choose(5, 2)

choose(45, 6)
