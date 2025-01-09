# Day 12
## Make data frame
name <- c("Kim", "Lee", "Hung", "Joe", "Kaung")
grade <- c(1, 4, 3, 2,1)
gender <- c("M", "F", "M", "F", "M")
student <- data.frame(name, grade, gender)
student

mindterm = c(74, 82, 67, 89, 92)
final = c(91, 77, 88, 78, 86)
scores = cbind(mindterm, final); scores

rt <- c(TRUE, FALSE, FALSE, TRUE, FALSE)
students <- data.frame(student, scores, retake = rt)
students

total.scores <- mindterm + final ; total.scores
cbind(students, total.scores)

a <- data.frame(name="Jane Eyre", grade=4, gender="F",
                mindterm=90, final=85, retake=F); a
rbind(students, a)


# Specifying each column of a data frame
typeof(students)
attributes(students)

students$gender
students[["mindterm"]]
students$mindterm[5] <- 50
students[[4]][3:5]
students$hw <- c(8, 9, 7, 8, 10); students

# Filtering a data frame
students.new <- students[1:2]
students.new
students.new <- students[-(1:2)]
students.new
student.new <- students[c("gender", "grade")]
student.new
student.new <- students[c(T, F, F, T, T, F)]
student.new
height <- c(172, 167, 181, 162, 178)
students.new <- data.frame(students[2:3], height=height)
students.new

a <- student[2]; a
typeof(a)
attributes(a)
a <- students[[2]]; a
typeof(a)
attributes(a)

students[1,]
students[2:3, ]
students[-(2:3), ]
students[ ,4]
students[ ,-4]
students[ ,c(2, 4)]
students[2:4, 3:5]
students$mindterm >= 80
students[students$mindterm >= 80, ]
students[students$mindterm >= 80, c("name", "grade", "gender")]
students[students$grade != 1, c("name", "grade", "gender")]

order(students$grade)
students[order(students$grade), ]
order(students$final, decreasing = TRUE)
students[order(students$final, decreasing = TRUE), ]
order(students$grade, students$final)
students[order(students$grade, students$final), ]
students[order(students$grade, students$final, decreasing=T), ]
students[order(students$grade, -students$final), ]

### subset()
x <- c(7, 9, NA, 5, 2)
x[x>6]
subset(x, x>6)
y <- 1:5
z <- -1 : -5
long.name <- data.frame(x, y, z); long.name
rm(x, y, z)
long.name[long.name$x > 6, ]
subset(long.name, x>6)
long.name[long.name$x >6, 2:3]
subset(long.name, x>6, y:z)
long.name[long.name$x >6, c("x", "z")]
subset(long.name, x>6, c(x, z))
subset(long.name, x>6, -z)

