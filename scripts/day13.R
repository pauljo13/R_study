# Day 13
## Data frame and function
name <- c("kim", "young", "lee", "joe", "kung")
grade <- c(1, 4, 3, 2, 1)
gender <- c(" M", "F", "M", "F", "M")
student <- data.frame(name, grade, gender)
student
midterm = c(74, 82, 67, 89, 92)
final = c(91, 77, 88, 78, 86)
scores = cbind(midterm, final)
rt <- c(TRUE, FALSE, FALSE, TRUE, FALSE)
students <- data.frame(student, scores, retake = rt)
students
students$hw <- c(8, 9, 7, 8, 10)

### list function
lapply(students[4:5], mean)
sapply(students[4:5], mean)
sapply(students[4:5], summary)

### Matrix function
nrow(students)
ncol(students)
t(students)

### apply()
apply(students, 2, mean)
apply(students[4:5], 2, mean)
apply(students[4:5], 1, sum)

nrow(iris)
head(iris)
tail(iris)
head(iris,n = 3)
tail(iris,n = 3)


# File lord
setwd("/Users/knu_cgl1/Desktop/Study/Obsidian/R_study/scripts/courses2")
WD <- getwd(); WD
# setwd(file.path(WD, "data"))
files_list <- list.files(pattern = "txt")
prov.scores <- read.table("scores.txt", header = TRUE, fileEncoding = "UTF-8")
prov.scores
attributes(prov.scores)
prov.scores <- read.table(files_list[2], header = FALSE, fileEncoding = "UTF-8")
prov.scores
prov.scores.new <- edit(prov.scores)

setwd("/Users/knu_cgl1/Desktop/Study/Obsidian/R_study/scripts")
sr <- read.csv(file = "suicide_rates.csv", fileEncoding = "UTF-8")
nrow(sr)
head(sr)
sr2 <- read.table(file = "suicide_rates.csv",header = TRUE, sep=",", fileEncoding = "UTF-8")
nrow(sr2)
head(sr2)

setwd("/Users/knu_cgl1/Desktop/Study/Obsidian/R_study/scripts/courses2")
prov.scores <- read.table("scores.txt", header=TRUE, fileEncoding="UTF-8")
prov.scores
prov.scores.csv <- read.csv("scores.txt", fileEncoding="UTF-8")
prov.scores.csv
mean(prov.scores$scores)
mean(prov.scores.csv$scores)
ncol(prov.scores)
names(prov.scores)
ncol(prov.scores.csv)
names(prov.scores.csv)

# write data.frame
sr$Avg <- (sr$Males + sr$Females) / 2
head(sr)
write.csv(sr, file = "sr.csv")
setwd("/Users/knu_cgl1/Desktop/Study/Obsidian/R_study/scripts/data")

students
write.table(students, "students.txt", row.names = FALSE, fileEncoding = "UTF-8")
write.csv(students, "students.csv", row.names = FALSE, fileEncoding = "UTF-8")
write.csv(students, "students_rn.csv", row.names = TRUE, fileEncoding = "UTF-8")

read.table("students.txt", header=TRUE, fileEncoding="UTF-8")
read.csv("students.csv", header=TRUE, fileEncoding="UTF-8")
write.table(students, "students.csv", sep=",", row.names=FALSE, fileEncoding="UTF-8")
write.table(students, "students_rn.csv", sep=",", row.names=TRUE, fileEncoding="UTF-8")


x <- 1:3; x
y <- matrix(4:12, nrow = 3, ncol = 3); y
z <- data.frame(x,y); z
save(x, y, z, file = "xyz.RData")

rm(x, y, z)
x; y; z

load("xyz.RData")
x; y; z


# Data frame
search()
obj <- ls()
rm(list = obj[which(obj = "students")])
ls()
rm(obj)
ls()
retake
attach(students)
retake
search()
retake[1] <- NA; retake
students$retake
students$retake[5] <- NA
students$retake
retake


detach(students)
search()
