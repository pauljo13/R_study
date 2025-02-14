# Day 04
# User-defined function
helloworld <- function() {
  print('Hello, world')
}
helloworld()

echo <- function(whatever) {
  print(whatever)
}
echo('hi')

addsub <- function(x, y) {
  a <- x + y
  b <- x - y
  return(c(a, b))
}
addsub(10, 7)

addsub2 <- function(x, y) c(x+y, x-y)
addsub2(10, 7)

welcome <- function(x, y = "hello") {
  print(sprintf('%s, %s', y, x))
}
welcome('guys')

welcome_hj <- function(x = 'hj', y = 'hello') {
  print(sprintf('%s, %s', y, x))
}
welcome_hj()
welcome_hj('guys')
welcome_hj('guys', 'hi')

welcome_hj2 <- function(x = 'hj', y) {
  print(sprintf('%s, %s', y, x))
}
welcome_hj2('hi')
welcome_hj2('guys','hi')


# Quiz
sum_col <- function(x, y=1) {
  #myMat <- matrix(1:x, ncol = y)
  #return(apply(myMat, 2, sum))
  if (y > ncol(x))  {
    print(sprintf('%d is bigger than %s', y, ncol(x)))
  } else {
    return(sum(x[,y]))
  }
}
myMat2 <- c()
for (i in 1:9) {
  val <- 1:9 * i
  myMat2 <- rbind(myMat2, val)
}
colnames(myMat2) <- paste('V',1:9,sep = "")
rownames(myMat2) <- paste('Multiple',1:9,sep="_")
myMat2
sum_col(myMat2, 11)
sum_col(myMat2,8)

a <- apply(myMat2, 2, function(x) x+1)
a
b <- apply(myMat2, 2, function(x) {(x+1)/(x-1)} )
b

# Write & read
## Set current R working directory
getwd()
setwd("/Users/knu_cgl1/Desktop/Study/Obsidian/R_study/scripts2")
fileConn <- file('text1.txt', open="wt")
writeLines(c('line1', 'line2'), con = fileConn)
close(fileConn)
file.show('text1.txt')

# weiting lines - cat()
cat(c('line1', 'line2'), file = 'test3.txt', sep = "\n")
file.show('test3.txt')

# sink()
