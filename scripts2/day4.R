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
sink(file = 'test4.txt')
cat(c('line1', 'line2'), sep = '\n')
sink()

sink(file = 'test5.txt')
print('line1\nline2')
sink()
file.show('test5.txt')

sum_vals <- apply(myMat2, 2, sum); sum_vals
sumVec <- paste('the sum of column', seq_along(sum_vals), ': ', sum_vals, sep = "")
sink(file = 'test_sink.txt')
cat(sumVec, sep = "\n-----------------------\n")
sink()
file.show('test_sink.txt')


# Writing a data frame (matrix)
myMat <- matrix(paste("v", 1:9, sep=""),nrow = 3)
myMat
write.table(myMat, file='test_mat1.txt', sep='\t')
file.show('test_mat1.txt')

write.table(myMat, file = 'test_mat2.txt', sep = ',', quote = F)
file.show('test_mat2.txt')

write.table(myMat, file = 'test_mat3.txt', sep = '\t',row.names = F)
file.show('test_mat3.txt')


# Quiz
alp = c('a','b','c','d')
quiMat <- c()
for (i in alp) {
  quiMat <- cbind(quiMat, paste(i, 1:5, sep=""))
}; quiMat
colnames(quiMat) <- paste('myCol', 1:4, sep = "_")
write.table(quiMat, file = 'test_mat_quiz.csv', sep = ',', row.names = F)
file.show('test_mat_quiz.csv')

# Read lines - readLines()
fileConn <- file("test_mat2.txt",open = "rt")
readLines(fileConn)
close(fileConn)

readLines('test_mat1.txt')
readLines('test_mat1.txt', n=1)

# read.table()
myDf <- read.table('test_mat3.txt', sep = '\t'); myDf
myDf <- read.table('test_mat3.txt', sep = '\t', header = T); myDf
myDf <- read.table('test_mat2.txt'); myDf
myDf <- read.table('test_mat2.txt', sep = ","); myDf

fileConn <- file('test_mat4.txt', open = "wt")
writeLines(c('line1', 'line2','#end of line'), con = fileConn)
close(fileConn)

write.table(myMat, file = 'test_mat4.txt', sep = '\t', row.names = F, col.names = F, append = T)
file.show('test_mat4.txt')

myDf <- read.table('test_mat4.txt'); myDf
myDf <- read.table('test_mat4.txt', header = F, sep = "\t", skip = 3); myDf
myDf <- read.table('test_mat4.txt', header = F, sep = "\t", skip = 2, comment.char = "#"); myDf


# Quiz
rowname <- c('a','b','c','d','e','f')
col1 <- c(paste(rowname, 1, sep = "")); col1
col2 <- character(6)
mat <- c()
for (i in 1:6) {
  c <- i:(i+4) 
  mat <- rbind(mat,c)
}; mat
colnames(mat) <- paste('col',3:7,sep = "")

Mat <- cbind(rowname, col1, col2, mat)
write.table(Mat, file = 'test_mat_quiz2.txt', sep = '\t', row.names = F)
file.show('test_mat_quiz2.txt')

myDf <- read.table('test_mat_quiz2.txt',sep='\t', header = T, row.names = 'rowname'); myDf
apply(myDf[,3:7], 2, mean)