# make list and filtering
a <- list(name="Fred", age=43, wife="Mary",
          no.children= 3, child.ages=c(4, 7, 9), is.house.owner=T)
a

typeof(a)
length(a)
attributes(a)
names(a)

a2 <- list(1:5, letters[1:8], LETTERS[1:3]); a2

var1 <- 1:3
var2 <- 4:6
cbind(var1, var2)
data.frame(var1, var2)
list(var1, var2)
list(var1=var1, var2=var2)

a[[3]]
a$wife
a[["wife"]]

a[[5]]
a[[5]][2:3]
a$child.ages[2:3]

a$no
a$child

a[1:3]
a[-(4:5)]
a[c("wife", "child.ages")]
a[c(T, F, F)]

a[[5]]
a[5]
a[[5]][2:3]
a[[5]]*7
a[5][2:3]
a[5]*7
