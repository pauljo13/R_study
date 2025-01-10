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

cat("--------------------------------------------------\n")
# dplyr
library(tidyverse)
mpg

### filter()
filter(mpg, manufacturer=="hyundai")
filter(mpg, cty> 28)
filter(mpg, cty >= 28)
filter(mpg, sqrt(cty) < 3.2)

filter(mpg, manufacturer=="hyundai", cty>=20)
filter(mpg, manufacturer=="hyundai", cty>=20, displ >= 2.4)

filter(mpg, model=="sonata" | cty >= 28)
filter(mpg, model=="sonata" | cty >= 28, year == 2008)
filter(mpg, (model=="sonata" | cty >= 28) & year == 2008)
filter(mpg, model=="sonata" | cty >= 28 & year == 2008)

filter(mpg, year==2008, hwy >= 28, model == "sonata"| model == "corolla" | model == "jetta")
a <- 1:3
0 %in% a
1 %in% a
3 %in% a
filter(mpg, year==2008, hwy >= 28, model %in% c("sonata", "corolla", "jetta"))


# silce()
a <- filter(mpg, manufacturer == "hyundai", year == 2008); a
slice(a, 1)
slice(a, 1:3)
slice(a, 1:3, 6:7)
slice(a, -1)
slice(a, -1, -(4:6))

slice_sample(a, n=3)
slice_sample(a, prop = 0.8)

slice_head(mpg, n=4)
slice_tail(mpg, prop=0.05)

slice_min(a, cty, n=2)
slice_min(a, hwy, n=2)
slice_max(a, hwy, n=2)


# arrange()
a <- filter(mpg, manufacturer == "hyundai", year == 2008)
a
arrange(a, cyl)
arrange(a, cyl, cty)
arrange(a, model, trans)

arrange(a, desc(cyl))
arrange(a, desc(cyl), cty)
arrange(a, model, desc(trans))

# select()
select(a, model, year, cty, hwy)
select(a, model:trans)
select(a, model:trans, cty:hwy)

select(a, -(model:trans))
select(a, -(model:trans), -manufacturer)

select(a, 1:3)
select(a, 1:3, 5)
select(a, -(4:10))

select(a, starts_with("c"))

select(a, where(is.character))
select(a, where(function(x) is.numeric(x) && mean(x) >= 10))
select(a, where(~ is.numeric(.x) && mean(.x) < 10))

select(a, model, city=cty, highway=hwy)
rename(a, city=cty, highway=hwy)

select(a, cty, hwy)
select(a, hwy, cty)
select(a, cty, hwy, everything())


# mutate() 
b <- select(a, -(cyl:drv), -(fl:class)); b
mutate(b, sum=cty + hwy)
mutate(b,
       sum=cty + hwy,
       mean=(cty + hwy)/2,
       ratio= cty / hwy * 100)
### transmute()
transmute(b,
           sum=cty + hwy,
           mean=(cty + hwy)/2,
           ratio= cty / hwy * 100)

mutate(b, newName=paste(manufacturer, model, sep="-"), dis3=displ >= 3)
store <- data.frame(month=1:6, sales=c(23, 45, 34, 67, 30, 41)); store
mutate(store,
       before = lag(sales, n = 1),
       after = lead(sales, n = 1),
       total = cumsum(sales),
       mean = cummean(sales),
       rank1 = min_rank(sales),
       rank2 = min_rank(desc(sales)))
mutate(b, id = row_number())


# summarize()
summarize(b, count=n(), mean=mean(cty), med=median(cty), 
          min=min(cty), max=max(cty))
summarize(b, meanCty=mean(cty), meanHwy=mean(hwy),
          medianCty=median(cty), medianHqy=median(hwy))

summarize(b, across(c(cty, hwy), mean))
summarize(b, across(c(cty, hwy), list(mean=mean, med=median)))
summarize(b, 
          across(c(cty, hwy), list(mean=mean, med=median), .names="{.fn}-{.col}"))
summarize(b, across(c(cty, hwy), mean, .names="mean-{.col}"),
          across(c(cty, hwy), median, .names="med-{.col}"))
summarize(b, across(where(is.numeric), sd))


# group_by()
byModel <- group_by(b, model)
summarize(byModel, count=n(), mean=mean(cty), sd=sd(cty))
byModel
byModel <- group_by(a, model, cyl)
summarize(byModel, count=n(), mean=mean(cty))


mutate(b, rank=min_rank(desc(hwy)))
mutate(byModel, rank=min_rank(desc(hwy)))


##### count()
byModel <- group_by(b, model)
summarise(byModel, n=n())
count(b, model)
count(mpg, class)
count(mpg, class, sort = TRUE)
count(mpg, class, cyl, sort = T)


# pipe operator
byModel <- group_by(mpg, model, year)
meanCty <- summarize(byModel, count=n(), mean=mean(cty))
filter(meanCty, mean >= 22)
filter(summarize(group_by(mpg, model, year), count=n(), mean=mean(cty)), mean >= 22)

mpg %>% group_by(model, year) %>%
  summarize(count=n(), mean=mean(cty)) %>%
  filter(mean >= 22)

b %>% group_by(model) %>% 
  summarize(count=n(), mean=mean(cty)) %>% filter(mean >= 20)


byModel <- b %>% group_by(model) 
byModel %>% summarize(count=n())

byModel %>% ungroup() %>% summarize(count=n())
