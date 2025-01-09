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
