# day 18
library(tidyverse)
getwd()
setwd("/Users/knu_cgl1/Desktop/Study/Obsidian/R_study/scripts/data")
load("advancedDataMgmt.RData")
class1
class2

### rbind()
rbind(class1, class2)
rbind(select(class1, -Address), class2)
rbind(select(class1, -Address), rename(class2, Midterm = Mid, Gender = Gen))

### bind_rows()
bind_rows(class1, class2)

### rbind() vs bind_rows()
class12 <- bind_rows(select(class1, -Address),
                     rename(class2, Midterm = Mid, Gender = Gen))
class12

bind_rows(select(class1, -Address),
          rename(class2, Midterm = Mid, Gender = Gen),
          .id = "Class")
dfs = list(select(class1, -Address), rename(class2, Midterm = Mid, Gender = Gen))
bind_rows(dfs)
bind_rows(dfs, .id = "Class")


attendance
class12.a <- bind_cols(arrange(class12, ID), select(attendance, -ID))
class12.a

class12.b <- bind_cols(class12,
                       attendance %>% arrange(Class, ID) %>% select(-ID))
class12.b


### inner_join()
inner_join(class12, attendance)
inner_join(class1, attendance, by="ID")

### outer_join()
x <- data.frame(id=1:3, name = letters[1:3]); x
y <- data.frame(id=2:4, addr = LETTERS[2:4]); y
inner_join(x, y)
left_join(x,y)
right_join(x,y)
full_join(x,y)
right_join(class1, attendance, by="ID")


pjt
class12.c <- inner_join(class12.a, pjt, by="Team")
class12.c


cAge
cIncome
inner_join(cAge, cIncome, by="first.name")
inner_join(cAge, cIncome, by=c("last.name", "first.name"))
